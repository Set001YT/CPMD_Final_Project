import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_url_builder.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_category.dart';
import '../providers/movie_list_provider.dart';

class MovieListPage extends ConsumerStatefulWidget {
  final MovieCategory category;
  const MovieListPage({super.key, required this.category});

  @override
  ConsumerState<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends ConsumerState<MovieListPage> {
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >=
        _scrollCtrl.position.maxScrollExtent - 400) {
      ref.read(movieListProvider(widget.category).notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieListProvider(widget.category));
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollCtrl,
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: cs.surface,
            title: Text(widget.category.title,
                style: textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ),

          // Initial loading
          if (state.isLoadingInitial)
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              sliver: _GridShimmer(),
            )

          // Initial error
          else if (state.error != null && state.movies.isEmpty)
            SliverFillRemaining(
              child: _ErrorView(
                message: state.error.toString(),
                onRetry: () => ref
                    .read(movieListProvider(widget.category).notifier)
                    .retry(),
              ),
            )

          // Grid of movies
          else ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.58,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _GridCard(movie: state.movies[index]),
                  childCount: state.movies.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: state.isLoadingMore
                      ? const CircularProgressIndicator(
                          color: AppColors.primary)
                      : !state.hasMore
                          ? Text("You've reached the end",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: cs.onSurfaceVariant))
                          : const SizedBox(height: 20),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GridCard extends StatelessWidget {
  final Movie movie;
  const _GridCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () =>
          context.push(AppRoutes.movieDetailPath(movie.id), extra: movie),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Hero(
                tag: 'poster-${movie.id}',
                child: CachedNetworkImage(
                  imageUrl: ImageUrlBuilder.poster(movie.posterPath),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (_, _) => Container(color: cs.surfaceContainer),
                  errorWidget: (_, _, _) => Container(
                    color: cs.surfaceContainer,
                    child: Icon(Icons.movie_outlined,
                        color: cs.onSurfaceVariant),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            movie.title,
            style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600, color: cs.onSurface),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.star_rounded,
                  size: 12, color: AppColors.accent),
              const SizedBox(width: 3),
              Text(movie.formattedRating,
                  style: textTheme.labelSmall
                      ?.copyWith(color: cs.onSurfaceVariant)),
              if (movie.year.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(movie.year,
                    style: textTheme.labelSmall
                        ?.copyWith(color: cs.onSurfaceVariant)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _GridShimmer extends StatelessWidget {
  const _GridShimmer();

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.58,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Shimmer.fromColors(
          baseColor: AppColors.surfaceDark2,
          highlightColor: AppColors.surfaceDark3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(color: Colors.white),
                ),
              ),
              const SizedBox(height: 6),
              Container(height: 12, width: 80, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 10, width: 50, color: Colors.white),
            ],
          ),
        ),
        childCount: 9,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 64, color: AppColors.textMutedDark),
            const SizedBox(height: 16),
            Text('Failed to load', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(message,
                style: textTheme.bodySmall
                    ?.copyWith(color: cs.onSurfaceVariant),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
