import 'package:dio/dio.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class Autenticacion {
  final Dio _dio = DioConexion().dio;

  Future<Map<String, dynamic>> login(String identificacion, String contrasena) async {

    try {
      final response = await _dio.post(
        '/api/login',
        data: {
          'identificacion': identificacion,
          'contrasena_hash': contrasena,
        },
      );

      return {
        'success': true,
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Error de conexión',
      };
    }
  }
}
