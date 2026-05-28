class MetodosPagos {
  final int id;
  final String nombre;
  final String? descripcion;
  final String? fechaCreacion;

  MetodosPagos({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.fechaCreacion,
  });

  factory MetodosPagos.fromJson(Map<String, dynamic> json) {
    return MetodosPagos(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'descripcion': descripcion,
      };
}
