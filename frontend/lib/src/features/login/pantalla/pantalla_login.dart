import 'package:frontend/src/core/storage/almacenamiento_token.dart';
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

  final loginService = Autenticacion();

  bool _isLoading = false;

  Future<void> _handleLogin() async {
    
  setState(() {
    _isLoading = true;
  });

  final result = await loginService.login(
    _identificacionIngresada.text,
    _contrasenaIngresada.text,
  );

  debugPrint('resultado de auth: $result');

  setState(() {
    _isLoading = false;
  });


  if (result['success']) {
    TokenStorage().guardarSession("token", result['data']['token']);
    context.go('/inicio');
  } else {
    setState(() {
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment(0, 0),
        color: ColorApp.colorPrincipal,

        child: Container(
          color: ColorApp.colorSegundario,
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
                      borderSide: BorderSide(
                        color: ColorApp.colorHoverInactivo,
                      ),
                      borderRadius: BorderRadius.circular(
                        EstilosApp.borderRadius - 5,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorApp.colorHoverActivo),
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
