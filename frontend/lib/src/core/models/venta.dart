class Venta {
  final int id;
  final int? usuarioId;
  final int? clienteId;
  final double total;
  final int? metodoPago;
  final String? estado;
  final String? fechaCreacion;

  Venta({
    required this.id,
    this.usuarioId,
    this.clienteId,
    required this.total,
    this.metodoPago,
    this.estado,
    this.fechaCreacion,
  });

  factory Venta.fromJson(Map<String, dynamic> json) {
    double total(dynamic v) {
      if (v == null) return 0.0;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v) ?? 0.0;
      return 0.0;
    }

    return Venta(
      id: json['id'] as int,
      usuarioId: json['usuario_id'] as int?,
      clienteId: json['cliente_id'] as int?,
      total: total(json['total']),
      metodoPago: json['metodo_pago'] as int?,
      estado: json['estado'] as String?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'usuario_id': usuarioId,
        'cliente_id': clienteId,
        'total': total,
        'metodo_pago': metodoPago,
      };
}
