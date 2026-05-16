import 'package:flutter/foundation.dart';
import 'package:frontend/src/core/models/cliente.dart';
import 'package:frontend/src/core/models/deuda.dart';
import 'package:frontend/src/features/deudas/services/deudas_service.dart';

class DeudasProvider extends ChangeNotifier {
  final DeudasService _service = DeudasService();

  List<Deuda> _deudas = [];
  List<Cliente> _clientes = [];
  bool _isLoading = false;
  String? _error;

  List<Deuda> get deudas => _deudas;
  List<Cliente> get clientes => _clientes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDeudas() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _deudas = await _service.deudas();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchClientes() async {
    _clientes = await _service.clientes();
    notifyListeners();
  }

  Future<bool> crearDeuda(Map<String, dynamic> data) async {
    final result = await _service.crearDeuda(data);
    if (result != null) {
      await fetchDeudas();
      return true;
    }
    return false;
  }

  Future<bool> pagarDeuda(Map<String, dynamic> data) async {
    final result = await _service.pagarDeuda(data);
    if (result != null) {
      await fetchDeudas();
      return true;
    }
    return false;
  }
}
