import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_category.dart';
import '../../domain/repositories/home_repository.dart';

class MovieListState {
  final List<Movie> movies;
  final int currentPage;
  final bool isLoadingInitial;
  final bool isLoadingMore;
  final bool hasMore;
  final Object? error;

  const MovieListState({
    this.movies = const [],
    this.currentPage = 0,
    this.isLoadingInitial = true,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
  });

  MovieListState copyWith({
    List<Movie>? movies,
    int? currentPage,
    bool? isLoadingInitial,
    bool? isLoadingMore,
    bool? hasMore,
    Object? error,
    bool clearError = false,
  }) {
    return MovieListState(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class MovieListNotifier extends StateNotifier<MovieListState> {
  final HomeRepository _repo;
  final MovieCategory _category;

  MovieListNotifier(this._repo, this._category)
      : super(const MovieListState()) {
    loadFirstPage();
  }

  Future<Either<Failure, List<Movie>>> _fetchPage(int page) {
    switch (_category) {
      case MovieCategory.trending:
        return _repo.getTrendingMovies(page: page);
      case MovieCategory.popular:
        return _repo.getPopularMovies(page: page);
      case MovieCategory.upcoming:
        return _repo.getUpcomingMovies(page: page);
      case MovieCategory.topRated:
        return _repo.getTopRatedMovies(page: page);
    }
  }

  Future<void> loadFirstPage() async {
    state = state.copyWith(isLoadingInitial: true, clearError: true);
    final result = await _fetchPage(1);
    result.fold(
      (failure) => state = state.copyWith(
        isLoadingInitial: false,
        error: failure.message,
      ),
      (movies) => state = state.copyWith(
        movies: movies,
        currentPage: 1,
        isLoadingInitial: false,
        hasMore: movies.isNotEmpty,
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoadingInitial) return;
    state = state.copyWith(isLoadingMore: true, clearError: true);

    final nextPage = state.currentPage + 1;
    final result = await _fetchPage(nextPage);
    result.fold(
      (failure) => state = state.copyWith(
        isLoadingMore: false,
        error: failure.message,
      ),
      (more) => state = state.copyWith(
        movies: [...state.movies, ...more],
        currentPage: nextPage,
        isLoadingMore: false,
        hasMore: more.isNotEmpty,
      ),
    );
  }

  Future<void> retry() => loadFirstPage();
}

final movieListProvider = StateNotifierProvider.autoDispose
    .family<MovieListNotifier, MovieListState, MovieCategory>((ref, category) {
  return MovieListNotifier(ref.watch(homeRepositoryProvider), category);
});
