import 'package:go_router/go_router.dart';

import 'package:frontend/src/features/login/pantalla/pantalla_login.dart';
import 'package:frontend/src/features/inicio/pantalla/pantalla_inicio.dart';
import 'package:frontend/src/features/perfil/pantalla/pnatalla_perfil.dart';
import 'package:frontend/src/features/ventas/pantalla/pantalla_ventas.dart';
import 'package:frontend/src/features/deudas/pantalla/pantalla_deudas.dart';

import 'package:frontend/src/app/navegacion_barra.dart';

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
        GoRoute(path: '/deudas', builder: (context, state) => PantallaDeudas()),

      ],
    ),
  ],
);
