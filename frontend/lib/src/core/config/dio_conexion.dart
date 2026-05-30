import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/src/core/storage/almacenamiento_token.dart';
import 'package:frontend/src/core/widgets/global_notificacion.dart';

class DioConexion {
  static final DioConexion _instance = DioConexion._internal();
  late final Dio _dio;
  final bool _refreshEnabled = false;

  factory DioConexion() => _instance;

  DioConexion._internal() {
    final baseUrl = dotenv.env['BACKEND_URL'];
    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('BACKEND_URL no está definida en el .env');
    }

    debugPrint('═══════════════════════════════════════');
    debugPrint('🌐 BACKEND_URL: $baseUrl');
    debugPrint('═══════════════════════════════════════');

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
          debugPrint('');
          debugPrint('═══════════════════════════════════════');
          debugPrint('📤 ${options.method} ${options.path}');
          if (options.data != null) {
            debugPrint('📦 DATA: ${options.data}');
          }
          debugPrint('═══════════════════════════════════════');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('');
          debugPrint('═══════════════════════════════════════');
          debugPrint('📥 ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}');
          if (response.data != null) {
            debugPrint('📦 ${response.data}');
          }
          debugPrint('═══════════════════════════════════════');

          return handler.next(response);
        },
        onError: (error, handler) async {
          debugPrint('');
          debugPrint('═══════════════════════════════════════');
          debugPrint('❌ ${error.response?.statusCode} ${error.requestOptions.method} ${error.requestOptions.path}');
          debugPrint('📦 ${error.response?.data}');
          debugPrint('📝 ${error.message}');
          debugPrint('═══════════════════════════════════════');

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

          final method = error.requestOptions.method;
          if (method == 'GET') return handler.next(error);

          final data = error.response?.data;
          final mensaje = (data is Map && data['mensaje'] is String)
              ? data['mensaje'] as String
              : (error.message ?? 'Error desconocido');
          final status = error.response?.statusCode;

          if (status == 400 || status == 404) {
            GlobalNotificacion.advertencia(mensaje);
          } else {
            GlobalNotificacion.error(mensaje);
          }

          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
