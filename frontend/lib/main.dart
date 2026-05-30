import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/app/rutas.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/widgets/global_notificacion.dart';
import 'package:frontend/src/features/ventas/provider/ventas_provider.dart';
import 'package:frontend/src/features/rentas/provider/rentas_provider.dart';
import 'package:frontend/src/features/deudas/provider/deudas_provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => VentasProvider()),
        ChangeNotifierProvider(create: (_) => RentasProvider()),
        ChangeNotifierProvider(create: (_) => DeudasProvider()),
      ],
      child: MaterialApp.router(
        routerConfig: Rutas,
        builder: (context, child) => GlobalNotificacion.build(child: child ?? const SizedBox.shrink()),
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        ),
      ),
    );
  }
}
