import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/movie.dart';
import '../../data/repositories/search_repository_impl.dart';

// Raw query typed by user
final searchQueryProvider = StateProvider<String>((ref) => '');

// Debounced results — family on the query string
final searchResultsProvider =
    FutureProvider.autoDispose.family<List<Movie>, String>((ref, query) async {
  if (query.trim().length < 2) return [];

  // 300ms debounce: if provider is disposed before delay, return early
  var cancelled = false;
  ref.onDispose(() => cancelled = true);
  await Future<void>.delayed(const Duration(milliseconds: 300));
  if (cancelled) return [];

  return ref.read(searchRepositoryProvider).searchMovies(query);
});
