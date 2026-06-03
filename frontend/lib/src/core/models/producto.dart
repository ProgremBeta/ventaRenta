class Producto {
  final int id;
  final String nombre;
  final String? descripcion;
  final double precio;
  final int? categoriaId;
  final bool? activo;
  final int? stock;
  final int? stockMinimo;
  final String? fechaCreacion;

  Producto({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.precio,
    this.categoriaId,
    this.activo,
    this.stock,
    this.stockMinimo,
    this.fechaCreacion,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    double precio(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    return Producto(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String?,
      precio: precio(json['precio']),
      categoriaId: json['categoria_id'] as int?,
      activo: json['activo'] as bool?,
      stock: json['stock'] as int?,
      stockMinimo: json['stock_minimo'] as int?,
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
        'stock': stock,
        'stock_minimo': stockMinimo,
      };
}
