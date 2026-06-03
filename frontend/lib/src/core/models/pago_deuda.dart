class PagoDeuda {
  final int id;
  final int? deudaId;
  final double? monto;
  final int? metodoPago;
  final String? fechaCreacion;

  PagoDeuda({
    required this.id,
    this.deudaId,
    this.monto,
    this.metodoPago,
    this.fechaCreacion,
  });

  factory PagoDeuda.fromJson(Map<String, dynamic> json) {
    double? parseNum(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v);
      return null;
    }

    return PagoDeuda(
      id: json['id'] as int,
      deudaId: json['deuda_id'] as int?,
      monto: parseNum(json['monto']),
      metodoPago: json['metodo_pago'] as int?,
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'deuda_id': deudaId,
        'monto': monto,
        'metodo_pago': metodoPago,
      };
}
