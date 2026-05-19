import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:frontend/src/core/widgets/toast_notificacion.dart';
import 'package:go_router/go_router.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _identificacionController = TextEditingController();
  final _contrasenaController = TextEditingController();

  Future<void> _handleLogin() async {
    final auth = context.read<AuthProvider>();
    final exito = await auth.login(
      _identificacionController.text,
      _contrasenaController.text,
    );

    if (!mounted) return;

    if (exito) {
      context.go('/inicio');
    } else {
      ToastNotificacion.mostrar(
        context,
        mensaje: auth.error ?? 'Error al iniciar sesión',
        tipo: TipoToast.error,
      );
    }
  }

  @override
  void dispose() {
    _identificacionController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(EstilosApp.paddingGeneral),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Container(
              padding: const EdgeInsets.all(EstilosApp.paddingGrande),
              decoration: BoxDecoration(
                color: ColorApp.colorSegundario,
                borderRadius: BorderRadius.circular(EstilosApp.borderRadius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: EstilosApp.tamanoTitulo,
                      color: ColorApp.colorTitulo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _identificacionController,
                    decoration: InputDecoration(
                      labelText: 'Identificación',
                      prefixIcon: const Icon(Icons.person_outline),
                      labelStyle: const TextStyle(color: ColorApp.colorTextoMuted),
                      filled: true,
                      fillColor: ColorApp.colorFondoInput,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
                        borderSide: const BorderSide(color: ColorApp.colorBordeInput),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
                        borderSide: const BorderSide(color: ColorApp.colorBordeInput),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
                        borderSide: const BorderSide(color: ColorApp.colorBordeFoco, width: 2),
                      ),
                    ),
                    style: const TextStyle(color: ColorApp.colorTexto),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _contrasenaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock_outline),
                      labelStyle: const TextStyle(color: ColorApp.colorTextoMuted),
                      filled: true,
                      fillColor: ColorApp.colorFondoInput,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
                        borderSide: const BorderSide(color: ColorApp.colorBordeInput),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
                        borderSide: const BorderSide(color: ColorApp.colorBordeInput),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
                        borderSide: const BorderSide(color: ColorApp.colorBordeFoco, width: 2),
                      ),
                    ),
                    style: const TextStyle(color: ColorApp.colorTexto),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: auth.isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.colorAcento,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput),
                        ),
                        elevation: 0,
                      ),
                      child: auth.isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Ingresar',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
