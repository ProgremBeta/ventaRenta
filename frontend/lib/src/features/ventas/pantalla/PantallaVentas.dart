import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';

class PantallaVentas extends StatefulWidget {
  const PantallaVentas({super.key});

  @override
  State<PantallaVentas> createState() => _PantallaVentasState();
}

class _PantallaVentasState extends State<PantallaVentas> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorApp.colorFondo,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(EstilosApp.paddingMedio),
            child: Container(
              width: 1000,
              height: 100,
              color: ColorApp.colorSegundario,
              child: Row(
                children: [
                  Text(
                    "venta id",
                    style: TextStyle(
                      color: ColorApp.colorTexto,
                      fontSize: EstilosApp.tamanoTexto,
                    ),
                  ),
                  Text(
                    "precio total",
                    style: TextStyle(
                      color: ColorApp.colorTexto,
                      fontSize: EstilosApp.tamanoTexto,
                    ),
                  ),

                  Text(
                    "estado",
                    style: TextStyle(
                      color: ColorApp.colorTexto,
                      fontSize: EstilosApp.tamanoTexto,
                    ),
                  ),
                  Text(
                    "fecha",
                    style: TextStyle(
                      color: ColorApp.colorTexto,
                      fontSize: EstilosApp.tamanoTexto,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
