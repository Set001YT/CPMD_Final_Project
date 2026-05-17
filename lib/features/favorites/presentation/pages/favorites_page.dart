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
import '../providers/favorites_providers.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider).valueOrNull;

    if (authUser == null) {
      return const Scaffold(
        body: SafeArea(child: LoginRequired(feature: 'Favorites')),
      );
    }

    final favoritesAsync = ref.watch(favoritesStreamProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: AppColors.bgDark,
            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: Text(
                'My Favorites',
                style: textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
            actions: [
              favoritesAsync.maybeWhen(
                data: (movies) => movies.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.delete_sweep_outlined),
                        tooltip: 'Clear all',
                        onPressed: () => _confirmClear(context, ref),
                      )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          favoritesAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(child: Text('Error: $e')),
            ),
            data: (movies) => movies.isEmpty
                ? const SliverFillRemaining(child: _EmptyState())
                : SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.62,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _FavoriteCard(movie: movies[index], ref: ref),
                        childCount: movies.length,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmClear(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceDark2,
        title: const Text('Clear all favorites?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(favoritesControllerProvider).clearAll();
    }
  }
}

class _FavoriteCard extends StatelessWidget {
  final Movie movie;
  final WidgetRef ref;

  const _FavoriteCard({required this.movie, required this.ref});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.movieDetailPath(movie.id),
        extra: movie,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cs.outline.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Hero(
                      tag: 'poster-${movie.id}',
                      child: CachedNetworkImage(
                        imageUrl: ImageUrlBuilder.poster(movie.posterPath),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorWidget: (_, _, _) =>
                            Container(color: AppColors.surfaceDark2),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => ref
                          .read(favoritesControllerProvider)
                          .remove(movie.id),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: cs.onSurface),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.accent, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        movie.formattedRating,
                        style: textTheme.bodySmall
                            ?.copyWith(color: cs.onSurfaceVariant),
                      ),
                      if (movie.year.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Text(
                          movie.year,
                          style: textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark2,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.favorite_outline_rounded,
                size: 48,
                color: AppColors.textMutedDark,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No favorites yet',
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the Save button on any movie\nto add it here.',
              style: textTheme.bodyMedium
                  ?.copyWith(color: AppColors.textSecondaryDark),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
