class MetodosPagos {
  final int id;
  final String nombre;

  MetodosPagos({
    required this.id,
    required this.nombre
  });

  factory MetodosPagos.fromJson(Map<String, dynamic> json){
    return MetodosPagos(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'metodoPago': nombre,
  };
}