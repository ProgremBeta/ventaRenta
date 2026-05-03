import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaperfilState();
}

class _PantallaperfilState extends State<PantallaPerfil> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      color: ColorApp.colorFondo,
      child: Container(
        width: 500,
        height: 600,
        color: ColorApp.colorPrincipal,
        child: Column(
          children: [
            SizedBox(
              width: 400,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(EstilosApp.paddingGrande),
                    child: Text(
                      "Este es el apartado de perfiles",
                      style: TextStyle(
                        color: const Color(0xFF7B0E8C),
                        fontSize: EstilosApp.tamanoTitulo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
