import 'package:frontend/src/core/themes/color_app.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      color: ColorApp.colorPrincipal,
      child: Container(
        width: 500,
        height: 600,
        color: ColorApp.colorSegundario,
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
                      "Este es el apartado de inicio",
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
