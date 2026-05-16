class DetalleRenta {
  final int id;
  final int? rentaId;
  final int? dispositivoId;
  final double? precioHora;
  final String? tiempoTotal;
  final double? subTotal;
  final String? fechaCreacion;

  DetalleRenta({
    required this.id,
    this.rentaId,
    this.dispositivoId,
    this.precioHora,
    this.tiempoTotal,
    this.subTotal,
    this.fechaCreacion,
  });

  factory DetalleRenta.fromJson(Map<String, dynamic> json) {
    return DetalleRenta(
      id: json['id'] as int,
      rentaId: json['renta_id'] as int?,
      dispositivoId: json['dispositivo_id'] as int?,
      precioHora: (json['precio_hora'] as num?)?.toDouble(),
      tiempoTotal: json['tiempo_total'] as String?,
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      fechaCreacion: json['fecha_creacion'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'renta_id': rentaId,
        'dispositivo_id': dispositivoId,
        'precio_hora': precioHora,
        'tiempo_total': tiempoTotal,
        'sub_total': subTotal,
      };
}
