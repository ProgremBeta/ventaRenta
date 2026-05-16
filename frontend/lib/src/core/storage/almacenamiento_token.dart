import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'token';
  static const String _refreshTokenKey = 'refreshToken';

  Future<void> guardarSession(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> leerSession(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> eliminarSession(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> guardarToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> leerToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> guardarRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> leerRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> eliminarTodo() async {
    await _storage.deleteAll();
  }
}
