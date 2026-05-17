import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  ApiConfig._();

  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';
  static String get baseUrl =>
      dotenv.env['TMDB_BASE_URL'] ?? 'https://api.themoviedb.org/3';
  static String get imageBaseUrl =>
      dotenv.env['TMDB_IMAGE_BASE_URL'] ?? 'https://image.tmdb.org/t/p';

  static const String posterSize = 'w500';
  static const String backdropSize = 'w780';
  static const String backdropOriginal = 'original';
}
