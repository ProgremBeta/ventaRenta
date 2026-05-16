import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'package:frontend/src/core/models/login_response.dart';

class LoginResult {
  final bool exito;
  final LoginResponse? data;
  final String? mensaje;

  LoginResult({required this.exito, this.data, this.mensaje});
}

class Autenticacion {
  final Dio _dio = DioConexion().dio;

  Future<LoginResult> login(String identificacion, String contrasena) async {
    try {
      final response = await _dio.post(
        '/api/login',
        data: {
          'identificacion': identificacion,
          'contrasena_hash': contrasena,
        },
      );
      final loginResponse = LoginResponse.fromJson(response.data);
      return LoginResult(exito: true, data: loginResponse);
    } on DioException catch (e) {
      final msg = e.response?.data?['mensaje'] as String? ?? 'Error de conexión';
      debugPrint('Error login: $msg');
      return LoginResult(exito: false, mensaje: msg);
    }
  }
}
