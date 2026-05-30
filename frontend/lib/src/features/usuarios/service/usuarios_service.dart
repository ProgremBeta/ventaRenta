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
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      debugPrint("❌ [UsuariosService] GET /api/usuarios → $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> usuario(int id) async {
    try {
      final response = await _dio.get('/api/usuarios/$id');
      debugPrint("📡 [UsuariosService] GET /api/usuarios/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final resp = response.data;
      if (resp is Map<String, dynamic>) {
        return resp;
      }
      if (resp is List && resp.isNotEmpty) {
        return resp[0] as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint("❌ [UsuariosService] GET /api/usuarios/$id → $e");
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
    } catch (e) {
      debugPrint("❌ [UsuariosService] GET /api/roles → $e");
      return [];
    }
  }

  Future<bool> crearRol(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/roles', data: data);
      debugPrint("📡 [UsuariosService] POST /api/roles → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [UsuariosService] POST /api/roles → $e");
      return false;
    }
  }

  Future<bool> actualizarRol(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/roles/$id', data: data);
      debugPrint("📡 [UsuariosService] PUT /api/roles/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [UsuariosService] PUT /api/roles/$id → $e");
      return false;
    }
  }

  Future<bool> crearUsuario(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nuevo_usuario', data: data);
      debugPrint("📡 [UsuariosService] POST /api/nuevo_usuario → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [UsuariosService] POST /api/nuevo_usuario → $e");
      return false;
    }
  }

  Future<bool> actualizarUsuario(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/usuarios/$id', data: data);
      debugPrint("📡 [UsuariosService] PUT /api/usuarios/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [UsuariosService] PUT /api/usuarios/$id → $e");
      return false;
    }
  }
}
