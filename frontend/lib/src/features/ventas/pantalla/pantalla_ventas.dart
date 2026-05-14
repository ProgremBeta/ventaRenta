import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:frontend/src/features/ventas/service/ventas_services.dart';

class PantallaVentas extends StatefulWidget {
  const PantallaVentas({super.key});

  @override
  State<PantallaVentas> createState() => _PantallaVentasState();
}

class _PantallaVentasState extends State<PantallaVentas> {
  final ventaServices = VentaServices();

  late Future<List<dynamic>> result;

  @override
  void initState() {
    super.initState();
    result = ventaServices.ventas();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorApp.colorPrincipal,
      child: FutureBuilder<List<dynamic>>(
        future: result,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay datos"));
          }

          final ventas = snapshot.data!;

          return ListView.builder(
            itemCount: ventas.length,
            itemBuilder: (context, index) {
              final venta = ventas[index];

              return Padding(
                padding: EdgeInsets.all(EstilosApp.paddingMedio),
                child: Container(
                  height: 80,
                  color: ColorApp.colorCuadroLista,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        venta['id'].toString(),
                        style: TextStyle(color: ColorApp.colorInformacion),
                      ),
                      Text(
                        venta['cliente_id'].toString(),
                        style: TextStyle(color: ColorApp.colorInformacion),
                      ),
                      Text(
                        venta['total'].toString(),
                        style: TextStyle(color: ColorApp.colorInformacion),
                      ),
                      Text(
                        venta['fecha_creacion'].toString(),
                        style: TextStyle(color: ColorApp.colorInformacion),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}