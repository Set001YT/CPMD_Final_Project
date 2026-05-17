import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_url_builder.dart';

class DetailSliverAppBar extends StatelessWidget {
  final int movieId;
  final String? backdropPath;
  final String? posterPath;
  final String? title;
  final String? rating;
  final String? year;

  const DetailSliverAppBar({
    super.key,
    required this.movieId,
    required this.backdropPath,
    required this.posterPath,
    this.title,
    this.rating,
    this.year,
  });

  @override
  Widget build(BuildContext context) {
    final backdropUrl = ImageUrlBuilder.backdrop(backdropPath);
    final posterUrl = ImageUrlBuilder.poster(posterPath);
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      expandedHeight: 380,
      pinned: true,
      backgroundColor: AppColors.bgDark,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (backdropUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: backdropUrl,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) =>
                    Container(color: AppColors.surfaceDark2),
              )
            else
              Container(color: AppColors.surfaceDark2),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x66000000),
                    Color(0x00000000),
                    Color(0x99000000),
                    Color(0xFF0A0A0F),
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Hero(
                    tag: 'poster-$movieId',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 110,
                        height: 165,
                        child: posterUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: posterUrl,
                                fit: BoxFit.cover,
                                errorWidget: (_, _, _) => Container(
                                  color: AppColors.surfaceDark2,
                                  child: const Icon(Icons.movie_outlined,
                                      color: AppColors.textMutedDark),
                                ),
                              )
                            : Container(color: AppColors.surfaceDark2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null && title!.isNotEmpty)
                          Text(
                            title!,
                            style: textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              shadows: const [
                                Shadow(blurRadius: 8, color: Colors.black54),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (rating != null && rating!.isNotEmpty) ...[
                              const Icon(Icons.star_rounded,
                                  size: 16, color: AppColors.accent),
                              const SizedBox(width: 4),
                              Text(
                                rating!,
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                            if (year != null && year!.isNotEmpty) ...[
                              const SizedBox(width: 10),
                              Text(
                                year!,
                                style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondaryDark),
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
          ],
        ),
      ),
    );
  }
}
