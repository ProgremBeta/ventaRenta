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
      final p = context.read<VentasProvider>();
      p.fetchVentas();
      p.fetchClientes();
      p.fetchMetodoPago();
      p.fetchUsuarios();
    });
  }

  String _nombreOperario(VentasProvider p, int? usuarioId) {
    if (usuarioId == null) return '—';
    final u = p.usuarios.where((u) => u['id'] == usuarioId).firstOrNull;
    return u?['nombre'] as String? ?? 'Usuario #$usuarioId';
  }

  String _nombreCliente(VentasProvider p, int? clienteId) {
    if (clienteId == null) return 'Sin cliente';
    final c = p.clientes.where((c) => c.id == clienteId).firstOrNull;
    return c?.nombre ?? 'Cliente #$clienteId';
  }

  String _nombreMetodoPago(VentasProvider p, int? metodoPagoId) {
    if (metodoPagoId == null) return '—';
    final mp = p.metodoPago.where((m) => m.id == metodoPagoId).firstOrNull;
    return mp?.nombre ?? 'Método #$metodoPagoId';
  }

  void _mostrarDetalle(Venta venta) {
    final provider = context.read<VentasProvider>();
    provider.fetchDetalleVenta(venta.id);

    String fechaDB = venta.fechaCreacion.toString();
    double valorDB = venta.total;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorApp.colorSegundario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Venta: ${venta.id}', style: const TextStyle(color: ColorApp.colorTitulo)),
        content: Consumer<VentasProvider>(
          builder: (context, p, _) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detalleRow('Operario', _nombreOperario(p, venta.usuarioId)),
                  _detalleRow('Cliente', _nombreCliente(p, venta.clienteId)),
                  _detalleRow('Total', FormatoMoneda(valorDB)),
                  _detalleRow('Método pago', _nombreMetodoPago(p, venta.metodoPago)),
                  _detalleRow('Fecha', FormatoFecha(fechaDB)),
                  if (venta.estado != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text('Estado', style: TextStyle(color: ColorApp.colorSubTitulo, fontSize: 14)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: venta.estado == 'pendiente'
                                ? ColorApp.colorAdvertencia.withValues(alpha: 0.15)
                                : ColorApp.colorExito.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            venta.estado!.toUpperCase(),
                            style: TextStyle(
                              color: venta.estado == 'pendiente'
                                  ? ColorApp.colorAdvertencia
                                  : ColorApp.colorExito,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (p.detalleActual.isNotEmpty) ...[
                    const Divider(color: ColorApp.colorBordeInput, height: 24),
                    const Text('Detalles', style: TextStyle(color: ColorApp.colorTitulo, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...p.detalleActual.map((d) {
                      final prod = p.productos.where((pr) => pr.id == d.productoId).firstOrNull;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                prod?.nombre ?? 'Prod #${d.productoId}',
                                style: const TextStyle(color: ColorApp.colorTexto),
                              ),
                            ),
                            Text('x${d.cantidad ?? 0}  ', style: const TextStyle(color: ColorApp.colorSubTitulo)),
                            Text(
                              d.precioUnitario != null ? '\$${d.precioUnitario!.toStringAsFixed(0)}' : '—',
                              style: const TextStyle(color: ColorApp.colorSubTitulo),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              d.subTotal != null ? '\$${d.subTotal!.toStringAsFixed(0)}' : '—',
                              style: const TextStyle(color: ColorApp.colorAcento, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            );
          },
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

    showDialog(
      context: context,
      builder: (ctx) => _FormularioNuevaVenta(),
    );
  }

  Widget _detalleRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: ColorApp.colorSubTitulo, fontSize: 14)),
          Flexible(
            child: Text(value, style: const TextStyle(color: ColorApp.colorTexto, fontSize: 14, fontWeight: FontWeight.w500), textAlign: TextAlign.right),
          ),
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
          final Color? colorBorde;
          final Color? colorFondo;
          switch (venta.estado) {
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
              titulo: 'Venta #${venta.id} — ${_nombreOperario(provider, venta.usuarioId)}',
              subtitulo: '${_nombreCliente(provider, venta.clienteId)}  |  ${_nombreMetodoPago(provider, venta.metodoPago)}',
              detalle: FormatoMoneda(venta.total),
              onTap: () => _mostrarDetalle(venta),
            ),
          );
        },
      ),
    );
  }
}

class _DetalleProductoRow {
  int? productoId;
  int cantidad = 1;
}

class _FormularioNuevaVenta extends StatefulWidget {
  @override
  State<_FormularioNuevaVenta> createState() => _FormularioNuevaVentaState();
}

class _FormularioNuevaVentaState extends State<_FormularioNuevaVenta> {
  final _formKey = GlobalKey<FormState>();
  int? _clienteId;
  int? _metodoPago;
  final List<_DetalleProductoRow> _detalles = [_DetalleProductoRow()];
  bool _enviando = false;
  bool _creandoDeuda = false;
  String _paso = 'formulario';
  Venta? _ventaCreada;

  void _agregarDetalle() {
    setState(() => _detalles.add(_DetalleProductoRow()));
  }

  void _removerDetalle(int index) {
    if (_detalles.length > 1) {
      setState(() => _detalles.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VentasProvider>();
    final auth = context.watch<AuthProvider>();

    if (_paso == 'deuda') {
      return _buildDebtPrompt(context);
    }

    return AlertDialog(
      backgroundColor: ColorApp.colorSegundario,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Nueva Venta', style: TextStyle(color: ColorApp.colorTitulo)),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                value: _metodoPago,
                items: provider.metodoPago.map((p) {
                  return DropdownMenuItem(value: p.id, child: Text(p.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
                }).toList(),
                onChanged: (v) => _metodoPago = v,
                decoration: _inputDeco('Método de pago'),
                dropdownColor: ColorApp.colorElevado,
                style: const TextStyle(color: ColorApp.colorTexto),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                value: _clienteId,
                items: [
                  const DropdownMenuItem(value: null, child: Text('Ninguno', style: TextStyle(color: ColorApp.colorTextoMuted))),
                  ...provider.clientes.map((c) {
                    return DropdownMenuItem(value: c.id, child: Text(c.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
                  }),
                ],
                onChanged: (v) => _clienteId = v,
                decoration: _inputDeco('Cliente'),
                dropdownColor: ColorApp.colorElevado,
                style: const TextStyle(color: ColorApp.colorTexto),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Detalles', style: TextStyle(color: ColorApp.colorTitulo, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _agregarDetalle,
                    icon: const Icon(Icons.add, size: 18, color: ColorApp.colorAcento),
                    label: const Text('Agregar', style: TextStyle(color: ColorApp.colorAcento)),
                  ),
                ],
              ),
              ...List.generate(_detalles.length, (i) {
                final d = _detalles[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<int>(
                          value: d.productoId,
                          items: provider.productos.map((p) {
                            return DropdownMenuItem(value: p.id, child: Text(p.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
                          }).toList(),
                          onChanged: (v) => d.productoId = v,
                          decoration: _inputDeco('Producto ${i + 1}'),
                          dropdownColor: ColorApp.colorElevado,
                          style: const TextStyle(color: ColorApp.colorTexto),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: d.cantidad.toString(),
                          keyboardType: TextInputType.number,
                          decoration: _inputDeco('Cant'),
                          style: const TextStyle(color: ColorApp.colorTexto),
                          onChanged: (v) => d.cantidad = int.tryParse(v) ?? 1,
                        ),
                      ),
                      if (_detalles.length > 1)
                        IconButton(
                          onPressed: () => _removerDetalle(i),
                          icon: const Icon(Icons.remove_circle, color: ColorApp.colorError, size: 20),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
        ),
        ElevatedButton.icon(
          onPressed: _enviando ? null : () async {
            if (!_formKey.currentState!.validate()) return;
            setState(() => _enviando = true);

            final detallesValidos = _detalles
                .where((d) => d.productoId != null)
                .map((d) => {'producto_id': d.productoId, 'cantidad': d.cantidad})
                .toList();

            if (detallesValidos.isEmpty) {
              setState(() => _enviando = false);
              ToastNotificacion.mostrar(context, mensaje: 'Agrega al menos un producto', tipo: TipoToast.error);
              return;
            }

            final ventaCreada = await context.read<VentasProvider>().crearVenta({
              'usuario_id': auth.userRolId ?? 1,
              'metodo_pago': _metodoPago,
              if (_clienteId != null) 'cliente_id': _clienteId,
              'detalles': detallesValidos,
            });

            if (!mounted) return;

            if (ventaCreada == null) {
              Navigator.pop(context);
              ToastNotificacion.mostrar(context, mensaje: 'Error al crear venta', tipo: TipoToast.error);
              return;
            }

            if (_clienteId != null) {
              setState(() {
                _ventaCreada = ventaCreada;
                _paso = 'deuda';
                _enviando = false;
              });
            } else {
              Navigator.pop(context);
              ToastNotificacion.mostrar(context, mensaje: 'Venta creada con éxito', tipo: TipoToast.exito);
            }
          },
          icon: const Icon(Icons.check, color: Colors.white, size: 18),
          label: _enviando
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Crear Venta'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorApp.colorAcento,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildDebtPrompt(BuildContext context) {
    final venta = _ventaCreada!;
    return AlertDialog(
      backgroundColor: ColorApp.colorSegundario,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Venta creada', style: TextStyle(color: ColorApp.colorTitulo)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Venta #${venta.id} — ${FormatoMoneda(venta.total)}',
            style: const TextStyle(color: ColorApp.colorTexto, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            '¿Deseas crear una deuda para esta venta?',
            style: TextStyle(color: ColorApp.colorSubTitulo, fontSize: 14),
          ),
          if (_creandoDeuda) ...[
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: ColorApp.colorAcento),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _creandoDeuda ? null : () => Navigator.pop(context),
          child: const Text('No', style: TextStyle(color: ColorApp.colorTextoMuted)),
        ),
        ElevatedButton.icon(
          onPressed: _creandoDeuda ? null : () async {
            setState(() => _creandoDeuda = true);
            final exito = await context.read<VentasProvider>().crearDeuda({
              'cliente_id': venta.clienteId,
              'origen_tipo': 1,
              'origen_id': venta.id,
            });
            if (!mounted) return;
            Navigator.pop(context);
            ToastNotificacion.mostrar(
              context,
              mensaje: exito ? 'Venta creada con deuda' : 'Venta creada, error al crear deuda',
              tipo: exito ? TipoToast.exito : TipoToast.advertencia,
            );
          },
          icon: const Icon(Icons.account_balance, color: Colors.white, size: 18),
          label: const Text('Sí, crear deuda'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorApp.colorAdvertencia,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
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
