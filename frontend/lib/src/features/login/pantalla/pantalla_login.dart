import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:frontend/src/core/widgets/global_notificacion.dart';
import 'package:frontend/src/features/usuarios/service/usuarios_service.dart';
import 'package:go_router/go_router.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _identificacionController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _nombreCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _passRegCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _esRegistro = false;

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
      GlobalNotificacion.error(auth.error ?? 'Error al iniciar sesión');
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final service = UsuariosService();
    final exito = await service.crearUsuario({
      'identificacion': _identificacionController.text,
      'nombre': _nombreCtrl.text,
      'email': _emailCtrl.text,
      'telefono': _telefonoCtrl.text,
      'contrasena_hash': _passRegCtrl.text,
      'rol_id': 2,
    });

    if (!mounted) return;

    if (exito) {
      GlobalNotificacion.exito('Usuario registrado con éxito');
      setState(() {
        _esRegistro = false;
        _contrasenaController.text = _passRegCtrl.text;
      });
    } else {
      GlobalNotificacion.error('Error al registrar usuario');
    }
  }

  @override
  void dispose() {
    _identificacionController.dispose();
    _contrasenaController.dispose();
    _nombreCtrl.dispose();
    _emailCtrl.dispose();
    _telefonoCtrl.dispose();
    _passRegCtrl.dispose();
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      _esRegistro ? 'Registrarse' : 'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: EstilosApp.tamanoTitulo,
                        color: ColorApp.colorTitulo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _identificacionController,
                      decoration: _inputDeco('Identificación'),
                      style: const TextStyle(color: ColorApp.colorTexto),
                    ),
                    if (_esRegistro) ...[
                      const SizedBox(height: 14),
                      TextField(
                        controller: _nombreCtrl,
                        decoration: _inputDeco('Nombre'),
                        style: const TextStyle(color: ColorApp.colorTexto),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDeco('Email'),
                        style: const TextStyle(color: ColorApp.colorTexto),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _telefonoCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: _inputDeco('Teléfono'),
                        style: const TextStyle(color: ColorApp.colorTexto),
                      ),
                    ],
                    const SizedBox(height: 14),
                    TextField(
                      controller: _esRegistro ? _passRegCtrl : _contrasenaController,
                      obscureText: true,
                      decoration: _inputDeco('Contraseña'),
                      style: const TextStyle(color: ColorApp.colorTexto),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: auth.isLoading
                            ? null
                            : _esRegistro ? _handleRegister : _handleLogin,
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
                            : Text(
                                _esRegistro ? 'Registrarse' : 'Ingresar',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => setState(() => _esRegistro = !_esRegistro),
                      child: Text(
                        _esRegistro ? '¿Ya tienes cuenta? Inicia sesión' : '¿No tienes cuenta? Regístrate',
                        style: const TextStyle(color: ColorApp.colorAcento),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDeco(String label) {
    return InputDecoration(
      labelText: label,
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
    );
  }
}
