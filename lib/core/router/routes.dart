class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String movieDetail = '/movie/:id';
  static const String movieList = '/movies/:category';
  static const String login = '/login';
  static const String register = '/register';

  static String movieDetailPath(int id) => '/movie/$id';
  static String movieListPath(String categorySlug) => '/movies/$categorySlug';
}
