import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../../../home/domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../providers/movie_detail_providers.dart';

class ActionButtons extends ConsumerWidget {
  final int movieId;
  final Movie movie;

  const ActionButtons({
    super.key,
    required this.movieId,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider).valueOrNull;
    final videosAsync = ref.watch(movieVideosProvider(movieId));
    final isFavAsync = ref.watch(isFavoriteProvider(movieId));
    final isFav = isFavAsync.valueOrNull ?? false;
    final controller = ref.read(favoritesControllerProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow_rounded, size: 24),
                label: const Text('Watch Trailer'),
                onPressed: () => _openTrailer(context, videosAsync),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 50,
              child: OutlinedButton.icon(
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                  size: 20,
                  color: isFav ? AppColors.primary : null,
                ),
                label: Text(isFav ? 'Saved' : 'Save'),
                style: isFav
                    ? OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: const BorderSide(color: AppColors.primary),
                      )
                    : null,
                onPressed: () async {
                  if (authUser == null) {
                    context.go(AppRoutes.login);
                    return;
                  }
                  try {
                    await controller.toggle(movie);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFav
                                ? 'Removed from favorites'
                                : 'Added to favorites!',
                          ),
                          backgroundColor: AppColors.surfaceDark2,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    }
                  } catch (e, st) {
                    debugPrint('Favorite toggle ERROR: $e\n$st');
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('DB Error: $e'),
                          backgroundColor: AppColors.error,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openTrailer(
    BuildContext context,
    AsyncValue<List<Video>> videosAsync,
  ) async {
    final videos = videosAsync.valueOrNull;
    final trailer = videos?.firstWhere(
      (v) => v.isYoutubeTrailer && v.official,
      orElse: () => videos.firstWhere(
        (v) => v.isYoutubeTrailer,
        orElse: () => const Video(
          id: '',
          key: '',
          name: '',
          site: '',
          type: '',
          official: false,
        ),
      ),
    );

    if (trailer == null || trailer.key.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No trailer available')),
        );
      }
      return;
    }

    final uri = Uri.parse(trailer.youtubeUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to open trailer')),
        );
      }
    }
  }
}
