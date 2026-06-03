import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/detalle_venta.dart';
import 'package:frontend/src/core/models/metodos_pagos.dart';
import 'package:frontend/src/core/models/producto.dart';
import 'package:frontend/src/core/models/venta.dart';

class VentaServices {
  final Dio _dio = DioConexion().dio;

  Future<List<Venta>> ventas() async {
    try {
      final response = await _dio.get('/api/ventas');
      debugPrint("📡 [VentaServices] GET /api/ventas → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => Venta.fromJson(json)).toList();
    } catch (e) {
      debugPrint("❌ [VentaServices] GET /api/ventas → $e");
      return [];
    }
  }

  Future<Venta?> nuevaVenta(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nueva_venta', data: data);
      debugPrint("📡 [VentaServices] POST /api/nueva_venta → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final resp = response.data;
      if (resp is List && resp.isNotEmpty) {
        return Venta.fromJson(resp[0] as Map<String, dynamic>);
      }
      if (resp is Map<String, dynamic>) {
        return Venta.fromJson(resp);
      }
      return null;
    } catch (e) {
      debugPrint("❌ [VentaServices] POST /api/nueva_venta → $e");
      return null;
    }
  }

  Future<List<DetalleVenta>> detalleVenta(int ventaId) async {
    try {
      final response = await _dio.get('/api/detalles_ventas/$ventaId');
      debugPrint("📡 [VentaServices] GET /api/detalles_ventas/$ventaId → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => DetalleVenta.fromJson(json)).toList();
    } catch (e) {
      debugPrint("❌ [VentaServices] GET /api/detalles_ventas/$ventaId → $e");
      return [];
    }
  }

  Future<List<Cliente>> clientes() async {
    try {
      final response = await _dio.get('/api/clientes');
      debugPrint("📡 [VentaServices] GET /api/clientes → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => Cliente.fromJson(json)).toList();
    } catch (e) {
      debugPrint("❌ [VentaServices] GET /api/clientes → ${e}");
      return [];
    }
  }

  Future<List<Producto>> productos() async {
    try {
      final response = await _dio.get('/api/productos');
      debugPrint("📡 [VentaServices] GET /api/productos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => Producto.fromJson(json)).toList();
    } catch (e) {
      debugPrint("❌ [VentaServices] GET /api/productos → ${e}");
      return [];
    }
  }

  Future<List<MetodosPagos>> metodoPago() async {
    try {
      final response = await _dio.get('/api/metodos_pagos');
      debugPrint("📡 [VentaServices] GET /api/metodos_pagos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => MetodosPagos.fromJson(json)).toList();
    } catch (e) {
      debugPrint("❌ [VentaServices] GET /api/metodos_pagos → ${e}");
      return [];
    }
  }

  Future<bool> crearMetodoPago(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/metodos_pagos', data: data);
      debugPrint("📡 [VentaServices] POST /api/metodos_pagos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [VentaServices] POST /api/metodos_pagos → ${e}");
      return false;
    }
  }

  Future<bool> actualizarMetodoPago(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/metodos_pagos/$id', data: data);
      debugPrint("📡 [VentaServices] PUT /api/metodos_pagos/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [VentaServices] PUT /api/metodos_pagos/$id → ${e}");
      return false;
    }
  }

  Future<bool> crearDeuda(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nueva_deuda', data: data);
      debugPrint("📡 [VentaServices] POST /api/nueva_deuda → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [VentaServices] POST /api/nueva_deuda → ${e}");
      return false;
    }
  }
}
