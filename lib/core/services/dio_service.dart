import 'package:dio/dio.dart';
// import 'package:dio_cache_interceptor/dio_cache_interceptor.dart'; // Import the package
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/core/constants/api_constants.dart';
import 'package:gemini_project/core/services/cache_interceptor.dart';
 // Import our new service

// 1. Provider that exposes the Dio instance
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.youtubeApiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  
  // Get the cache interceptor from its provider
  final cacheInterceptor = ref.watch(dioCacheInterceptorProvider);

  // Add the cache interceptor
  dio.interceptors.add(cacheInterceptor);

  // 2. Add interceptor to inject the API key
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final apiKey = dotenv.env['YOUTUBE_API_KEY'];
      if (apiKey == null) {
        handler.reject(
          DioException(
            requestOptions: options,
            error: "API Key not found in .env file",
          ),
        );
        return;
      }
      options.queryParameters['key'] = apiKey;
      return handler.next(options);
    },
    onError: (DioException e, handler) {
      // 3. Centralized DioException handler
      print('Dio Error: ${e.message}');
      print('Endpoint: ${e.requestOptions.path}');
      if (e.response != null) {
        print('Response Data: ${e.response?.data}');
      }
      return handler.next(e);
    },
  ));

  return dio;
});