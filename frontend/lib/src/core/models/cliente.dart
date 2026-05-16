class Cliente {
  final int id;
  final String nombre;
  final String? email;
  final String? telefono;
  final int? puntos;
  final String? fechaCreacion;

  Cliente({
    required this.id,
    required this.nombre,
    this.email,
    this.telefono,
    this.puntos,
    this.fechaCreacion,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      email: json['email'] as String?,
      telefono: json['telefono'] as String?,
      puntos: json['puntos'] as int?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'email': email,
        'telefono': telefono,
        'puntos': puntos,
      };
}
