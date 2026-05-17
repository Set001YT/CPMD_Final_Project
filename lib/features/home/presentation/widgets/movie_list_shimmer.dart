import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';

class MovieListShimmer extends StatelessWidget {
  const MovieListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      separatorBuilder: (_, _) => const SizedBox(width: 12),
      itemBuilder: (_, _) => Shimmer.fromColors(
        baseColor: AppColors.surfaceDark2,
        highlightColor: AppColors.surfaceDark3,
        child: SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Container(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Container(height: 14, width: 100, color: Colors.white),
              const SizedBox(height: 4),
              Container(height: 12, width: 60, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
