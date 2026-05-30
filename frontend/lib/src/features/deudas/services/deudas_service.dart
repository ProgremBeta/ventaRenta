import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/deuda.dart';
import 'package:frontend/src/core/models/pago_deuda.dart';

class DeudasService {
  final Dio _dio = DioConexion().dio;

  Future<List<Deuda>> deudas() async {
    try {
      final response = await _dio.get('/api/deudas');
      debugPrint("📡 [DeudasService] GET /api/deudas → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final data = response.data;
      if (data is List) {
        return data.map((json) => Deuda.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("❌ [DeudasService] GET /api/deudas → $e");
      return [];
    }
  }

  Future<Deuda?> crearDeuda(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nueva_deuda', data: data);
      debugPrint("📡 [DeudasService] POST /api/nueva_deuda → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final resp = response.data;
      if (resp is List && resp.isNotEmpty) {
        return Deuda.fromJson(resp[0] as Map<String, dynamic>);
      }
      if (resp is Map<String, dynamic>) {
        return Deuda.fromJson(resp);
      }
      return null;
    } catch (e) {
      debugPrint("❌ [DeudasService] POST /api/nueva_deuda → $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> pagarDeuda(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/pago_deuda', data: data);
      debugPrint("📡 [DeudasService] POST /api/pago_deuda → ${response.statusCode}");
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
      debugPrint("❌ [DeudasService] POST /api/pago_deuda → $e");
      return null;
    }
  }

  Future<List<Cliente>> clientes() async {
    try {
      final response = await _dio.get('/api/clientes');
      debugPrint("📡 [DeudasService] GET /api/clientes → ${response.statusCode}");
      final data = response.data;
      if (data is List) {
        return data.map((json) => Cliente.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint("❌ [DeudasService] GET /api/clientes → $e");
      return [];
    }
  }

  Future<List<PagoDeuda>> pagosPorDeuda(int deudaId) async {
    try {
      final response = await _dio.get('/api/pagos_deudas');
      debugPrint("📡 [DeudasService] GET /api/pagos_deudas → ${response.statusCode}");
      final data = response.data;
      if (data is List) {
        return data
            .map((json) => PagoDeuda.fromJson(json))
            .where((p) => p.deudaId == deudaId)
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint("❌ [DeudasService] GET /api/pagos_deudas → $e");
      return [];
    }
  }
}
