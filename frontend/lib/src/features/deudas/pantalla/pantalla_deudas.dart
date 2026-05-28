import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/models/deuda.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/widgets/item_lista.dart';
import 'package:frontend/src/core/widgets/toast_notificacion.dart';
import 'package:frontend/src/features/deudas/provider/deudas_provider.dart';

class PantallaDeudas extends StatefulWidget {
  const PantallaDeudas({super.key});

  @override
  State<PantallaDeudas> createState() => _PantallaDeudasState();
}

class _PantallaDeudasState extends State<PantallaDeudas> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<DeudasProvider>();
      p.fetchDeudas();
      p.fetchClientes();
    });
  }

  void _mostrarDetalle(Deuda deuda) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorApp.colorSegundario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Deuda #${deuda.id}', style: const TextStyle(color: ColorApp.colorTitulo)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detalleRow('Cliente', _nombreCliente(deuda.clienteId)),
            _detalleRow('Monto total', '\$${deuda.montoTotal?.toStringAsFixed(2) ?? '0.00'}'),
            _detalleRow('Pagado', '\$${deuda.montoPagado?.toStringAsFixed(2) ?? '0.00'}'),
            _detalleRow('Saldo pendiente', '\$${deuda.saldo?.toStringAsFixed(2) ?? '0.00'}'),
            _detalleRow('Estado', deuda.estado ?? '—'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: ColorApp.colorTextoMuted)),
          ),
          if (deuda.estado != 'pagado')
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _mostrarPagoDeuda(deuda);
              },
              icon: const Icon(Icons.payments, color: Colors.white, size: 18),
              label: const Text('Pagar deuda'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorExito,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
        ],
      ),
    );
  }

  void _mostrarPagoDeuda(Deuda deuda) {
    final montoCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool enviando = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Pagar deuda', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Deuda #${deuda.id} — Saldo: \$${deuda.saldo?.toStringAsFixed(2) ?? '0.00'}',
                    style: const TextStyle(color: ColorApp.colorSubTitulo)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: montoCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Monto a pagar',
                    prefixText: '\$ ',
                    labelStyle: const TextStyle(color: ColorApp.colorTextoMuted),
                    filled: true,
                    fillColor: ColorApp.colorFondoInput,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: ColorApp.colorBordeInput),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: ColorApp.colorBordeInput),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: ColorApp.colorBordeFoco, width: 2),
                    ),
                  ),
                  style: const TextStyle(color: ColorApp.colorTexto),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Ingrese un monto';
                    final monto = double.tryParse(v);
                    if (monto == null || monto <= 0) return 'Monto inválido';
                    if (deuda.saldo != null && monto > deuda.saldo!) {
                      return 'El monto excede el saldo pendiente';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
            ),
            ElevatedButton.icon(
              onPressed: enviando ? null : () async {
                if (!formKey.currentState!.validate()) return;
                setState(() => enviando = true);
                final monto = double.tryParse(montoCtrl.text) ?? 0;
                final exito = await context.read<DeudasProvider>().pagarDeuda({
                  'deuda_id': deuda.id,
                  'monto': monto,
                  'metodo_pago': 1,
                });
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                ToastNotificacion.mostrar(
                  context,
                  mensaje: exito ? 'Pago registrado con éxito' : 'Error al registrar pago',
                  tipo: exito ? TipoToast.exito : TipoToast.error,
                );
              },
              icon: const Icon(Icons.check, color: Colors.white, size: 18),
              label: enviando
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Pagar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorExito,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _nombreCliente(int? clienteId) {
    if (clienteId == null) return 'Sin cliente';
    final provider = context.read<DeudasProvider>();
    final c = provider.clientes.where((c) => c.id == clienteId).firstOrNull;
    return c?.nombre ?? 'Cliente #$clienteId';
  }

  Widget _detalleRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: ColorApp.colorSubTitulo, fontSize: 14)),
          Text(value, style: const TextStyle(color: ColorApp.colorTexto, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
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
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorApp.colorBordeInput),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorApp.colorBordeInput),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorApp.colorBordeFoco, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DeudasProvider>();

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        title: const Text('Deudas'),
        backgroundColor: ColorApp.colorNavBar,
        titleTextStyle: const TextStyle(color: ColorApp.colorTitulo, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0,
      ),

      body: _buildBody(provider),
    );
  }

  Widget _buildBody(DeudasProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: ColorApp.colorAcento));
    }
    if (provider.error != null) {
      return Center(
        child: Text(provider.error!, style: const TextStyle(color: ColorApp.colorError)),
      );
    }
    if (provider.deudas.isEmpty) {
      return const Center(
        child: Text('No hay deudas registradas', style: TextStyle(color: ColorApp.colorTextoMuted)),
      );
    }
    return RefreshIndicator(
      color: ColorApp.colorAcento,
      onRefresh: provider.fetchDeudas,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: provider.deudas.length,
        itemBuilder: (context, index) {
          final deuda = provider.deudas[index];
          final Color? colorBorde;
          final Color? colorFondo;
          switch (deuda.estado) {
            case 'pagado':
              colorBorde = ColorApp.colorExito;
              colorFondo = ColorApp.colorExito.withValues(alpha: 0.08);
            case 'pendiente':
              colorBorde = ColorApp.colorAdvertencia;
              colorFondo = ColorApp.colorAdvertencia.withValues(alpha: 0.08);
            default:
              colorBorde = null;
              colorFondo = null;
          }
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: colorFondo,
              borderRadius: BorderRadius.circular(12),
              border: colorBorde != null
                  ? Border.all(color: colorBorde, width: 1.5)
                  : null,
            ),
            child: ItemLista(
              titulo: 'Deuda #${deuda.id}',
              subtitulo: _nombreCliente(deuda.clienteId),
              detalle: '\$${deuda.saldo?.toStringAsFixed(0) ?? '0'}',
              onTap: () => _mostrarDetalle(deuda),
            ),
          );
        },
      ),
    );
  }
}
