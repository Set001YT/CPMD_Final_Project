import '../config/api_config.dart';

class ImageUrlBuilder {
  ImageUrlBuilder._();

  static String poster(String? path) {
    if (path == null || path.isEmpty) return '';
    return '${ApiConfig.imageBaseUrl}/${ApiConfig.posterSize}$path';
  }

  static String backdrop(String? path, {bool large = false}) {
    if (path == null || path.isEmpty) return '';
    final size = large ? 'w1280' : ApiConfig.backdropSize;
    return '${ApiConfig.imageBaseUrl}/$size$path';
  }
}
