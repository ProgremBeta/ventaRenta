import 'package:flutter/material.dart';
import 'package:frontend/src/utils/convertidor_fecha.dart';
import 'package:frontend/src/utils/convertidor_moneda.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/models/venta.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/widgets/item_lista.dart';
import 'package:frontend/src/core/widgets/toast_notificacion.dart';
import 'package:frontend/src/features/ventas/provider/ventas_provider.dart';

class PantallaVentas extends StatefulWidget {
  const PantallaVentas({super.key});

  @override
  State<PantallaVentas> createState() => _PantallaVentasState();
}

class _PantallaVentasState extends State<PantallaVentas> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VentasProvider>().fetchVentas();
    });
  }

  void _mostrarDetalle(Venta venta) {
    String fechaDB = venta.fechaCreacion.toString();
    double valorDB = venta.total;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorApp.colorSegundario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('venta: ${venta.id}', style: const TextStyle(color: ColorApp.colorTitulo)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detalleRow('Usuario ', venta.usuarioId.toString()),
            _detalleRow('Cliente ID', venta.clienteId?.toString() ?? 'no registrado'),
            _detalleRow('Total', FormatoMoneda(valorDB)),
            _detalleRow('Método pago', venta.metodoPago.toString()),
            _detalleRow('Fecha', FormatoFecha(fechaDB)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: ColorApp.colorAcento)),
          ),
        ],
      ),
    );
  }

  void _mostrarFormulario() {
    final provider = context.read<VentasProvider>();
    provider.fetchClientes();
    provider.fetchProductos();
    provider.fetchMetodoPago();

    final usuarioId = context.read<AuthProvider>().userRolId;

    showDialog(
      context: context,
      builder: (ctx) => _FormularioNuevaVenta(usuarioId: usuarioId),
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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VentasProvider>();

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        title: const Text('Ventas'),
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

  Widget _buildBody(VentasProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: ColorApp.colorAcento));
    }
    if (provider.error != null) {
      return Center(
        child: Text(provider.error!, style: const TextStyle(color: ColorApp.colorError)),
      );
    }
    if (provider.ventas.isEmpty) {
      return const Center(
        child: Text('No hay ventas registradas', style: TextStyle(color: ColorApp.colorTextoMuted)),
      );
    }
    
    return RefreshIndicator(
      color: ColorApp.colorAcento,
      onRefresh: provider.fetchVentas,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: provider.ventas.length,
        itemBuilder: (context, index) {
          final venta = provider.ventas[index];
          double valorDB = venta.total;
          return ItemLista(
            titulo: 'id de venta: ${venta.id}',
            subtitulo: venta.clienteId != null ? 'Cliente: #${venta.clienteId}' : 'cliente no registrado',
            detalle: FormatoMoneda(valorDB),
            icono: Icons.receipt_long,
            onTap: () => _mostrarDetalle(venta),
          );
        },
      ),
    );
  }
}

class _FormularioNuevaVenta extends StatefulWidget {
  final int? usuarioId;
  const _FormularioNuevaVenta({this.usuarioId});

  @override
  State<_FormularioNuevaVenta> createState() => _FormularioNuevaVentaState();
}

class _FormularioNuevaVentaState extends State<_FormularioNuevaVenta> {
  final _formKey = GlobalKey<FormState>();
  int? _clienteId;
  int? _productoId;
  int? _metodoPago;
  int _cantidad = 1;
  bool _enviando = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VentasProvider>();

    return AlertDialog(
      backgroundColor: ColorApp.colorSegundario,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Nueva Venta', style: TextStyle(color: ColorApp.colorTitulo)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            DropdownButtonFormField<int>(
              value: _clienteId,
              items: provider.clientes.map((c) {
                return DropdownMenuItem(value: c.id, child: Text(c.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
              }).toList(),
              onChanged: (v) => _clienteId = v,
              decoration: _inputDeco('Cliente'),
              dropdownColor: ColorApp.colorElevado,
              style: const TextStyle(color: ColorApp.colorTexto),
            ),

            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _metodoPago,
              items: provider.metodoPago.map((p) {
                return DropdownMenuItem(value: p.id, child: Text(p.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
              }).toList(),
              onChanged: (v) => _metodoPago = v,
              decoration: _inputDeco('metodo de pago'),
              dropdownColor: ColorApp.colorElevado,
              style: const TextStyle(color: ColorApp.colorTexto),
            ),
 
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: _productoId,
              items: provider.productos.map((p) {
                return DropdownMenuItem(value: p.id, child: Text(p.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
              }).toList(),
              onChanged: (v) => _productoId = v,
              decoration: _inputDeco('Producto'),
              dropdownColor: ColorApp.colorElevado,
              style: const TextStyle(color: ColorApp.colorTexto),
            ),

            const SizedBox(height: 12),
            TextFormField(
              initialValue: '1',
              keyboardType: TextInputType.number,
              decoration: _inputDeco('Cantidad'),
              style: const TextStyle(color: ColorApp.colorTexto),
              onChanged: (v) => _cantidad = int.tryParse(v) ?? 1,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
        ),
        ElevatedButton(
          onPressed: _enviando ? null : () async {
            if (!_formKey.currentState!.validate()) return;
            setState(() => _enviando = true);

            final exito = await context.read<VentasProvider>().crearVenta({
              'usuario_id': widget.usuarioId ?? 1,
              'metodo_pago': 1,
              'cliente_id': _clienteId,
              'detalles': [
                {'producto_id': _productoId, 'cantidad': _cantidad},
              ],
            });

            if (!mounted) return;
            Navigator.pop(context);

            if (exito) {
              ToastNotificacion.mostrar(context, mensaje: 'Venta creada con éxito', tipo: TipoToast.exito);
            } else {
              ToastNotificacion.mostrar(context, mensaje: 'Error al crear venta', tipo: TipoToast.error);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorApp.colorAcento,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
          child: _enviando
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Crear Venta'),
        ),
      ],
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
}
