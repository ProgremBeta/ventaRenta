import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/detalle_venta.dart';
import 'package:frontend/src/core/models/metodos_pagos.dart';
import 'package:frontend/src/core/models/producto.dart';
import 'package:frontend/src/core/models/venta.dart';
import 'package:frontend/src/features/usuarios/service/usuarios_service.dart';
import 'package:frontend/src/features/ventas/service/ventas_services.dart';

class VentasProvider extends ChangeNotifier {
  final VentaServices _service = VentaServices();
  final UsuariosService _usuariosService = UsuariosService();

  List<Venta> _ventas = [];
  List<Cliente> _clientes = [];
  List<Producto> _productos = [];
  List<MetodosPagos> _metodoPago = [];
  List<DetalleVenta> _detalleActual = [];
  List<Map<String, dynamic>> _usuarios = [];
  bool _isLoading = false;
  String? _error;

  List<Venta> get ventas => _ventas;
  List<Cliente> get clientes => _clientes;
  List<Producto> get productos => _productos;
  List<MetodosPagos> get metodoPago => _metodoPago;
  List<DetalleVenta> get detalleActual => _detalleActual;
  List<Map<String, dynamic>> get usuarios => _usuarios;
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

  Future<Venta?> crearVenta(Map<String, dynamic> data) async {
    final result = await _service.nuevaVenta(data);
    if (result != null) {
      await fetchVentas();
    }
    return result;
  }

  Future<void> fetchMetodoPago() async {
    _metodoPago = await _service.metodoPago();
    notifyListeners();
  }

  Future<void> fetchUsuarios() async {
    _usuarios = await _usuariosService.usuarios();
    notifyListeners();
  }

  Future<void> fetchDetalleVenta(int ventaId) async {
    _detalleActual = await _service.detalleVenta(ventaId);
    notifyListeners();
  }

  Future<bool> crearDeuda(Map<String, dynamic> data) async {
    return _service.crearDeuda(data);
  }
}
