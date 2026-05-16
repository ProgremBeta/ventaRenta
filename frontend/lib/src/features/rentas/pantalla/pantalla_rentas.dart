import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/models/renta.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/widgets/item_lista.dart';
import 'package:frontend/src/core/widgets/toast_notificacion.dart';
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
      context.read<RentasProvider>().fetchRentas();
    });
  }

  void _mostrarDetalle(Renta renta) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorApp.colorSegundario,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Renta #${renta.id}', style: const TextStyle(color: ColorApp.colorTitulo)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detalleRow('Cliente ID', renta.clienteId?.toString() ?? '—'),
            _detalleRow('Inicio', renta.fechaInicio ?? '—'),
            _detalleRow('Fin', renta.fechaFin ?? '—'),
            _detalleRow('Total', renta.precioTotal != null ? '\$${renta.precioTotal!.toStringAsFixed(2)}' : '—'),
            _detalleRow('Estado', renta.estado ?? '—'),
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
    final provider = context.read<RentasProvider>();
    provider.fetchClientes();
    provider.fetchDispositivos();

    showDialog(
      context: context,
      builder: (ctx) => _FormularioNuevaRenta(),
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
          final estado = renta.estado ?? 'desconocido';
          final colorEstado = estado == 'activa' ? ColorApp.colorExito : ColorApp.colorTextoMuted;
          return ItemLista(
            titulo: 'Renta #${renta.id}',
            subtitulo: renta.clienteId != null ? 'Cliente: #${renta.clienteId}' : 'Sin cliente',
            detalle: renta.precioTotal != null ? '\$${renta.precioTotal!.toStringAsFixed(0)}' : null,
            icono: Icons.videogame_asset,
            colorIcono: colorEstado,
            onTap: () => _mostrarDetalle(renta),
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
  int? _clienteId;
  int? _dispositivoId;
  DateTime _fechaInicio = DateTime.now();
  DateTime _fechaFin = DateTime.now().add(const Duration(hours: 1));
  bool _enviando = false;

  Future<void> _seleccionarFecha(bool esInicio) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: esInicio ? _fechaInicio : _fechaFin,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: ColorApp.colorAcento),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(esInicio ? _fechaInicio : _fechaFin),
        builder: (context, child) => Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(primary: ColorApp.colorAcento),
          ),
          child: child!,
        ),
      );
      if (time != null) {
        final combined = DateTime(picked.year, picked.month, picked.day, time.hour, time.minute);
        setState(() {
          if (esInicio) {
            _fechaInicio = combined;
          } else {
            _fechaFin = combined;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RentasProvider>();

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
              value: _dispositivoId,
              items: provider.dispositivos.map((d) {
                return DropdownMenuItem(value: d.id, child: Text(d.nombre ?? 'Disp #${d.id}', style: const TextStyle(color: ColorApp.colorTexto)));
              }).toList(),
              onChanged: (v) => _dispositivoId = v,
              decoration: _inputDeco('Dispositivo'),
              dropdownColor: ColorApp.colorElevado,
              style: const TextStyle(color: ColorApp.colorTexto),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => _seleccionarFecha(true),
              child: InputDecorator(
                decoration: _inputDeco('Fecha inicio'),
                child: Text(
                  '${_fechaInicio.day}/${_fechaInicio.month}/${_fechaInicio.year} ${_fechaInicio.hour}:${_fechaInicio.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => _seleccionarFecha(false),
              child: InputDecorator(
                decoration: _inputDeco('Fecha fin'),
                child: Text(
                  '${_fechaFin.day}/${_fechaFin.month}/${_fechaFin.year} ${_fechaFin.hour}:${_fechaFin.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
              ),
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

            final data = {
              'cliente_id': _clienteId,
              'usuario_id': 1,
              'fecha_inicio': _fechaInicio.toIso8601String(),
              'fecha_fin': _fechaFin.toIso8601String(),
              'metodo_pago': 1,
              'dispositivos': [
                {'dispositivo_id': _dispositivoId, 'precio_hora': 5000},
              ],
            };

            final exito = await context.read<RentasProvider>().iniciarRenta(data);

            if (!mounted) return;
            Navigator.pop(context);

            if (exito) {
              ToastNotificacion.mostrar(context, mensaje: 'Renta iniciada con éxito', tipo: TipoToast.exito);
            } else {
              ToastNotificacion.mostrar(context, mensaje: 'Error al iniciar renta', tipo: TipoToast.error);
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
              : const Text('Iniciar Renta'),
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
