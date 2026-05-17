import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/image_url_builder.dart';
import '../../domain/entities/movie_detail.dart';

class CastList extends StatelessWidget {
  final AsyncValue<List<Cast>> castAsync;
  const CastList({super.key, required this.castAsync});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: castAsync.when(
        loading: () => _Loader(),
        error: (e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Failed to load cast',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textMutedDark,
                  ),
            ),
          ),
        ),
        data: (cast) {
          final visible = cast.take(15).toList();
          if (visible.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'No cast info',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textMutedDark,
                    ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: visible.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) => _CastItem(cast: visible[index]),
          );
        },
      ),
    );
  }
}

class _CastItem extends StatelessWidget {
  final Cast cast;
  const _CastItem({required this.cast});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 88,
      child: Column(
        children: [
          ClipOval(
            child: SizedBox(
              width: 72,
              height: 72,
              child: cast.profilePath.isEmpty
                  ? Container(
                      color: AppColors.surfaceDark2,
                      child: const Icon(Icons.person,
                          color: AppColors.textMutedDark),
                    )
                  : CachedNetworkImage(
                      imageUrl: ImageUrlBuilder.poster(cast.profilePath),
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        color: AppColors.surfaceDark2,
                      ),
                      errorWidget: (_, _, _) => Container(
                        color: AppColors.surfaceDark2,
                        child: const Icon(Icons.person,
                            color: AppColors.textMutedDark),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            cast.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelMedium,
          ),
          if (cast.character.isNotEmpty)
            Text(
              cast.character,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.textMutedDark,
              ),
            ),
        ],
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(width: 16),
      itemBuilder: (_, _) => Shimmer.fromColors(
        baseColor: AppColors.surfaceDark2,
        highlightColor: AppColors.surfaceDark3,
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 8),
            Container(width: 70, height: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
