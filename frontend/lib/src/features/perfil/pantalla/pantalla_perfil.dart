import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/src/core/providers/auth_provider.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';
import 'package:frontend/src/core/widgets/global_notificacion.dart';
import 'package:frontend/src/features/usuarios/service/usuarios_service.dart';
import 'package:frontend/src/features/ventas/service/ventas_services.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {
  String? _rolNombre;

  @override
  void initState() {
    super.initState();
    _cargarRol();
  }

  Future<void> _cargarRol() async {
    final auth = context.read<AuthProvider>();
    final service = UsuariosService();
    final roles = await service.roles();
    if (!mounted) return;
    final rol = roles.where((r) => r['id'] == auth.userRolId).firstOrNull;
    setState(() {
      _rolNombre = rol?['nombre'] as String? ?? rol?['name'] as String? ?? 'Rol #${auth.userRolId}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: ColorApp.colorNavBar,
        titleTextStyle: const TextStyle(color: ColorApp.colorTitulo, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(EstilosApp.paddingGeneral),
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorApp.colorElevado,
                  child: Text(
                    (auth.userName ?? 'U')[0].toUpperCase(),
                    style: const TextStyle(color: ColorApp.colorAcento, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _rolNombre ?? 'Cargando...',
                  style: const TextStyle(
                    color: ColorApp.colorAcento,
                    fontSize: EstilosApp.tamanoSubtitulo - 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  auth.userName ?? 'Usuario',
                  style: const TextStyle(
                    color: ColorApp.colorTitulo,
                    fontSize: EstilosApp.tamanoSubtitulo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  auth.userIdentificacion ?? 'Sin identificación',
                  style: const TextStyle(
                    color: ColorApp.colorSubTitulo,
                    fontSize: EstilosApp.tamanoTexto - 2,
                  ),
                ),
                const SizedBox(height: 32),
                _botonAccion(
                  icono: Icons.people,
                  label: 'Usuarios',
                  onTap: () => _mostrarDialogoUsuarios(context),
                ),
                const SizedBox(height: 12),
                _botonAccion(
                  icono: Icons.payment,
                  label: 'Método de pago',
                  onTap: () => _mostrarDialogoMetodoPago(context),
                ),
                const SizedBox(height: 12),
                _botonAccion(
                  icono: Icons.shield,
                  label: 'Roles',
                  onTap: () => _mostrarDialogoRoles(context),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 220,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => auth.logout(context),
                    icon: const Icon(Icons.logout, color: Colors.white, size: 20),
                    label: const Text('Cerrar sesión', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorApp.colorError,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(EstilosApp.borderRadiusInput)),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _botonAccion({required IconData icono, required String label, required VoidCallback onTap}) {
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

  Future<void> _mostrarCrearUsuario(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final esAdmin = auth.userRolId == 1;
    final nombreCtrl = TextEditingController();
    final identCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final telefonoCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    int? rolSeleccionado = esAdmin ? null : 2;
    final service = UsuariosService();
    bool enviando = false;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Crear usuario', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: identCtrl,
                  decoration: _inputDeco('Identificación'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nombreCtrl,
                  decoration: _inputDeco('Nombre'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDeco('Email'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: telefonoCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: _inputDeco('Teléfono'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: _inputDeco('Contraseña'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                if (esAdmin) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: rolSeleccionado,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Admin', style: TextStyle(color: ColorApp.colorTexto))),
                      DropdownMenuItem(value: 2, child: Text('Usuario', style: TextStyle(color: ColorApp.colorTexto))),
                      DropdownMenuItem(value: 3, child: Text('Cajero', style: TextStyle(color: ColorApp.colorTexto))),
                    ],
                    onChanged: (v) => setState(() => rolSeleccionado = v),
                    decoration: _inputDeco('Rol'),
                    dropdownColor: ColorApp.colorElevado,
                    style: const TextStyle(color: ColorApp.colorTexto),
                  ),
                ],
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
                final data = {
                  'identificacion': identCtrl.text,
                  'nombre': nombreCtrl.text,
                  'email': emailCtrl.text,
                  'telefono': telefonoCtrl.text,
                  'contrasena_hash': passCtrl.text,
                  'rol_id': rolSeleccionado ?? 2,
                };
                final exito = await service.crearUsuario(data);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                GlobalNotificacion.mostrar(
                  mensaje: exito ? 'Usuario creado' : 'Error al crear usuario',
                  color: exito ? ColorApp.colorExito : ColorApp.colorError,
                );
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 18),
              label: Text(enviando ? '' : 'Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoUsuarios(BuildContext context) {
    final service = UsuariosService();

    service.usuarios().then((usuarios) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (ctx) {
          List<Map<String, dynamic>> listaUsuarios = List.from(usuarios);
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: ColorApp.colorSegundario,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  const Expanded(
                    child: Text('Usuarios', style: TextStyle(color: ColorApp.colorTitulo)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: ColorApp.colorAcento),
                    tooltip: 'Crear usuario',
                    onPressed: () => _mostrarCrearUsuario(context).then((_) {
                      service.usuarios().then((updated) {
                        if (context.mounted) setState(() => listaUsuarios = List.from(updated));
                      });
                    }),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: ColorApp.colorAcento),
                    tooltip: 'Editar usuario',
                    onPressed: () => _mostrarSeleccionarUsuario(context, listaUsuarios).then((_) {
                      service.usuarios().then((updated) {
                        if (context.mounted) setState(() => listaUsuarios = List.from(updated));
                      });
                    }),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: listaUsuarios.map((u) {
                    final nombre = u['nombre'] as String? ?? '';
                    final identificacion = u['identificacion'] as String? ?? '—';
                    return ListTile(
                      title: Text(nombre, style: const TextStyle(color: ColorApp.colorTexto)),
                      subtitle: Text('ID: $identificacion', style: const TextStyle(color: ColorApp.colorSubTitulo, fontSize: 13)),
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cerrar', style: TextStyle(color: ColorApp.colorAcento)),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Future<void> _mostrarSeleccionarUsuario(BuildContext context, List<Map<String, dynamic>> usuarios) async {
    final searchCtrl = TextEditingController();

    await showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final filtrados = usuarios.where((u) {
              if (searchCtrl.text.isEmpty) return false;
              return (u['nombre'] as String? ?? '')
                  .toLowerCase()
                  .contains(searchCtrl.text.toLowerCase());
            }).toList();

            return AlertDialog(
              backgroundColor: ColorApp.colorSegundario,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Seleccionar usuario', style: TextStyle(color: ColorApp.colorTitulo)),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchCtrl,
                      decoration: _inputDeco('Buscar por nombre'),
                      style: const TextStyle(color: ColorApp.colorTexto),
                      onChanged: (_) => setDialogState(() {}),
                    ),
                    const SizedBox(height: 12),
                    if (searchCtrl.text.isNotEmpty && filtrados.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Sin resultados', style: TextStyle(color: ColorApp.colorTextoMuted)),
                      )
                    else if (searchCtrl.text.isNotEmpty)
                      LimitedBox(
                        maxHeight: 260,
                        child: ListView(
                          shrinkWrap: true,
                          children: filtrados.map((u) {
                            final nombre = u['nombre'] as String? ?? '';
                            final identificacion = u['identificacion'] as String? ?? '—';
                            return ListTile(
                              dense: true,
                              title: Text(nombre, style: const TextStyle(color: ColorApp.colorTexto)),
                              subtitle: Text('ID: $identificacion', style: const TextStyle(color: ColorApp.colorSubTitulo)),
                              onTap: () {
                                Navigator.pop(ctx);
                                _mostrarEditarUsuario(context, identificacion, u);
                              },
                            );
                          }).toList(),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Escribe para buscar...', style: TextStyle(color: ColorApp.colorTextoMuted)),
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _mostrarEditarUsuario(BuildContext context, String id, Map<String, dynamic> userData) {
    final auth = context.read<AuthProvider>();
    final esAdmin = auth.userRolId == 1;
    final nombreCtrl = TextEditingController(text: userData['nombre'] as String? ?? '');
    final emailCtrl = TextEditingController(text: userData['email'] as String? ?? '');
    final telefonoCtrl = TextEditingController(text: userData['telefono'] as String? ?? '');
    final passCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final service = UsuariosService();
    int? rolSeleccionado = userData['rol_id'] as int?;
    bool enviando = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Editar usuario #$id', style: const TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nombreCtrl,
                  decoration: _inputDeco('Nombre'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailCtrl,
                  decoration: _inputDeco('Email'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: telefonoCtrl,
                  decoration: _inputDeco('Teléfono'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passCtrl,
                  obscureText: true,
                  decoration: _inputDeco('Nueva contraseña (opcional)'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                if (esAdmin) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: rolSeleccionado,
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Admin', style: TextStyle(color: ColorApp.colorTexto))),
                      DropdownMenuItem(value: 2, child: Text('Usuario', style: TextStyle(color: ColorApp.colorTexto))),
                      DropdownMenuItem(value: 3, child: Text('Cajero', style: TextStyle(color: ColorApp.colorTexto))),
                    ],
                    onChanged: (v) => setState(() => rolSeleccionado = v),
                    decoration: _inputDeco('Rol'),
                    dropdownColor: ColorApp.colorElevado,
                    style: const TextStyle(color: ColorApp.colorTexto),
                  ),
                ],
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
                  'email': emailCtrl.text,
                  'telefono': telefonoCtrl.text,
                };
                if (passCtrl.text.isNotEmpty) data['contrasena_hash'] = passCtrl.text;
                if (esAdmin && rolSeleccionado != null) data['rol_id'] = rolSeleccionado;
                final exito = await service.actualizarUsuario(id, data);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                GlobalNotificacion.mostrar(
                  mensaje: exito ? 'Usuario actualizado' : 'Error al actualizar',
                  color: exito ? ColorApp.colorExito : ColorApp.colorError,
                );
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 18),
              label: Text(enviando ? '' : 'Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoMetodoPago(BuildContext context) {
    final service = VentaServices();

    service.metodoPago().then((metodosList) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (ctx) {
          List<dynamic> listaMetodos = List.from(metodosList);
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: ColorApp.colorSegundario,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  const Expanded(
                    child: Text('Métodos de pago', style: TextStyle(color: ColorApp.colorTitulo)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: ColorApp.colorAcento),
                    tooltip: 'Crear método de pago',
                    onPressed: () => _mostrarCrearMetodoPago(context).then((_) {
                      service.metodoPago().then((updated) {
                        if (context.mounted) setState(() => listaMetodos = List.from(updated));
                      });
                    }),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: ColorApp.colorAcento),
                    tooltip: 'Actualizar método de pago',
                    onPressed: () => _mostrarActualizarMetodoPago(context).then((_) {
                      service.metodoPago().then((updated) {
                        if (context.mounted) setState(() => listaMetodos = List.from(updated));
                      });
                    }),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: listaMetodos.map((m) => ListTile(
                    title: Text(m.nombre, style: const TextStyle(color: ColorApp.colorTexto)),
                    subtitle: m.descripcion != null
                        ? Text(m.descripcion, style: const TextStyle(color: ColorApp.colorSubTitulo, fontSize: 13))
                        : null,
                    contentPadding: EdgeInsets.zero,
                  )).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cerrar', style: TextStyle(color: ColorApp.colorAcento)),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Future<void> _mostrarCrearMetodoPago(BuildContext context) async {
    final nombreCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final service = VentaServices();
    bool enviando = false;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Crear método de pago', style: TextStyle(color: ColorApp.colorTitulo)),
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
                final data = <String, dynamic>{'nombre': nombreCtrl.text};
                if (descCtrl.text.isNotEmpty) data['descripcion'] = descCtrl.text;
                final exito = await service.crearMetodoPago(data);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                if (exito) {
                  GlobalNotificacion.exito('Método de pago creado');
                }
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 18),
              label: enviando
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _mostrarActualizarMetodoPago(BuildContext context) async {
    final service = VentaServices();
    final metodos = await service.metodoPago();
    if (!context.mounted) return;

    int? metodoSeleccionado;
    final nomCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool enviando = false;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Actualizar método de pago', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  initialValue: metodoSeleccionado,
                  items: metodos.map((m) {
                    return DropdownMenuItem(value: m.id, child: Text(m.nombre, style: const TextStyle(color: ColorApp.colorTexto)));
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      metodoSeleccionado = v;
                      final encontrado = metodos.where((m) => m.id == v).firstOrNull;
                      nomCtrl.text = encontrado?.nombre ?? '';
                      descCtrl.text = encontrado?.descripcion ?? '';
                    });
                  },
                  decoration: _inputDeco('Seleccionar método'),
                  dropdownColor: ColorApp.colorElevado,
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nomCtrl,
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar', style: TextStyle(color: ColorApp.colorTextoMuted)),
            ),
            ElevatedButton.icon(
              onPressed: metodoSeleccionado == null || enviando ? null : () async {
                if (!formKey.currentState!.validate()) return;
                setState(() => enviando = true);
                final data = <String, dynamic>{'nombre': nomCtrl.text};
                if (descCtrl.text.isNotEmpty) data['descripcion'] = descCtrl.text;
                final exito = await service.actualizarMetodoPago(metodoSeleccionado!, data);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                GlobalNotificacion.mostrar(
                  mensaje: exito ? 'Método actualizado' : 'Error al actualizar',
                  color: exito ? ColorApp.colorExito : ColorApp.colorError,
                );
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 18),
              label: enviando
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoRoles(BuildContext context) {
    final service = UsuariosService();

    service.roles().then((roles) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (ctx) {
          List<Map<String, dynamic>> listaRoles = List.from(roles);
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: ColorApp.colorSegundario,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Row(
                children: [
                  const Expanded(
                    child: Text('Roles', style: TextStyle(color: ColorApp.colorTitulo)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: ColorApp.colorAcento),
                    tooltip: 'Crear rol',
                    onPressed: () => _mostrarCrearRol(context).then((_) {
                      service.roles().then((updated) {
                        if (context.mounted) setState(() => listaRoles = List.from(updated));
                      });
                    }),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: ColorApp.colorAcento),
                    tooltip: 'Actualizar rol',
                    onPressed: () => _mostrarActualizarRol(context).then((_) {
                      service.roles().then((updated) {
                        if (context.mounted) setState(() => listaRoles = List.from(updated));
                      });
                    }),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: listaRoles.map((r) {
                    final nombre = r['nombre'] as String? ?? r['name'] as String? ?? 'Rol #${r['id']}';
                    return ListTile(
                      title: Text(nombre, style: const TextStyle(color: ColorApp.colorTexto)),
                      contentPadding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cerrar', style: TextStyle(color: ColorApp.colorAcento)),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Future<void> _mostrarCrearRol(BuildContext context) async {
    final nombreCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final service = UsuariosService();
    bool enviando = false;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Crear rol', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: nombreCtrl,
              decoration: _inputDeco('Nombre del rol'),
              style: const TextStyle(color: ColorApp.colorTexto),
              validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
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
                final exito = await service.crearRol({'nombre': nombreCtrl.text});
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                if (exito) {
                  GlobalNotificacion.exito('Rol creado');
                }
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 18),
              label: enviando
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _mostrarActualizarRol(BuildContext context) async {
    final service = UsuariosService();
    final roles = await service.roles();
    if (!context.mounted) return;

    int? rolSeleccionado;
    final nomCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool enviando = false;

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Actualizar rol', style: TextStyle(color: ColorApp.colorTitulo)),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<int>(
                  initialValue: rolSeleccionado,
                  items: roles.map((r) {
                    final nombre = r['nombre'] as String? ?? r['name'] as String? ?? 'Rol #${r['id']}';
                    final id = r['id'] as int? ?? 0;
                    return DropdownMenuItem(value: id, child: Text(nombre, style: const TextStyle(color: ColorApp.colorTexto)));
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      rolSeleccionado = v;
                      final encontrado = roles.where((r) => r['id'] == v).firstOrNull;
                      nomCtrl.text = encontrado?['nombre'] as String? ?? encontrado?['name'] as String? ?? '';
                    });
                  },
                  decoration: _inputDeco('Seleccionar rol'),
                  dropdownColor: ColorApp.colorElevado,
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nomCtrl,
                  decoration: _inputDeco('Nombre'),
                  style: const TextStyle(color: ColorApp.colorTexto),
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
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
              onPressed: rolSeleccionado == null || enviando ? null : () async {
                if (!formKey.currentState!.validate()) return;
                setState(() => enviando = true);
                final exito = await service.actualizarRol(rolSeleccionado!, {'nombre': nomCtrl.text});
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                GlobalNotificacion.mostrar(
                  mensaje: exito ? 'Rol actualizado' : 'Error al actualizar',
                  color: exito ? ColorApp.colorExito : ColorApp.colorError,
                );
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 18),
              label: enviando
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.colorAcento, foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), elevation: 0,
              ),
            ),
          ],
        ),
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
