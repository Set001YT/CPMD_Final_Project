import 'dart:async';

import 'package:chopper/chopper.dart';

import '../config/api_config.dart';

class AuthInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final request = chain.request;
    final updatedParams = Map<String, dynamic>.from(request.parameters);
    updatedParams['api_key'] = ApiConfig.apiKey;
    updatedParams['language'] = 'en-US';
    final updatedRequest = request.copyWith(parameters: updatedParams);
    return chain.proceed(updatedRequest);
  }
}
