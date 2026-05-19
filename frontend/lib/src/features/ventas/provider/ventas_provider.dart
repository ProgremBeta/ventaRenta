import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/metodos_pagos.dart';
import 'package:frontend/src/core/models/producto.dart';
import 'package:frontend/src/core/models/venta.dart';
import 'package:frontend/src/features/ventas/service/ventas_services.dart';

class VentasProvider extends ChangeNotifier {
  final VentaServices _service = VentaServices();

  List<Venta> _ventas = [];
  List<Cliente> _clientes = [];
  List<Producto> _productos = [];
  List<MetodosPagos> _metodoPago = [];
  bool _isLoading = false;
  String? _error;

  List<Venta> get ventas => _ventas;
  List<Cliente> get clientes => _clientes;
  List<Producto> get productos => _productos;
  List<MetodosPagos> get metodoPago => _metodoPago;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchVentas() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _ventas = await _service.ventas();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchClientes() async {
    _clientes = await _service.clientes();
    notifyListeners();
  }

  Future<void> fetchProductos() async {
    _productos = await _service.productos();
    notifyListeners();
  }

  Future<bool> crearVenta(Map<String, dynamic> data) async {
    final result = await _service.nuevaVenta(data);
    if (result != null) {
      await fetchVentas();
      return true;
    }
    return false;
  }

  Future<void> fetchMetodoPago() async{
    _metodoPago = await _service.metodoPago();
    notifyListeners();
  }
}
