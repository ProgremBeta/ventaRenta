import 'package:go_router/go_router.dart';

import 'package:frontend/src/features/login/pantalla/pantalla_login.dart';
import 'package:frontend/src/features/inicio/pantalla/pantalla_inicio.dart';
import 'package:frontend/src/features/perfil/pantalla/pantalla_perfil.dart';
import 'package:frontend/src/features/ventas/pantalla/pantalla_ventas.dart';
import 'package:frontend/src/features/rentas/pantalla/pantalla_rentas.dart';
import 'package:frontend/src/features/deudas/pantalla/pantalla_deudas.dart';
import 'package:frontend/src/features/inventario/pantalla/pantalla_inventario.dart';

import 'package:frontend/src/app/navegacion_barra.dart';

GoRouter Rutas = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const PantallaLogin()),
    ShellRoute(
      builder: (context, state, child) {
        return BarraNavegacion(child: child);
      },
      routes: [
        GoRoute(path: '/inicio', builder: (context, state) => const PantallaInicio()),
        GoRoute(path: '/perfil', builder: (context, state) => const PantallaPerfil()),
        GoRoute(path: '/ventas', builder: (context, state) => const PantallaVentas()),
        GoRoute(path: '/rentas', builder: (context, state) => const PantallaRentas()),
        GoRoute(path: '/deudas', builder: (context, state) => const PantallaDeudas()),
        GoRoute(path: '/inventario', builder: (context, state) => const PantallaInventario()),
      ],
    ),
  ],
);
