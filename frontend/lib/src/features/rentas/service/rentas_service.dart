import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/dispositivo.dart';
import 'package:frontend/src/core/models/renta.dart';

class RentaServices {
  final Dio _dio = DioConexion().dio;

  Future<List<Renta>> rentas() async {
    try {
      final response = await _dio.get('/api/rentas');
      
      print(response.data);
      print(response.data.runtimeType);

      final List data = response.data;
      return data.map((json) => Renta.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("ERROR rentas: ${e.response?.data}");
      return [];
    }
  }

  Future<Renta?> iniciarRenta(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/iniciar_renta', data: data);
      return Renta.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("ERROR iniciar renta: ${e.response?.data}");
      return null;
    }
  }

  Future<List<Cliente>> clientes() async {
    try {
      final response = await _dio.get('/api/clientes');
      final List data = response.data;
      return data.map((json) => Cliente.fromJson(json)).toList();
    } on DioException catch (e) {
      debugPrint("ERROR clientes: ${e.response?.data}");
      return [];
    }
  }

  Future<List<Dispositivo>> dispositivos() async {
    try {
      final response = await _dio.get('/api/productos');
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
      debugPrint("ERROR dispositivos: ${e.response?.data}");
      return [];
    }
  }
}
