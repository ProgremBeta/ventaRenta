import 'package:flutter/material.dart';
import 'package:frontend/src/core/storage/almacenamiento_token.dart';
import 'package:frontend/src/features/login/service/login_service.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  final Autenticacion _loginService = Autenticacion();
  final TokenStorage _storage = TokenStorage();

  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  String? _userName;
  int? _userRolId;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get userName => _userName;
  int? get userRolId => _userRolId;

  Future<void> verificarSesion() async {
    final token = await _storage.leerToken();
    _isAuthenticated = token != null && token.isNotEmpty;
    notifyListeners();  
  }

  Future<bool> login(String identificacion, String contrasena) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _loginService.login(identificacion, contrasena);

    _isLoading = false;

    if (result.exito) {
      final data = result.data!;
      await _storage.guardarToken(data.token);
      if (data.refreshToken != null) {
        await _storage.guardarRefreshToken(data.refreshToken!);
      }
      _isAuthenticated = true;
      _userName = data.nombre;
      _userRolId = data.rolId;
      notifyListeners();
      return true;
    } else {
      _error = result.mensaje;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    await _storage.eliminarTodo();
    _isAuthenticated = false;
    _userName = null;
    _userRolId = null;
    notifyListeners();
    context.go('/login');
  }
}
