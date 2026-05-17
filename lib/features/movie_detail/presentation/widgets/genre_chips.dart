import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/movie_detail.dart';

class GenreChips extends StatelessWidget {
  final List<Genre> genres;
  const GenreChips({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: genres
            .map((g) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark2,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Text(
                    g.name,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.textSecondaryDark,
                        ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
