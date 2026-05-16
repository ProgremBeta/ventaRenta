import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/src/core/storage/almacenamiento_token.dart';

class DioConexion {
  static final DioConexion _instance = DioConexion._internal();
  late final Dio _dio;
  // Cambiar a true cuando el backend tenga el endpoint /api/refresh
  final bool _refreshEnabled = false;

  factory DioConexion() => _instance;

  DioConexion._internal() {
    final baseUrl = dotenv.env['BACKEND_URL'];
    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('BACKEND_URL no está definida en el .env');
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
          final session = await TokenStorage().leerToken();
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
        onError: (error, handler) async {
          if (_refreshEnabled &&
              error.response?.statusCode == 401 &&
              !error.requestOptions.path.contains('/api/refresh')) {
            final refreshToken = await TokenStorage().leerRefreshToken();
            if (refreshToken != null && refreshToken.isNotEmpty) {
              try {
                final refreshDio = Dio(
                  BaseOptions(baseUrl: baseUrl),
                );
                final refreshResponse = await refreshDio.post(
                  '/api/refresh',
                  data: {'refreshToken': refreshToken},
                );
                final newToken = refreshResponse.data['token'] as String;
                final newRefreshToken =
                    refreshResponse.data['refreshToken'] as String?;

                await TokenStorage().guardarToken(newToken);
                if (newRefreshToken != null) {
                  await TokenStorage().guardarRefreshToken(newRefreshToken);
                }

                final opts = error.requestOptions;
                opts.headers['Authorization'] = 'Bearer $newToken';
                final clone = await _dio.fetch(opts);
                return handler.resolve(clone);
              } catch (_) {
                await TokenStorage().eliminarTodo();
              }
            }
          }
          debugPrint('ERROR: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
