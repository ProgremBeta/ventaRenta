class Deuda {
  final int id;
  final int? clienteId;
  final double? montoTotal;
  final double? montoPagado;
  final double? saldo;
  final String? estado;
  final String? fechaCreacion;

  Deuda({
    required this.id,
    this.clienteId,
    this.montoTotal,
    this.montoPagado,
    this.saldo,
    this.estado,
    this.fechaCreacion,
  });

  factory Deuda.fromJson(Map<String, dynamic> json) {
    return Deuda(
      id: json['id'] as int,
      clienteId: json['cliente_id'] as int?,
      montoTotal: (json['monto_total'] as num?)?.toDouble(),
      montoPagado: (json['monto_pagado'] as num?)?.toDouble(),
      saldo: (json['saldo'] as num?)?.toDouble(),
      estado: json['estado'] as String?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cliente_id': clienteId,
        'monto_total': montoTotal,
        'monto_pagado': montoPagado,
        'saldo': saldo,
        'estado': estado,
      };
}
