class DetalleVenta {
  final int id;
  final int? ventaId;
  final int? productoId;
  final int? cantidad;
  final double? precioUnitario;
  final double? subTotal;
  final String? fechaCreacion;

  DetalleVenta({
    required this.id,
    this.ventaId,
    this.productoId,
    this.cantidad,
    this.precioUnitario,
    this.subTotal,
    this.fechaCreacion,
  });

  factory DetalleVenta.fromJson(Map<String, dynamic> json) {
    double? _parseNum(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    return DetalleVenta(
      id: json['id'] as int,
      ventaId: json['venta_id'] as int?,
      productoId: json['producto_id'] as int?,
      cantidad: json['cantidad'] as int?,
      precioUnitario: _parseNum(json['precio_unitario']),
      subTotal: _parseNum(json['sub_total']),
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'venta_id': ventaId,
        'producto_id': productoId,
        'cantidad': cantidad,
        'precio_unitario': precioUnitario,
        'sub_total': subTotal,
      };
}
