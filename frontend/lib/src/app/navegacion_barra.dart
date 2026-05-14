import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/src/core/themes/color_app.dart';

class BarraNavegacion extends StatefulWidget {
  final Widget child;

  const BarraNavegacion({super.key, required this.child});

  @override
  State<BarraNavegacion> createState() => _BarraNavegacionState();
}

class _BarraNavegacionState extends State<BarraNavegacion> {
  // Mapeo de rutas a índices
  final Map<String, int> rutasIndices = {
    '/inicio': 0,
    '/deudas': 1,
    '/ventas': 2,
  };

  // Rutas disponibles para navegar
  final List<String> rutas = ['/inicio', '/deudas', '/ventas'];

  int _obtenerIndiceActual() {
    final ruta = GoRouterState.of(context).uri.path;
    return rutasIndices[ruta] ?? 0;
  }

  void _alCambiarItems(int indice) {
    context.go(rutas[indice]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF1E1E1E),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _obtenerIndiceActual(),
        onTap: _alCambiarItems,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'deudas'),
          BottomNavigationBarItem(icon: Icon(Icons.sell), label: 'Ventas'),
        ],
      ),
    );
  }
}
