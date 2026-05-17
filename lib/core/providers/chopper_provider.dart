import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/data/services/movie_api_service.dart';
import '../config/api_config.dart';
import '../network/auth_interceptor.dart';

final chopperClientProvider = Provider<ChopperClient>((ref) {
  final client = ChopperClient(
    baseUrl: Uri.parse(ApiConfig.baseUrl),
    interceptors: [
      AuthInterceptor(),
      HttpLoggingInterceptor(),
    ],
    converter: const JsonConverter(),
    services: [
      MovieApiService.create(),
    ],
  );
  ref.onDispose(client.dispose);
  return client;
});

final movieApiServiceProvider = Provider<MovieApiService>((ref) {
  return ref.watch(chopperClientProvider).getService<MovieApiService>();
});
