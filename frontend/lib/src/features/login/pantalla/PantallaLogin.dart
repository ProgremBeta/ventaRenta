import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/features/login/service/login_service.dart';
import 'package:go_router/go_router.dart';

class PantallaLogin extends StatefulWidget {
  const PantallaLogin({super.key});

  @override
  State<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final _identificacionIngresada = TextEditingController();
  final _contrasenaIngresada = TextEditingController();

  final ServicioLogin _loginService = ServicioLogin();

  bool _isLoading = false;
  String? _error;

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final response = await _loginService.login(
      identificacion: _identificacionIngresada.text,
      contrasena_hash: _contrasenaIngresada.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (response.success) {
      context.go('/inicio');
    } else {
      setState(() {
        _error = response.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(0, 0),
        color: ColorApp.colorFondo,

        child: Container(
          color: ColorApp.colorPrincipal,
          width: EstilosApp.anchoRecuadro,
          height: EstilosApp.alturaRecuadro,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(EstilosApp.paddingGrande),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: EstilosApp.tamanoTitulo,
                    color: ColorApp.colorTexto,
                  ),
                ),
              ),

              SizedBox(
                width: EstilosApp.anchoInput,
                height: EstilosApp.alturaInput,

                child: TextField(
                  controller: _identificacionIngresada,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(EstilosApp.paddingMedio),
                    border: OutlineInputBorder(),
                    label: Text("ingresa tu identificacion"),

                    labelStyle: TextStyle(
                      color: ColorApp.colorTexto,
                      fontSize: EstilosApp.tamanoTextoInput,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        EstilosApp.borderRadius - 5,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        EstilosApp.borderRadius,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: EstilosApp.anchoInput,
                height: EstilosApp.alturaInput,

                child: TextField(
                  controller: _contrasenaIngresada,
                  obscureText: true,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(EstilosApp.paddingMedio),
                    border: OutlineInputBorder(),
                    label: Text("constaseña"),

                    labelStyle: TextStyle(
                      fontSize: EstilosApp.tamanoTextoInput,
                      color: ColorApp.colorTexto,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        EstilosApp.borderRadius - 5,
                      ),

                      borderSide: BorderSide(
                        color: ColorApp.colorHoverInactivo,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        EstilosApp.borderRadius,
                      ),
                      borderSide: BorderSide(color: ColorApp.colorHoverActivo),
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Ingresar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
