import 'package:frontend/src/core/network/api_response.dart';
import 'package:frontend/src/core/network/api_service.dart';

class ServicioLogin {
  final ApiService _apiService = ApiService();

  /// Login del usuario
  Future<ApiResponse<Map<String, dynamic>>> login({
    required String identificacion,
    required String contrasena_hash,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        'http://localhost:3001/api/login',
        {'identificacion': identificacion, 'contrasena_hash': contrasena_hash},
      );

      return response;
    } catch (err) {
      return ApiResponse<Map<String, dynamic>>(
        success: false,
        message: 'Hubo un error al iniciar sesión',
        data: null,
      );
    }
  }
}