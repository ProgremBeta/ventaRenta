import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';

class PantallaPerfil extends StatelessWidget {
  const PantallaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: ColorApp.colorNavBar,
        titleTextStyle: const TextStyle(color: ColorApp.colorTitulo, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: ColorApp.colorElevado,
                child: Icon(Icons.person, color: ColorApp.colorAcento, size: 44),
              ),
              const SizedBox(height: 16),
              Text(
                auth.userName ?? 'Usuario',
                style: const TextStyle(
                  color: ColorApp.colorTitulo,
                  fontSize: EstilosApp.tamanoSubtitulo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 220,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => auth.logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.colorError,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput)),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
