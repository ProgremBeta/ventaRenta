class Venta {
  final int id;
  final int? usuarioId;
  final int? clienteId;
  final double total;
  final int? metodoPago;
  final String? fechaCreacion;

  Venta({
    required this.id,
    this.usuarioId,
    this.clienteId,
    required this.total,
    this.metodoPago,
    this.fechaCreacion,
  });

  factory Venta.fromJson(Map<String, dynamic> json) {
    return Venta(
      id: json['id'] as int,
      usuarioId: json['usuario_id'] as int?,
      clienteId: json['cliente_id'] as int?,
      total: double.parse(json['total'].toString()),
      metodoPago: json['metodo_pago'] as int?,
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
