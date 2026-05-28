import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class UsuariosService {
  final Dio _dio = DioConexion().dio;

  Future<List<Map<String, dynamic>>> usuarios() async {
    try {
      final response = await _dio.get('/api/usuarios');
      debugPrint("📡 [UsuariosService] GET /api/usuarios → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      debugPrint("❌ [UsuariosService] GET /api/usuarios → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<Map<String, dynamic>?> usuario(int id) async {
    try {
      final response = await _dio.get('/api/usuarios/$id');
      debugPrint("📡 [UsuariosService] GET /api/usuarios/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      debugPrint("❌ [UsuariosService] GET /api/usuarios/$id → ${e.response?.statusCode} ${e.response?.data}");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> roles() async {
    try {
      final response = await _dio.get('/api/roles');
      debugPrint("📡 [UsuariosService] GET /api/roles → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } on DioException catch (e) {
      debugPrint("❌ [UsuariosService] GET /api/roles → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<bool> crearRol(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/roles', data: data);
      debugPrint("📡 [UsuariosService] POST /api/roles → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [UsuariosService] POST /api/roles → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }

  Future<bool> actualizarRol(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/roles/$id', data: data);
      debugPrint("📡 [UsuariosService] PUT /api/roles/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [UsuariosService] PUT /api/roles/$id → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }

  Future<bool> crearUsuario(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nuevo_usuario', data: data);
      debugPrint("📡 [UsuariosService] POST /api/usuarios → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [UsuariosService] POST /api/usuarios → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }

  Future<bool> actualizarUsuario(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/usuarios/$id', data: data);
      debugPrint("📡 [UsuariosService] PUT /api/usuarios/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [UsuariosService] PUT /api/usuarios/$id → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }
}
