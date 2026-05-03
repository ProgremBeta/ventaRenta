import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioConexion {
  static final DioConexion _instance = DioConexion._internal();
  late Dio _dio;

  factory DioConexion() {
    return _instance;
  }

  DioConexion._internal() {
    final baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3001/api';

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
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
