import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:frontend/src/core/widgets/global_notificacion.dart';
import 'package:frontend/src/features/deudas/provider/deudas_provider.dart';
import 'package:frontend/src/features/ventas/provider/ventas_provider.dart';
import 'package:frontend/src/features/rentas/provider/rentas_provider.dart';
import 'package:frontend/src/features/categorias/service/categorias_service.dart';
import 'package:frontend/src/features/productos/service/productos_service.dart';
import 'package:frontend/src/features/clientes/service/clientes_service.dart';
import 'package:frontend/src/features/dispositivos/service/dispositivos_service.dart';

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
    final rentasActivas = rentas.rentas.where((r) => r.estado == 'renta').length;
    final deudasPendientes = deudas.deudas.where((d) => d.estado != 'pagado' && d.estado != 'pago').length;
    final totalDeudas = deudas.deudas.where((d) => d.estado != 'pagado' && d.estado != 'pago').fold<double>(0, (sum, d) => sum + (d.saldo ?? 0));

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        title: const Text("INICIO"),
        backgroundColor: ColorApp.colorNavBar,
        titleTextStyle: const TextStyle(color: ColorApp.colorTitulo, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0,
        actions: [
          Text(' ${auth.userName ?? 'Usuario'}'),
          IconButton(
            icon: const Icon(Icons.person, color: ColorApp.colorAcento),
            tooltip: 'Perfil',
            onPressed: () => context.push('/perfil'),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(EstilosApp.paddingGeneral),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _tarjetaResumen(
                    icono: Icons.sell,
                    titulo: 'Ventas totales',
                    valor: '\$${totalVentas.toStringAsFixed(0)}',
                    color: ColorApp.colorAcento,
                  ),
                  const SizedBox(height: 12),
                  _tarjetaResumen(
                    icono: Icons.videogame_asset,
                    titulo: 'Rentas activas',
                    valor: '$rentasActivas',
                    color: ColorApp.colorExito,
                  ),
                  const SizedBox(height: 12),
                  _tarjetaResumen(
                    icono: Icons.account_balance,
                    titulo: 'Deudas pendientes',
                    valor: '$deudasPendientes (\$${totalDeudas.toStringAsFixed(0)})',
                    color: ColorApp.colorAdvertencia,
                  ),
                  const SizedBox(height: 24),
                  _botonAdmin(
                    label: 'Categorías',
                    icono: Icons.category,
                    onTap: () => _mostrarMenuCategorias(context),
                  ),
                  const SizedBox(height: 12),
                  _botonAdmin(
                    label: 'Nuevo producto',
                    icono: Icons.add_box,
                    onTap: () => _mostrarNuevoProducto(context),
                  ),
                  const SizedBox(height: 12),
                  _botonAdmin(
                    label: 'Nuevo dispositivo',
                    icono: Icons.devices_other,
                    onTap: () => _mostrarNuevoDispositivo(context),
                  ),
                  const SizedBox(height: 12),
                  _botonAdmin(
                    label: 'Nuevo cliente',
                    icono: Icons.person_add,
                    onTap: () => _mostrarNuevoCliente(context),
                  ),
                  const SizedBox(height: 12),
                  _botonAdmin(
                    label: 'Inventario',
                    icono: Icons.inventory,
                    onTap: () => context.go('/inventario'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonAdmin({required String label, required IconData icono, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icono, color: ColorApp.colorAcento, size: 20),
        label: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorApp.colorElevado,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: ColorApp.colorBordeInput),
          elevation: 0,
        ),
      ),
    );
  }

  void _mostrarMenuCategorias(BuildContext context) {
    String? vista = 'menu';
    final nombreCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          final service = CategoriasService();
          final bool isCreating = vista == 'crearProducto' || vista == 'crearDispositivo';
          final String tipo = vista?.replaceFirst('crear', '').toLowerCase() ?? '';

          return AlertDialog(
            backgroundColor: ColorApp.colorSegundario,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              isCreating
                  ? 'Categoría ${tipo == 'producto' ? 'producto' : 'dispositivo'}'
                  : 'Categorías',
              style: const TextStyle(color: ColorApp.colorTitulo),
            ),
            content: isCreating
                ? Form(
                    key: GlobalKey<FormState>(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nombreCtrl,
                          decoration: _inputDeco('Nombre'),
                          style: const TextStyle(color: ColorApp.colorTexto),
                          validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: descCtrl,
                          decoration: _inputDeco('Descripción (opcional)'),
                          style: const TextStyle(color: ColorApp.colorTexto),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            nombreCtrl.clear();
                            descCtrl.clear();
                            setState(() => vista = 'crearProducto');
                          },
                          icon: const Icon(Icons.category, color: Colors.white, size: 20),
                          label: const Text('Categoría producto'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.colorAcento,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            nombreCtrl.clear();
                            descCtrl.clear();
                            setState(() => vista = 'crearDispositivo');
                          },
                          icon: const Icon(Icons.devices, color: Colors.white, size: 20),
                          label: const Text('Categoría dispositivo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.colorAcento,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
            actions: isCreating
                ? [
                    TextButton(
                      onPressed: () {
                        nombreCtrl.clear();
                        descCtrl.clear();
                        setState(() => vista = 'menu');
                      },
                      child: const Text('Atrás', style: TextStyle(color: ColorApp.colorTextoMuted)),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (!(nombreCtrl.text.isNotEmpty)) return;
                        final body = <String, dynamic>{'nombre': nombreCtrl.text};
                        if (descCtrl.text.isNotEmpty) body['descripcion'] = descCtrl.text;
                        final exito = tipo == 'producto'
                            ? await service.crearCategoriaProducto(body)
                            : await service.crearCategoriaDispositivo(body);
                        if (!ctx.mounted) return;
                        Navigator.pop(ctx);
                        GlobalNotificacion.mostrar(
                          mensaje: exito ? 'Categoría creada' : 'Error al crear categoría',
                          color: exito ? ColorApp.colorExito : ColorApp.colorError,
                        );
                      },
                      icon: const Icon(Icons.save, color: Colors.white, size: 18),
                      label: const Text('Crear'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
                      ),
                    ),
                  ]
                : [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
                    ),
                  ],
          );
        },
      ),
    );
  }

  void _mostrarNuevoProducto(BuildContext context) async {
    final nombreCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final precioCtrl = TextEditingController();
    final stockCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final service = ProductosService();
    final catService = CategoriasService();
    int? categoriaId;

    final categorias = await catService.categoriasProductos();
    if (!context.mounted) return;

    
    bool enviando = false;
    
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {

          return AlertDialog(
            backgroundColor: ColorApp.colorSegundario,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Nuevo producto', style: TextStyle(color: ColorApp.colorTitulo)),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: _inputDeco('Nombre'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                    validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: descCtrl,
                    decoration: _inputDeco('Descripción (opcional)'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: precioCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _inputDeco('Precio'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                    validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: stockCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _inputDeco('Stock (opcional)'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: categoriaId,
                    items: categorias.map((c) {
                      final id = c['id'] as int?;
                      final nom = c['nombre'] as String? ?? 'Categoría #$id';
                      return DropdownMenuItem(value: id, child: Text(nom, style: const TextStyle(color: ColorApp.colorTexto)));
                    }).toList(),
                    onChanged: (v) => setState(() => categoriaId = v),
                    decoration: _inputDeco('Categoría'),
                    dropdownColor: ColorApp.colorElevado,
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
              ElevatedButton.icon(
                onPressed: enviando ? null : () async {
                  if (!formKey.currentState!.validate()) return;
                  setState(() => enviando = true);
                  final exito = await service.crearProducto({
                    'nombre': nombreCtrl.text,
                    if (descCtrl.text.isNotEmpty) 'descripcion': descCtrl.text,
                    'precio': double.tryParse(precioCtrl.text) ?? 0,
                    'categoria_id': categoriaId,
                    if (stockCtrl.text.isNotEmpty) 'stock': int.tryParse(stockCtrl.text),
                  });
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                  GlobalNotificacion.mostrar(
                    mensaje: exito ? 'Producto creado' : 'Error al crear producto',
                    color: exito ? ColorApp.colorExito : ColorApp.colorError,
                  );
                },
                icon: const Icon(Icons.save, color: Colors.white, size: 18),
                label: Text(enviando ? '' : 'Crear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _mostrarNuevoDispositivo(BuildContext context) async {
    final nombreCtrl = TextEditingController();
    final precioCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final service = DispositivosService();
    final catService = CategoriasService();
    int? categoriaId;

    final categorias = await catService.categoriasDispositivos();
    if (!context.mounted) return;

    bool enviando = false;
    
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {

          return AlertDialog(
            backgroundColor: ColorApp.colorSegundario,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Nuevo dispositivo', style: TextStyle(color: ColorApp.colorTitulo)),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: _inputDeco('Nombre'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                    validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: precioCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _inputDeco('Precio por hora'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                    validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: categoriaId,
                    items: categorias.map((c) {
                      final id = c['id'] as int?;
                      final nom = c['nombre'] as String? ?? 'Categoría #$id';
                      return DropdownMenuItem(value: id, child: Text(nom, style: const TextStyle(color: ColorApp.colorTexto)));
                    }).toList(),
                    onChanged: (v) => setState(() => categoriaId = v),
                    decoration: _inputDeco('Categoría'),
                    dropdownColor: ColorApp.colorElevado,
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
              ElevatedButton.icon(
                onPressed: enviando ? null : () async {
                  if (!formKey.currentState!.validate()) return;
                  setState(() => enviando = true);
                  final exito = await service.crearDispositivo({
                    'nombre': nombreCtrl.text,
                    'precio_hora': double.tryParse(precioCtrl.text) ?? 0,
                    'categoria_id': categoriaId,
                  });
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                  GlobalNotificacion.mostrar(
                    mensaje: exito ? 'Dispositivo creado' : 'Error al crear dispositivo',
                    color: exito ? ColorApp.colorExito : ColorApp.colorError,
                  );
                },
                icon: const Icon(Icons.save, color: Colors.white, size: 18),
                label: Text(enviando ? '' : 'Crear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _mostrarNuevoCliente(BuildContext context) {
    final nombreCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final telefonoCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final service = ClienteService();
    bool enviando = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: ColorApp.colorSegundario,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text('Nuevo cliente', style: TextStyle(color: ColorApp.colorTitulo)),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: _inputDeco('Nombre'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                    validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: _inputDeco('Email (opcional)'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: telefonoCtrl,
                    decoration: _inputDeco('Teléfono (opcional)'),
                    style: const TextStyle(color: ColorApp.colorTexto),
                    keyboardType: TextInputType.phone,
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
                  final data = <String, dynamic>{
                    'nombre': nombreCtrl.text,
                    if (emailCtrl.text.isNotEmpty) 'email': emailCtrl.text,
                    if (telefonoCtrl.text.isNotEmpty) 'telefono': telefonoCtrl.text,
                  };
                  final exito = await service.crearCliente(data);
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                  GlobalNotificacion.mostrar(
                    mensaje: exito ? 'Cliente creado' : 'Error al crear cliente',
                    color: exito ? ColorApp.colorExito : ColorApp.colorError,
                  );
                },
                icon: const Icon(Icons.save, color: Colors.white, size: 18),
                label: Text(enviando ? '' : 'Crear'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tarjetaResumen({
    required IconData icono,
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
            child: Icon(icono, color: color, size: 28),
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
