import 'package:go_router/go_router.dart';

import 'package:frontend/src/features/login/pantalla/PantallaLogin.dart';
import 'package:frontend/src/features/inicio/pantalla/PantallaInicio.dart';
import 'package:frontend/src/features/perfil/pantalla/PantallaPerfil.dart';
import 'package:frontend/src/features/ventas/pantalla/PantallaVentas.dart';
import 'package:frontend/src/app/barraNavegacion.dart';

GoRouter Rutas = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => PantallaLogin()),

    ShellRoute(
      builder: (context, state, child) {
        return BarraNavegacion(child: child);
      },
      routes: [
        GoRoute(path: '/inicio', builder: (context, state) => PantallaInicio()),
        GoRoute(path: '/perfil', builder: (context, state) => PantallaPerfil()),
        GoRoute(path: '/ventas', builder: (context, state) => PantallaVentas()),
      ],
    ),
  ],
);
