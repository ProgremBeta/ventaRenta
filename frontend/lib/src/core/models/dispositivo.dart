class Dispositivo {
  final int id;
  final String? nombre;
  final int? categoriaId;
  final double? precioHora;
  final String? estado;
  final bool? activo;
  final String? fechaCreacion;

  Dispositivo({
    required this.id,
    this.nombre,
    this.categoriaId,
    this.precioHora,
    this.estado,
    this.activo,
    this.fechaCreacion,
  });

  factory Dispositivo.fromJson(Map<String, dynamic> json) {
    return Dispositivo(
      id: json['id'] as int,
      nombre: json['nombre'] as String?,
      categoriaId: json['categoria_id'] as int?,
      precioHora: (json['precio_hora'] as num?)?.toDouble(),
      estado: json['estado'] as String?,
      activo: json['activo'] as bool?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'categoria_id': categoriaId,
        'precio_hora': precioHora,
        'estado': estado,
        'activo': activo,
      };
}
