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
  final Map<String, int> _rutasIndices = {
    '/inicio': 0,
    '/deudas': 1,
    '/ventas': 2,
    '/rentas': 3,
  };

  final List<String> _rutas = ['/inicio', '/deudas', '/ventas', '/rentas'];

  int _obtenerIndiceActual() {
    final ruta = GoRouterState.of(context).uri.path;
    return _rutasIndices[ruta] ?? 0;
  }

  void _alCambiarItems(int indice) {
    context.go(_rutas[indice]);
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final usarRail = ancho >= 720;

    if (usarRail) {
      return Scaffold(
        backgroundColor: ColorApp.colorPrincipal,
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _obtenerIndiceActual(),
              onDestinationSelected: _alCambiarItems,
              backgroundColor: ColorApp.colorNavBar,
              indicatorColor: ColorApp.colorAcento.withValues(alpha: 0.2),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined, color: ColorApp.colorTextoMuted),
                  selectedIcon: Icon(Icons.home, color: ColorApp.colorAcento),
                  label: Text('Inicio', style: TextStyle(color: ColorApp.colorSubTitulo)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.account_balance_outlined, color: ColorApp.colorTextoMuted),
                  selectedIcon: Icon(Icons.account_balance, color: ColorApp.colorAcento),
                  label: Text('Deudas', style: TextStyle(color: ColorApp.colorSubTitulo)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.sell_outlined, color: ColorApp.colorTextoMuted),
                  selectedIcon: Icon(Icons.sell, color: ColorApp.colorAcento),
                  label: Text('Ventas', style: TextStyle(color: ColorApp.colorSubTitulo)),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.videogame_asset_outlined, color: ColorApp.colorTextoMuted),
                  selectedIcon: Icon(Icons.videogame_asset, color: ColorApp.colorAcento),
                  label: Text('Rentas', style: TextStyle(color: ColorApp.colorSubTitulo)),
                ),
              ],
            ),
            const VerticalDivider(width: 1, color: ColorApp.colorBordeInput),
            Expanded(child: widget.child),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _obtenerIndiceActual(),
        onTap: _alCambiarItems,
        backgroundColor: ColorApp.colorNavBar,
        selectedItemColor: ColorApp.colorAcento,
        unselectedItemColor: ColorApp.colorTextoMuted,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined), activeIcon: Icon(Icons.account_balance), label: 'Deudas'),
          BottomNavigationBarItem(icon: Icon(Icons.sell_outlined), activeIcon: Icon(Icons.sell), label: 'Ventas'),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset_outlined), activeIcon: Icon(Icons.videogame_asset), label: 'Rentas'),
        ],
      ),
    );
  }
}
