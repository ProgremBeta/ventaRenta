import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:frontend/src/features/deudas/provider/deudas_provider.dart';
import 'package:frontend/src/features/ventas/provider/ventas_provider.dart';
import 'package:frontend/src/features/rentas/provider/rentas_provider.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VentasProvider>().fetchVentas();
      context.read<RentasProvider>().fetchRentas();
      context.read<DeudasProvider>().fetchDeudas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final ventas = context.watch<VentasProvider>();
    final rentas = context.watch<RentasProvider>();
    final deudas = context.watch<DeudasProvider>();

    final totalVentas = ventas.ventas.fold<double>(0, (sum, v) => sum + v.total);
    final rentasActivas = rentas.rentas.where((r) => r.estado == 'activa').length;
    final deudasPendientes = deudas.deudas.where((d) => d.estado != 'pagado').length;
    final totalDeudas = deudas.deudas.fold<double>(0, (sum, d) => sum + (d.saldo ?? 0));

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        title: Text("INICIO"),
        backgroundColor: ColorApp.colorNavBar,
        titleTextStyle: const TextStyle(color: ColorApp.colorTitulo, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0,
        actions: [
          Text(' ${auth.userName ?? 'Usuario'}'),
          IconButton(
            icon: const Icon(Icons.person_outline, color: ColorApp.colorAcento),
            onPressed: () => context.pushNamed('/perfil')
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(EstilosApp.paddingGeneral),
            child: Column(
              children: [
                _tarjetaResumen(
                  //icono: Icons.sell,
                  titulo: 'Ventas totales',
                  valor: '\$${totalVentas.toStringAsFixed(0)}',
                  color: ColorApp.colorAcento,
                ),
                const SizedBox(height: 12),
                _tarjetaResumen(
                  //icono: Icons.videogame_asset,
                  titulo: 'Rentas activas',
                  valor: '$rentasActivas',
                  color: ColorApp.colorExito,
                ),
                const SizedBox(height: 12),
                _tarjetaResumen(
                  //icono: Icons.account_balance,
                  titulo: 'Deudas pendientes',
                  valor: '$deudasPendientes (\$${totalDeudas.toStringAsFixed(0)})',
                  color: ColorApp.colorAdvertencia,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tarjetaResumen({
    //required IconData icono,
    required String titulo,
    required String valor,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(EstilosApp.paddingGeneral),
      decoration: BoxDecoration(
        color: ColorApp.colorElevado,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorApp.colorBordeInput.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            //child: Icon(icono, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: ColorApp.colorSubTitulo,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
