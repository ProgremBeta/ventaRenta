class LoginResponse {
  final int? id;
  final String token;
  final String? refreshToken;
  final int? rolId;
  final String? nombre;

  LoginResponse({
    this.id,
    required this.token,
    this.refreshToken,
    this.rolId,
    this.nombre,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] as int?,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String?,
      rolId: json['rol_id'] as int?,
      nombre: json['nombre'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
        'refreshToken': refreshToken,
        'rol_id': rolId,
        'nombre': nombre,
      };
}
