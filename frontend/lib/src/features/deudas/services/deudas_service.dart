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
      final List<dynamic> data = response.data;
      return data.map((json) => Deuda.fromJson(json)).toList();
    } catch (err) {
      debugPrint('Error al mostrar deudas: $err');
      return [];
    }
  }

  Future<Deuda?> crearDeuda(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/crear_deuda', data: data);
      return Deuda.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Error al crear deuda: ${e.response?.data}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> pagarDeuda(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/pago_deuda', data: data);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      debugPrint('Error al pagar deuda: ${e.response?.data}');
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

  Future<List<PagoDeuda>> pagosPorDeuda(int deudaId) async {
    try {
      final response = await _dio.get('/api/pagos_deudas');
      final List<dynamic> data = response.data;
      return data
          .map((json) => PagoDeuda.fromJson(json))
          .where((p) => p.deudaId == deudaId)
          .toList();
    } on DioException catch (e) {
      debugPrint("ERROR pagos: ${e.response?.data}");
      return [];
    }
  }
}
