import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:frontend/src/features/deudas/services/deudas_service.dart';

class PantallaDeudas extends StatefulWidget {
  const PantallaDeudas({super.key});

  @override
  State<PantallaDeudas> createState() => _PantallaDeudasState();
}

class _PantallaDeudasState extends State<PantallaDeudas> {
  final deudasService = DeudasService();

  late Future<List<dynamic>> result;

  @override
  void initState() {
    super.initState();
    result = deudasService.deudas();
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

          final deudas = snapshot.data!;

          return ListView.builder(
            itemCount: deudas.length,
            itemBuilder: (context, index) {
              final deuda = deudas[index];

              return Padding(
                padding: EdgeInsets.all(EstilosApp.paddingMedio),
                child: Container(
                  height: 80,
                  color: ColorApp.colorSegundario,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        deuda['id'].toString(),
                        style: TextStyle(color: ColorApp.colorTexto),
                      ),
                      Text(
                        deuda['cliente_id'].toString(),
                        style: TextStyle(color: ColorApp.colorTexto),
                      ),
                      Text(
                        deuda['total'].toString(),
                        style: TextStyle(color: ColorApp.colorTexto),
                      ),
                      Text(
                        deuda['fecha_creacion'].toString(),
                        style: TextStyle(color: ColorApp.colorTexto),
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