class Producto {
  final int id;
  final String nombre;
  final String? descripcion;
  final double precio;
  final int? categoriaId;
  final bool? activo;
  final String? fechaCreacion;

  Producto({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.precio,
    this.categoriaId,
    this.activo,
    this.fechaCreacion,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      precio: double.parse(json['precio']).toDouble(),
      categoriaId: json['categoria_id'] as int?,
      activo: json['activo'] as bool?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre, 
        'descripcion': descripcion,
        'precio': precio,
        'categoria_id': categoriaId,
        'activo': activo,
      };
}
