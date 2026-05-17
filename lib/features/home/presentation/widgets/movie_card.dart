import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_url_builder.dart';
import '../../domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double width;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.movie,
    this.width = 130,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Hero(
                  tag: 'poster-${movie.id}',
                  child: CachedNetworkImage(
                    imageUrl: ImageUrlBuilder.poster(movie.posterPath),
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Shimmer.fromColors(
                      baseColor: AppColors.surfaceDark2,
                      highlightColor: AppColors.surfaceDark3,
                      child: Container(color: Colors.white),
                    ),
                    errorWidget: (_, _, _) => Container(
                      color: AppColors.surfaceDark2,
                      child: const Icon(
                        Icons.movie_outlined,
                        color: AppColors.textMutedDark,
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star_rounded,
                    size: 14, color: AppColors.accent),
                const SizedBox(width: 4),
                Text(
                  movie.formattedRating,
                  style: textTheme.bodySmall
                      ?.copyWith(color: AppColors.textSecondaryDark),
                ),
                if (movie.year.isNotEmpty) ...[
                  Text(
                    '  ·  ',
                    style: textTheme.bodySmall
                        ?.copyWith(color: AppColors.textMutedDark),
                  ),
                  Text(
                    movie.year,
                    style: textTheme.bodySmall
                        ?.copyWith(color: AppColors.textSecondaryDark),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

