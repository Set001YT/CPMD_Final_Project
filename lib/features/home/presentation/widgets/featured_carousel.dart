import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_url_builder.dart';
import '../../domain/entities/movie.dart';

class FeaturedCarousel extends StatefulWidget {
  final AsyncValue<List<Movie>> moviesAsync;
  final void Function(Movie movie)? onMovieTap;

  const FeaturedCarousel({
    super.key,
    required this.moviesAsync,
    this.onMovieTap,
  });

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return widget.moviesAsync.when(
      loading: () => Shimmer.fromColors(
        baseColor: AppColors.surfaceDark2,
        highlightColor: AppColors.surfaceDark3,
        child: Container(height: 460, color: Colors.white),
      ),
      error: (e, _) => SizedBox(
        height: 460,
        child: Center(child: Text('Error: $e')),
      ),
      data: (movies) {
        final featured = movies.take(5).toList();
        if (featured.isEmpty) return const SizedBox.shrink();
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: featured.length,
              itemBuilder: (context, index, _) {
                return _FeaturedItem(
                  movie: featured[index],
                  onTap: widget.onMovieTap != null
                      ? () => widget.onMovieTap!(featured[index])
                      : null,
                );
              },
              options: CarouselOptions(
                height: 460,
                viewportFraction: 1.0,
                autoPlay: false,
                onPageChanged: (index, _) =>
                    setState(() => _current = index),
              ),
            ),
            const SizedBox(height: 12),
            AnimatedSmoothIndicator(
              activeIndex: _current,
              count: featured.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: AppColors.primary,
                dotColor: AppColors.borderDark,
                spacing: 6,
                expansionFactor: 3,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FeaturedItem extends StatelessWidget {
  final Movie movie;
  final VoidCallback? onTap;

  const _FeaturedItem({required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                ImageUrlBuilder.backdrop(movie.backdropPath, large: true),
            fit: BoxFit.cover,
            errorWidget: (_, _, _) => Container(color: AppColors.surfaceDark2),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(gradient: AppColors.heroGradient),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'TRENDING',
                    style: textTheme.labelSmall?.copyWith(
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  movie.title,
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: AppColors.accent, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      movie.formattedRating,
                      style: textTheme.titleSmall?.copyWith(color: Colors.white),
                    ),
                    if (movie.year.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Text(
                        movie.year,
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppColors.textSecondaryDark),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
