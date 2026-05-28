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
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] GET /api/ventas → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<Venta?> nuevaVenta(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nueva_venta', data: data);
      debugPrint("📡 [VentaServices] POST /api/nueva_venta → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return Venta.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] POST /api/nueva_venta → ${e.response?.statusCode} ${e.response?.data}");
      return null;
    }
  }

  Future<List<DetalleVenta>> detalleVenta(int ventaId) async {
    try {
      final response = await _dio.get('/api/detalle_venta/$ventaId');
      debugPrint("📡 [VentaServices] GET /api/detalle_venta/$ventaId → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => DetalleVenta.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] GET /api/detalle_venta/$ventaId → ${e.response?.statusCode} ${e.response?.data}");
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
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] GET /api/clientes → ${e.response?.statusCode} ${e.response?.data}");
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
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] GET /api/productos → ${e.response?.statusCode} ${e.response?.data}");
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
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] GET /api/metodos_pagos → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<bool> crearMetodoPago(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/metodos_pagos', data: data);
      debugPrint("📡 [VentaServices] POST /api/metodos_pagos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] POST /api/metodos_pagos → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }

  Future<bool> actualizarMetodoPago(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/metodos_pagos/$id', data: data);
      debugPrint("📡 [VentaServices] PUT /api/metodos_pagos/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] PUT /api/metodos_pagos/$id → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }

  Future<bool> crearDeuda(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nueva_deuda', data: data);
      debugPrint("📡 [VentaServices] POST /api/nueva_deuda → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } on DioException catch (e) {
      debugPrint("❌ [VentaServices] POST /api/nueva_deuda → ${e.response?.statusCode} ${e.response?.data}");
      return false;
    }
  }
}
