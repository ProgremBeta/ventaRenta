import 'package:dio/dio.dart';
import 'package:frontend/src/core/config/dio_conexion.dart';
import 'api_response.dart';

class ApiService {
  final Dio _dio = DioConexion().dio;

  Future<ApiResponse<T>> get<T>(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return ApiResponse<T>(success: true, data: response.data);
    } on DioException catch (e) {
      return ApiResponse<T>(
        success: false,
        message: _getErrorMessage(e),
      );
    }
  }

  Future<ApiResponse<T>> post<T>(String endpoint, dynamic body) async {
    try {
      final response = await _dio.post(endpoint, data: body);
      return ApiResponse<T>(success: true, data: response.data);
    } on DioException catch (e) {
      return ApiResponse<T>(
        success: false,
        message: _getErrorMessage(e),
      );
    }
  }

  Future<ApiResponse<T>> put<T>(String endpoint, dynamic body) async {
    try {
      final response = await _dio.put(endpoint, data: body);
      return ApiResponse<T>(success: true, data: response.data);
    } on DioException catch (e) {
      return ApiResponse<T>(
        success: false,
        message: _getErrorMessage(e),
      );
    }
  }

  Future<ApiResponse<T>> delete<T>(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return ApiResponse<T>(success: true, data: response.data);
    } on DioException catch (e) {
      return ApiResponse<T>(
        success: false,
        message: _getErrorMessage(e),
      );
    }
  }

  String _getErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tiempo de conexión agotado';
      case DioExceptionType.sendTimeout:
        return 'Tiempo de envío agotado';
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de respuesta agotado';
      case DioExceptionType.badResponse:
        return 'Error del servidor: ${error.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Petición cancelada';
      default:
        return error.message ?? 'Error desconocido';
    }
  }
}
