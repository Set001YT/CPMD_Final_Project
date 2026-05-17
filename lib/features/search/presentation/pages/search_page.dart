import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_url_builder.dart';
import '../../../../core/widgets/login_required.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../home/domain/entities/movie.dart';
import '../providers/search_providers.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authStateProvider).valueOrNull;
    final query = ref.watch(searchQueryProvider);
    final resultsAsync = ref.watch(searchResultsProvider(query));
    final textTheme = Theme.of(context).textTheme;

    if (authUser == null) {
      return const Scaffold(
        body: SafeArea(
          child: LoginRequired(feature: 'Search'),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Search', style: textTheme.headlineMedium),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                autofocus: false,
                textInputAction: TextInputAction.search,
                style: textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Movies, genres, actors...',
                  prefixIcon: const Icon(Icons.search_rounded,
                      color: AppColors.textMutedDark),
                  suffixIcon: query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: AppColors.textMutedDark),
                          onPressed: () {
                            _controller.clear();
                            ref.read(searchQueryProvider.notifier).state = '';
                          },
                        )
                      : null,
                ),
                onChanged: (v) =>
                    ref.read(searchQueryProvider.notifier).state = v,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _buildBody(query, resultsAsync, textTheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    String query,
    AsyncValue<List<Movie>> resultsAsync,
    TextTheme textTheme,
  ) {
    if (query.trim().length < 2) {
      return _EmptyPrompt(textTheme: textTheme);
    }

    return resultsAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (e, _) => Center(
        child: Text('Error: $e', style: textTheme.bodyMedium),
      ),
      data: (movies) {
        if (movies.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.movie_filter_outlined,
                    size: 64, color: AppColors.textMutedDark),
                const SizedBox(height: 16),
                Text('No results for "$query"', style: textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Try a different search term',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: AppColors.textSecondaryDark)),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: movies.length,
          separatorBuilder: (_, _) =>
              const Divider(color: AppColors.borderDark, height: 1),
          itemBuilder: (context, index) =>
              _SearchResultTile(movie: movies[index]),
        );
      },
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final Movie movie;
  const _SearchResultTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => context.push(AppRoutes.movieDetailPath(movie.id), extra: movie),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Hero(
              tag: 'poster-${movie.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: ImageUrlBuilder.poster(movie.posterPath),
                  width: 56,
                  height: 84,
                  fit: BoxFit.cover,
                  errorWidget: (_, _, _) => Container(
                    width: 56,
                    height: 84,
                    color: AppColors.surfaceDark2,
                    child: const Icon(Icons.movie_outlined,
                        color: AppColors.textMutedDark, size: 24),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.accent, size: 14),
                      const SizedBox(width: 4),
                      Text(movie.formattedRating,
                          style: textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondaryDark)),
                      if (movie.year.isNotEmpty) ...[
                        const SizedBox(width: 10),
                        Text(movie.year,
                            style: textTheme.bodySmall
                                ?.copyWith(color: AppColors.textMutedDark)),
                      ],
                    ],
                  ),
                  if (movie.overview.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        movie.overview,
                        style: textTheme.bodySmall?.copyWith(
                            color: AppColors.textMutedDark, height: 1.4),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.textMutedDark),
          ],
        ),
      ),
    );
  }
}

class _EmptyPrompt extends StatelessWidget {
  final TextTheme textTheme;
  const _EmptyPrompt({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.surfaceDark2,
              borderRadius: BorderRadius.circular(45),
            ),
            child: const Icon(Icons.search_rounded,
                size: 44, color: AppColors.textMutedDark),
          ),
          const SizedBox(height: 20),
          Text('Find any movie', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Type at least 2 characters to search',
            style: textTheme.bodyMedium
                ?.copyWith(color: AppColors.textSecondaryDark),
          ),
        ],
      ),
    );
  }
}
