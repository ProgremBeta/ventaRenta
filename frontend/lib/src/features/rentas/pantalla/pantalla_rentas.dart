import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/models/renta.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/widgets/item_lista.dart';
import 'package:frontend/src/core/widgets/global_notificacion.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/features/rentas/provider/rentas_provider.dart';

class PantallaRentas extends StatefulWidget {
  const PantallaRentas({super.key});

  @override
  State<PantallaRentas> createState() => _PantallaRentasState();
}

class _PantallaRentasState extends State<PantallaRentas> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<RentasProvider>();
      p.fetchRentas();
      p.fetchDispositivos();
      p.fetchMetodosPago();
    });
  }

  Duration _calcularTiempoTranscurrido(String? fechaInicio) {
    if (fechaInicio == null) return Duration.zero;
    final inicio = DateTime.tryParse(fechaInicio);
    if (inicio == null) return Duration.zero;
    return DateTime.now().difference(inicio);
  }

  double _precioFinal(Renta r) {
    return r.precioTotal ?? 0;
  }

  void _mostrarDetalle(Renta renta) {
    final provider = context.read<RentasProvider>();
    provider.fetchRentaPorId(renta.id);

    final esActiva = renta.estado == 'renta';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorApp.colorSegundario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Renta #${renta.id}', style: const TextStyle(color: ColorApp.colorTitulo)),
        content: Consumer<RentasProvider>(
          builder: (context, p, _) {
            final r = p.rentaActual ?? renta;
            final transcurrido = esActiva ? _calcularTiempoTranscurrido(r.fechaInicio) : Duration.zero;
            final precioEstimado = esActiva ? _precioFinal(r) : 0.0;

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detalleRow('Inicio', r.fechaInicio ?? '—'),
                  _detalleRow('Fin', r.fechaFin ?? '—'),
                  _detalleRow('Estado', r.estado ?? '—'),
                  if (esActiva) ...[
                    const Divider(color: ColorApp.colorBordeInput, height: 24),
                    _detalleRow('Tiempo transcurrido', '${transcurrido.inHours}h ${transcurrido.inMinutes % 60}m'),
                    _detalleRow('Precio estimado', '\$${precioEstimado.toStringAsFixed(0)}'),
                  ],
                  if (!esActiva) ...[
                    _detalleRow('Tiempo total', r.tiempoTotal ?? '—'),
                    _detalleRow('Precio total', r.precioTotal != null ? '\$${r.precioTotal!.toStringAsFixed(0)}' : '—'),
                  ],
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: ColorApp.colorTextoMuted)),
          ),
          if (esActiva) ...[
            TextButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _mostrarExtenderRenta(renta);
              },
              icon: const Icon(Icons.update, color: ColorApp.colorAcento, size: 18),
              label: const Text('Extender', style: TextStyle(color: ColorApp.colorAcento)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(ctx);
                _mostrarFinalizarRenta(renta);
              },
              icon: const Icon(Icons.stop_circle, color: Colors.white, size: 18),
              label: const Text('Detener renta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorError,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _mostrarFinalizarRenta(Renta renta) {
    bool enviando = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Finalizar renta', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Consumer<RentasProvider>(
            builder: (context, prov, _) {
              final r = prov.rentaActual ?? renta;
              final transcurrido = _calcularTiempoTranscurrido(r.fechaInicio);
              final precioFinal = _precioFinal(r);
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Renta #${r.id}', style: const TextStyle(color: ColorApp.colorTexto)),
                  const SizedBox(height: 8),
                  _detalleRow('Tiempo', '${transcurrido.inHours}h ${transcurrido.inMinutes % 60}m'),
                  _detalleRow('Total a pagar', '\$${precioFinal.toStringAsFixed(0)}'),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
            ),
            ElevatedButton.icon(
              onPressed: enviando ? null : () async {
                setState(() => enviando = true);
                final prov = context.read<RentasProvider>();
                final r = prov.rentaActual ?? renta;
                final transcurrido = _calcularTiempoTranscurrido(r.fechaInicio);
                final precioTotal = _precioFinal(r);

                final data = {
                  'estado': 'finalizada',
                  'fecha_fin': DateTime.now().toIso8601String(),
                  'tiempo_total': '${transcurrido.inHours}h ${transcurrido.inMinutes % 60}m',
                  'precio_total': precioTotal,
                };
                final exito = await prov.service.actualizarRenta(renta.id, data);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                if (exito != null) {
                  GlobalNotificacion.exito('Renta finalizada — Total: \$${precioTotal.toStringAsFixed(0)}');
                  prov.fetchRentas();
                } else {
                  GlobalNotificacion.error('Error al finalizar renta');
                }
              },
              icon: const Icon(Icons.check, color: Colors.white, size: 18),
              label: enviando
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Confirmar'),
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

  void _mostrarExtenderRenta(Renta renta) {
    final horasCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool enviando = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Extender renta', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Renta #${renta.id}', style: const TextStyle(color: ColorApp.colorSubTitulo)),
                const SizedBox(height: 4),
                Text('Fin actual: ${renta.fechaFin ?? '—'}', style: const TextStyle(color: ColorApp.colorTextoMuted, fontSize: 13)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: horasCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Horas a agregar (ej: 1.5)',
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
                    if (v == null || v.isEmpty) return 'Requerido';
                    final h = double.tryParse(v);
                    if (h == null || h <= 0) return 'Ingrese un número válido';
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
                final horasExtra = double.parse(horasCtrl.text);
                final prov = context.read<RentasProvider>();
                final r = prov.rentaActual ?? renta;
                final inicio = DateTime.tryParse(r.fechaInicio ?? '');
                final finOrig = DateTime.tryParse(r.fechaFin ?? '');
                if (inicio == null || finOrig == null) return;
                final nuevoFin = finOrig.add(Duration(minutes: (horasExtra * 60).round()));
                final duracionOrig = finOrig.difference(inicio).inMinutes / 60.0;
                final precioPorHora = duracionOrig > 0 ? (r.precioTotal ?? 0) / duracionOrig : 0;
                final precioTotal = precioPorHora * (duracionOrig + horasExtra);

                final data = {
                  'fecha_fin': nuevoFin.toIso8601String(),
                  'precio_total': precioTotal,
                  'tiempo_total': '${nuevoFin.difference(DateTime.tryParse(renta.fechaInicio ?? '')!).inHours}h ${nuevoFin.difference(DateTime.tryParse(renta.fechaInicio ?? '')!).inMinutes % 60}m',
                  'estado': 'renta',
                };
                final exito = await prov.service.actualizarRenta(renta.id, data);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                if (exito != null) {
                  GlobalNotificacion.exito('Renta extendida hasta ${nuevoFin.day}/${nuevoFin.month} ${nuevoFin.hour}:${nuevoFin.minute.toString().padLeft(2, '0')}');
                  prov.fetchRentas();
                } else {
                  GlobalNotificacion.error('Error al extender renta');
                }
              },
              icon: const Icon(Icons.update, color: Colors.white, size: 18),
              label: enviando
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Extender'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento,
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

  void _mostrarFormulario() {
    final provider = context.read<RentasProvider>();
    provider.fetchDispositivos();
    provider.fetchClientes();
    provider.fetchMetodosPago();

    showDialog(
      context: context,
      builder: (ctx) => _FormularioNuevaRenta(),
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
    final provider = context.watch<RentasProvider>();

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        title: const Text('Rentas'),
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

  Widget _buildBody(RentasProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: ColorApp.colorAcento));
    }
    if (provider.error != null) {
      return Center(
        child: Text(provider.error!, style: const TextStyle(color: ColorApp.colorError)),
      );
    }
    if (provider.rentas.isEmpty) {
      return const Center(
        child: Text('No hay rentas registradas', style: TextStyle(color: ColorApp.colorTextoMuted)),
      );
    }
    return RefreshIndicator(
      color: ColorApp.colorAcento,
      onRefresh: provider.fetchRentas,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: provider.rentas.length,
        itemBuilder: (context, index) {
          final renta = provider.rentas[index];
          final esActiva = renta.estado == 'renta';
          return ItemLista(
            titulo: '#${renta.id}  ${provider.dispositivos.where((d) => renta.id == d.id).firstOrNull?.nombre ?? ''}',
            subtitulo: '${renta.fechaInicio ?? '—'}  |  ${renta.estado ?? '—'}',
            detalle: esActiva ? 'En renta' : (renta.tiempoTotal ?? ''),
            onTap: () => _mostrarDetalle(renta),
            colorFondo: esActiva ? ColorApp.colorExito.withValues(alpha: 0.08) : null,
            colorBorde: esActiva ? ColorApp.colorExito : null,
          );
        },
      ),
    );
  }
}

class _FormularioNuevaRenta extends StatefulWidget {
  @override
  State<_FormularioNuevaRenta> createState() => _FormularioNuevaRentaState();
}

class _FormularioNuevaRentaState extends State<_FormularioNuevaRenta> {
  final _formKey = GlobalKey<FormState>();
  int? _dispositivoId;
  int? _metodoPagoId;
  int? _clienteId;
  final _duracionCtrl = TextEditingController();
  bool _enviando = false;

  @override
  void dispose() {
    _duracionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RentasProvider>();
    final auth = context.read<AuthProvider>();

    return AlertDialog(
      backgroundColor: ColorApp.colorSegundario,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Nueva Renta', style: TextStyle(color: ColorApp.colorTitulo)),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              initialValue: _dispositivoId,
              items: provider.dispositivos.map((d) {
                final enRenta = d.estado == 'en renta';
                return DropdownMenuItem(
                  value: d.id,
                  enabled: !enRenta,
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: enRenta ? ColorApp.colorError : ColorApp.colorExito,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${d.nombre ?? 'Disp #${d.id}'} — \$${(d.precioHora ?? 0).toStringAsFixed(0)}/h',
                        style: TextStyle(
                          color: enRenta ? ColorApp.colorTextoMuted : ColorApp.colorTexto,
                          decoration: enRenta ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (v) => _dispositivoId = v,
              decoration: _inputDeco('Dispositivo'),
              dropdownColor: ColorApp.colorElevado,
              style: const TextStyle(color: ColorApp.colorTexto),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _duracionCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: _inputDeco('Duración (horas, ej: 1.5)'),
              style: const TextStyle(color: ColorApp.colorTexto),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Requerido';
                final d = double.tryParse(v);
                if (d == null || d <= 0) return 'Ingrese un número válido';
                return null;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: _metodoPagoId,
              items: provider.metodosPago.map((m) {
                return DropdownMenuItem(value: m.id, child: Text(m.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
              }).toList(),
              onChanged: (v) => _metodoPagoId = v,
              decoration: _inputDeco('Método de pago'),
              dropdownColor: ColorApp.colorElevado,
              style: const TextStyle(color: ColorApp.colorTexto),
              validator: (v) => v == null ? 'Seleccione un método' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: _clienteId,
              items: [
                const DropdownMenuItem(value: null, child: Text('Sin cliente', style: TextStyle(color: ColorApp.colorTextoMuted))),
                ...provider.clientes.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nombre, style: const TextStyle(color: ColorApp.colorTexto)))),
              ],
              onChanged: (v) => _clienteId = v,
              decoration: _inputDeco('Cliente (opcional)'),
              dropdownColor: ColorApp.colorElevado,
              style: const TextStyle(color: ColorApp.colorTexto),
            ),
          ],
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

            final dispositivo = provider.dispositivos.where((d) => d.id == _dispositivoId).firstOrNull;
            final duracionHoras = double.parse(_duracionCtrl.text);
            final ahora = DateTime.now();
            final fechaFin = ahora.add(Duration(minutes: (duracionHoras * 60).round()));

            final data = <String, dynamic>{
              'usuario_id': auth.userId ?? 1,
              'fecha_inicio': ahora.toIso8601String(),
              'fecha_fin': fechaFin.toIso8601String(),
              'duracion': duracionHoras,
              'metodo_pago': _metodoPagoId,
              'dispositivo_id': _dispositivoId,
              'precio_hora': dispositivo?.precioHora?.toInt() ?? 0,
              if (_clienteId != null) 'cliente_id': _clienteId,
            };
            debugPrint("📡 [RentaForm] data a enviar: $data");

            final exito = await context.read<RentasProvider>().iniciarRenta(data);

            if (!mounted) return;
            Navigator.pop(context);

            if (exito) {
              GlobalNotificacion.exito('Renta iniciada con éxito');
            } else {
              GlobalNotificacion.error('Error al iniciar renta');
            }
          },
          icon: const Icon(Icons.check, color: Colors.white, size: 18),
          label: _enviando
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Iniciar Renta'),
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
