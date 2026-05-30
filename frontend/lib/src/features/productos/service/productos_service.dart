import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';

class ProductosService {
  final Dio _dio = DioConexion().dio;

  Future<List<Map<String, dynamic>>> productos() async {
    try {
      final response = await _dio.get('/api/productos');
      debugPrint("📡 [ProductosService] GET /api/productos → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      debugPrint("❌ [ProductosService] GET /api/productos → $e");
      return [];
    }
  }

  Future<bool> crearProducto(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nuevo_producto', data: data);
      debugPrint("📡 [ProductosService] POST /api/nuevo_producto → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [ProductosService] POST /api/nuevo_producto → $e");
      return false;
    }
  }

  Future<bool> actualizarProducto(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/productos/$id', data: data);
      debugPrint("📡 [ProductosService] PUT /api/productos/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [ProductosService] PUT /api/productos/$id → $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>?> obtenerInventarioPorProductoId(int productoId) async {
    try {
      final response = await _dio.get('/api/inventario_productos/producto/$productoId');
      debugPrint("📡 [ProductosService] GET /api/inventario_productos/producto/$productoId → ${response.statusCode}");
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return null;
    } catch (e) {
      debugPrint("❌ [ProductosService] GET /api/inventario_productos/producto/$productoId → $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> obtenerInventarioProductos() async {
    try {
      final response = await _dio.get('/api/inventario_productos');
      debugPrint("📡 [ProductosService] GET /api/inventario_productos → ${response.statusCode}");
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      return null;
    } catch (e) {
      debugPrint("❌ [ProductosService] GET /api/inventario_productos → $e");
      return null;
    }
  }

  Future<bool> descontarStock(int productoId, int cantidad) async {
    try {
      final response = await _dio.post('/api/inventario_productos/descontar/$productoId', data: cantidad);
      debugPrint("📡 [ProductosService] POST /api/inventario_productos/descontar/$productoId → ${response.statusCode}");
      return true;
    } catch (e) {
      debugPrint("❌ [ProductosService] POST /api/inventario_productos/descontar/$productoId → $e");
      return false;
    }
  }

  Future<bool> actualizarInventario(int inventarioId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/inventario_productos/$inventarioId', data: data);
      debugPrint("📡 [ProductosService] PUT /api/inventario_productos/$inventarioId → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return true;
    } catch (e) {
      debugPrint("❌ [ProductosService] PUT /api/inventario_productos/$inventarioId → $e");
      return false;
    }
  }
}
