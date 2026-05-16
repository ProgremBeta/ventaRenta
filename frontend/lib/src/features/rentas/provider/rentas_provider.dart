import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/dispositivo.dart';
import 'package:frontend/src/core/models/renta.dart';
import 'package:frontend/src/features/rentas/service/rentas_service.dart';

class RentasProvider extends ChangeNotifier {
  final RentaServices _service = RentaServices();

  List<Renta> _rentas = [];
  List<Cliente> _clientes = [];
  List<Dispositivo> _dispositivos = [];
  bool _isLoading = false;
  String? _error;

  List<Renta> get rentas => _rentas;
  List<Cliente> get clientes => _clientes;
  List<Dispositivo> get dispositivos => _dispositivos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchRentas() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _rentas = await _service.rentas();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchClientes() async {
    _clientes = await _service.clientes();
    notifyListeners();
  }

  Future<void> fetchDispositivos() async {
    _dispositivos = await _service.dispositivos();
    notifyListeners();
  }

  Future<bool> iniciarRenta(Map<String, dynamic> data) async {
    final result = await _service.iniciarRenta(data);
    if (result != null) {
      await fetchRentas();
      return true;
    }
    return false;
  }
}
