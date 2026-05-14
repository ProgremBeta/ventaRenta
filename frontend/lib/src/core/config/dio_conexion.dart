import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/src/core/storage/almacenamiento_token.dart';

class DioConexion {
  static final DioConexion _instance = DioConexion._internal();

  late final Dio _dio;

  factory DioConexion() => _instance;

  DioConexion._internal() {
    final baseUrl = dotenv.env['BASE_URL'];

    debugPrint('DioConexion initialized with BASE_URL: $baseUrl');

    if (BASE_URL == null || BASE_URL.isEmpty) {
      throw Exception('BASE_URL no está definida en el .env');
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final session = await TokenStorage().leerSession('token');
          if (session != null && session.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $session';
          }
          debugPrint('REQUEST: ${options.method} ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('RESPONSE: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint('ERROR: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
