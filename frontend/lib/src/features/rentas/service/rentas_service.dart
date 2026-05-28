import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/detalle_renta.dart';
import 'package:frontend/src/core/models/dispositivo.dart';
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
    } on DioException catch (e) {
      debugPrint("❌ [RentaServices] GET /api/rentas → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<Renta?> iniciarRenta(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/iniciar_renta', data: data);
      debugPrint("📡 [RentaServices] POST /api/iniciar_renta → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return Renta.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("❌ [RentaServices] POST /api/iniciar_renta → ${e.response?.statusCode} ${e.response?.data}");
      return null;
    }
  }

  Future<List<Cliente>> clientes() async {
    try {
      final response = await _dio.get('/api/clientes');
      debugPrint("📡 [RentaServices] GET /api/clientes → ${response.statusCode}");
      final List<dynamic> data = response.data;
      return data.map((json) => Cliente.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("❌ [RentaServices] GET /api/clientes → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<Renta?> actualizarRenta(int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/api/rentas/$id', data: data);
      debugPrint("📡 [RentaServices] PUT /api/rentas/$id → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      return Renta.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      debugPrint("❌ [RentaServices] PUT /api/rentas/$id → ${e.response?.statusCode} ${e.response?.data}");
      return null;
    }
  }

  Future<List<DetalleRenta>> detalleRenta(int rentaId) async {
    try {
      final response = await _dio.get('/api/detalle_renta/$rentaId');
      debugPrint("📡 [RentaServices] GET /api/detalle_renta/$rentaId → ${response.statusCode}");
      debugPrint("📦 ${response.data}");
      final List<dynamic> data = response.data;
      return data.map((json) => DetalleRenta.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("❌ [RentaServices] GET /api/detalle_renta/$rentaId → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }

  Future<List<Dispositivo>> dispositivos() async {
    try {
      final response = await _dio.get('/api/productos');
      debugPrint("📡 [RentaServices] GET /api/productos → ${response.statusCode}");
      final List<dynamic> data = response.data;

      final dispositivos = data.where((json) {
        final id = json['id'] as int?;
        final nombre = json['nombre'] as String?;
        return id != null && nombre != null;
      }).map((json) => Dispositivo.fromJson({
            'id': json['id'],
            'nombre': json['nombre'],
            'categoria_id': json['categoria_id'],
            'precio_hora': json['precio'],
            'estado': json['activo'] == true ? 'disponible' : 'inactivo',
          })).toList();

      return dispositivos;
    } on DioException catch (e) {
      debugPrint("❌ [RentaServices] GET /api/productos → ${e.response?.statusCode} ${e.response?.data}");
      return [];
    }
  }
}
