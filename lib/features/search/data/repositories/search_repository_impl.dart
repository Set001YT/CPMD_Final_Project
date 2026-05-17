import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/chopper_provider.dart';
import '../../../home/data/models/movie_dto.dart';
import '../../../home/domain/entities/movie.dart';

class SearchRepository {
  final dynamic _apiService;

  SearchRepository(this._apiService);

  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    if (query.trim().isEmpty) return [];
    final response = await _apiService.searchMovies(query.trim(), page: page);
    if (!response.isSuccessful) return [];
    final data = response.body as Map<String, dynamic>;
    final results = (data['results'] as List? ?? [])
        .map((e) => MovieDto.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
    return results;
  }
}

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final api = ref.watch(movieApiServiceProvider);
  return SearchRepository(api);
});
