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
    double? _parseNum(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    return Deuda(
      id: json['id'] as int,
      clienteId: json['cliente_id'] as int?,
      montoTotal: _parseNum(json['monto_total']),
      montoPagado: _parseNum(json['monto_pagado']),
      saldo: _parseNum(json['saldo']),
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
