import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/dispositivo.dart';
import 'package:frontend/src/core/models/metodos_pagos.dart';
import 'package:frontend/src/core/models/renta.dart';

class RentaServices {
  final Dio _dio = DioConexion().dio;

  Future<List<Renta>> rentas() async {
    try {
      final response = await _dio.get('/api/rentas');
      debugPrint("📡 [RentaServices] GET /api/rentas → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final dynamic responseData = response.data;

      final List<dynamic> data;
      if (responseData is List) {
        data = responseData;
      } else if (responseData is Map && responseData['data'] is List) {
        data = responseData['data'] as List<dynamic>;
      } else {
        debugPrint("❌ [RentaServices] formato inesperado ${responseData.runtimeType}");
        return [];
      }

      return data.map((json) => Renta.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint("❌ [RentaServices] GET /api/rentas → $e");
      return [];
    }
  }

  Future<Renta?> iniciarRenta(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/iniciar_renta', data: data);
      debugPrint("📡 [RentaServices] POST /api/iniciar_renta → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final resp = response.data;
      if (resp is List && resp.isNotEmpty) {
        return Renta.fromJson(resp[0] as Map<String, dynamic>);
      }
      if (resp is Map<String, dynamic>) {
        return Renta.fromJson(resp);
      }
      return null;
    } catch (e) {
      debugPrint("❌ [RentaServices] POST /api/iniciar_renta → $e");
      return null;
    }
  }

  Future<List<Cliente>> clientes() async {
    try {
      final response = await _dio.get('/api/clientes');
      debugPrint("📡 [RentaServices] GET /api/clientes → ${response.statusCode}");
      final List<dynamic> data = response.data;
      return data.map((json) => Cliente.fromJson(json)).toList();
    } catch (e) {
      debugPrint("❌ [RentaServices] GET /api/clientes → $e");
      return [];
    }
  }

  Future<Renta?> actualizarRenta(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/rentas/$id', data: data);
      debugPrint("📡 [RentaServices] PUT /api/rentas/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final resp = response.data;
      if (resp is List && resp.isNotEmpty) {
        return Renta.fromJson(resp[0] as Map<String, dynamic>);
      }
      if (resp is Map<String, dynamic>) {
        return Renta.fromJson(resp);
      }
      return null;
    } catch (e) {
      debugPrint("❌ [RentaServices] PUT /api/rentas/$id → $e");
      return null;
    }
  }

  Future<Renta?> rentaPorId(int id) async {
    try {
      final response = await _dio.get('/api/rentas/$id');
      debugPrint("📡 [RentaServices] GET /api/rentas/$id → ${response.statusCode}");
      final data = response.data;
      if (data is List && data.isNotEmpty) {
        return Renta.fromJson(data[0] as Map<String, dynamic>);
      }
      if (data is Map<String, dynamic>) {
        return Renta.fromJson(data);
      }
      return null;
    } catch (e) {
      debugPrint("❌ [RentaServices] GET /api/rentas/$id → $e");
      return null;
    }
  }

  Future<List<MetodosPagos>> getMetodosPago() async {
    try {
      final response = await _dio.get('/api/metodos_pagos');
      debugPrint("📡 [RentaServices] GET /api/metodos_pagos → ${response.statusCode}");
      final List<dynamic> data = response.data;
      return data.map((json) => MetodosPagos.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint("❌ [RentaServices] GET /api/metodos_pagos → $e");
      return [];
    }
  }

  Future<List<Dispositivo>> dispositivos() async {
    try {
      final response = await _dio.get('/api/dispositivos');
      debugPrint("📡 [RentaServices] GET /api/dispositivos → ${response.statusCode}");
      final List<dynamic> data = response.data;
      return data.map((json) => Dispositivo.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      debugPrint("❌ [RentaServices] GET /api/dispositivos → $e");
      return [];
    }
  }
}
