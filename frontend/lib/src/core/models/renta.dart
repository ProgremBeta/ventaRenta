class Renta {
  final int id;
  final int? usuarioId;
  final int? clienteId;
  final String? fechaInicio;
  final String? fechaFin;
  final String? tiempoTotal;
  final double? precioTotal;
  final int? metodoPago;
  final String? estado;
  final String? fechaCreacion;

  Renta({
    required this.id,
    this.usuarioId,
    this.clienteId,
    this.fechaInicio,
    this.fechaFin,
    this.tiempoTotal,
    this.precioTotal,
    this.metodoPago,
    this.estado,
    this.fechaCreacion,
  });

  factory Renta.fromJson(Map<String, dynamic> json) {
    double? _parseNum(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    return Renta(
      id: json['id'] as int,
      usuarioId: json['usuario_id'] as int?,
      clienteId: json['cliente_id'] as int?,
      fechaInicio: json['fecha_inicio'] as String?,
      fechaFin: json['fecha_fin'] as String?,
      tiempoTotal: json['tiempo_total'] as String?,
      precioTotal: _parseNum(json['precio_total']),
      metodoPago: json['metodo_pago'] as int?,
      estado: json['estado'] as String?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'usuario_id': usuarioId,
        'cliente_id': clienteId,
        'fecha_inicio': fechaInicio,
        'fecha_fin': fechaFin,
        'tiempo_total': tiempoTotal,
        'precio_total': precioTotal,
        'metodo_pago': metodoPago,
        'estado': estado,
      };
}
