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
      context.read<DeudasProvider>().fetchDeudas();
    });
  }

  void _mostrarDetalleConPago(Deuda deuda) {
    final montoCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorApp.colorSegundario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Deuda #${deuda.id}', style: const TextStyle(color: ColorApp.colorTitulo)),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detalleRow('Cliente ID', deuda.clienteId?.toString() ?? '—'),
              _detalleRow('Monto total', '\$${deuda.montoTotal?.toStringAsFixed(2) ?? '0.00'}'),
              _detalleRow('Pagado', '\$${deuda.montoPagado?.toStringAsFixed(2) ?? '0.00'}'),
              _detalleRow('Saldo pendiente', '\$${deuda.saldo?.toStringAsFixed(2) ?? '0.00'}'),
              _detalleRow('Estado', deuda.estado ?? '—'),
              if (deuda.estado != 'pagado') ...[
                const Divider(color: ColorApp.colorBordeInput, height: 24),
                const Text('Pagar deuda', style: TextStyle(color: ColorApp.colorTitulo, fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 8),
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
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: ColorApp.colorAcento)),
          ),
          if (deuda.estado != 'pagado')
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
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
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorExito,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text('Pagar'),
            ),
        ],
      ),
    );
  }

  void _mostrarFormulario() {
    final provider = context.read<DeudasProvider>();
    provider.fetchClientes();

    final origenIdCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String? origenTipo = 'venta';
    int? clienteId;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Nueva Deuda', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  value: clienteId,
                  items: provider.clientes.map((c) {
                    return DropdownMenuItem(value: c.id, child: Text(c.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
                  }).toList(),
                  onChanged: (v) => setDialogState(() => clienteId = v),
                  decoration: _inputDeco('Cliente'),
                  dropdownColor: ColorApp.colorElevado,
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: origenTipo,
                  items: const [
                    DropdownMenuItem(value: 'venta', child: Text('Venta', style: TextStyle(color: ColorApp.colorTexto))),
                    DropdownMenuItem(value: 'renta', child: Text('Renta', style: TextStyle(color: ColorApp.colorTexto))),
                  ],
                  onChanged: (v) => setDialogState(() => origenTipo = v!),
                  decoration: _inputDeco('Origen'),
                  dropdownColor: ColorApp.colorElevado,
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: origenIdCtrl,
                  keyboardType: TextInputType.number,
                  decoration: _inputDeco('ID de $origenTipo'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final exito = await context.read<DeudasProvider>().crearDeuda({
                  'cliente_id': clienteId,
                  'origen_tipo': origenTipo,
                  'origen_id': int.tryParse(origenIdCtrl.text),
                });
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                ToastNotificacion.mostrar(
                  context,
                  mensaje: exito ? 'Deuda creada con éxito' : 'Error al crear deuda',
                  tipo: exito ? TipoToast.exito : TipoToast.error,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text('Crear Deuda'),
            ),
          ],
        ),
      ),
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormulario,
        backgroundColor: ColorApp.colorAcento,
        child: const Icon(Icons.add, color: Colors.white),
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
          final estado = deuda.estado ?? 'desconocido';
          final colorEstado = estado == 'pagado' ? ColorApp.colorExito : ColorApp.colorAdvertencia;
          return ItemLista(
            titulo: 'Deuda #${deuda.id}',
            subtitulo: deuda.clienteId != null ? 'Cliente: #${deuda.clienteId}' : 'Sin cliente',
            detalle: '\$${deuda.saldo?.toStringAsFixed(0) ?? '0'}',
            icono: Icons.account_balance,
            colorIcono: colorEstado,
            onTap: () => _mostrarDetalleConPago(deuda),
          );
        },
      ),
    );
  }
}
