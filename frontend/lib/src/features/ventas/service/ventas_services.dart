import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/producto.dart';
import 'package:frontend/src/core/models/venta.dart';

class VentaServices {
  final Dio _dio = DioConexion().dio;

  Future<List<Venta>> ventas() async {
    try {
      final response = await _dio.get('/api/ventas');
      final List<dynamic> data = response.data;
      return data.map((json) => Venta.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("ERROR ventas: ${e.response?.data}");
      return [];
    }
  }

  Future<Venta?> nuevaVenta(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/nueva_venta', data: data);
      return Venta.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("ERROR nueva venta: ${e.response?.data}");
      return null;
    }
  }

  Future<List<Cliente>> clientes() async {
    try {
      final response = await _dio.get('/api/clientes');
      final List<dynamic> data = response.data;
      return data.map((json) => Cliente.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("ERROR clientes: ${e.response?.data}");
      return [];
    }
  }

  Future<List<Producto>> productos() async {
    try {
      final response = await _dio.get('/api/productos');
      final List<dynamic> data = response.data;
      return data.map((json) => Producto.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("ERROR productos: ${e.response?.data}");
      return [];
    }
  }
}
