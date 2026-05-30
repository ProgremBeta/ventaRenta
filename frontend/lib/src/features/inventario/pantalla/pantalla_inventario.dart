import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/widgets/global_notificacion.dart';
import 'package:frontend/src/features/productos/service/productos_service.dart';

class PantallaInventario extends StatefulWidget {
  const PantallaInventario({super.key});

  @override
  State<PantallaInventario> createState() => _PantallaInventarioState();
}

class _PantallaInventarioState extends State<PantallaInventario> {
  final _service = ProductosService();
  List<Map<String, dynamic>> _productos = [];
  List<Map<String, dynamic>> _inventario = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    setState(() => _cargando = true);
    final prods = await _service.productos();
    final inv = await _service.obtenerInventarioProductos();
    if (!mounted) return;
    setState(() {
      _productos = prods;
      _inventario = inv ?? [];
      _cargando = false;
    });
  }

  Map<String, dynamic>? _inventarioPorProducto(int productoId) {
    try {
      return _inventario.firstWhere((i) => i['producto_id'] == productoId);
    } catch (_) {
      return null;
    }
  }

  void _mostrarAjusteStock(Map<String, dynamic> producto, bool esAumento) {
    final inv = _inventarioPorProducto(producto['id']);
    if (inv == null) {
      GlobalNotificacion.error('Sin registro de inventario');
      return;
    }

    final cantidadCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool enviando = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: ColorApp.colorSegundario,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            '${esAumento ? "Aumentar" : "Disminuir"} stock',
            style: const TextStyle(color: ColorApp.colorTitulo),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Producto: ${producto['nombre']}',
                  style: const TextStyle(color: ColorApp.colorSubTitulo, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Stock actual: ${inv['stock']}',
                  style: const TextStyle(color: ColorApp.colorTexto),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: cantidadCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cantidad a ${esAumento ? "agregar" : "quitar"}',
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
                    final n = int.tryParse(v);
                    if (n == null || n <= 0) return 'Ingrese un número válido';
                    if (!esAumento && n > (inv['stock'] as int? ?? 0)) return 'Stock insuficiente';
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
                final cantidad = int.parse(cantidadCtrl.text);
                final stockActual = inv['stock'] as int? ?? 0;
                final nuevoStock = esAumento ? stockActual + cantidad : stockActual - cantidad;
                final data = {
                  'producto_id': producto['id'],
                  'stock': nuevoStock,
                  'stock_minimo': inv['stock_minimo'] ?? 0,
                  'activo': true,
                };
                final exito = await _service.actualizarInventario(inv['id'] as int, data);
                if (!ctx.mounted) return;
                Navigator.pop(ctx);
                if (exito) {
                  GlobalNotificacion.exito('Stock actualizado');
                  _cargarDatos();
                } else {
                  GlobalNotificacion.error('Error al actualizar stock');
                }
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 18),
              label: Text(enviando ? '' : 'Confirmar'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorPrincipal,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorApp.colorTexto),
          onPressed: () => context.go('/inicio'),
        ),
        title: const Text('Inventario'),
        backgroundColor: ColorApp.colorNavBar,
        titleTextStyle: const TextStyle(color: ColorApp.colorTitulo, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0,
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator(color: ColorApp.colorAcento))
          : _buildLista(),
    );
  }

  Widget _buildLista() {
    return RefreshIndicator(
      color: ColorApp.colorAcento,
      onRefresh: _cargarDatos,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        itemCount: _productos.length,
        itemBuilder: (context, index) {
          final prod = _productos[index];
          final inv = _inventarioPorProducto(prod['id']);
          final stock = inv?['stock'] as int? ?? 0;
          final stockMinimo = inv?['stock_minimo'] as int? ?? 0;
          final tieneInventario = inv != null;
          final sinStock = tieneInventario && stock == 0;
          final bajoStock = tieneInventario && stock > 0 && stock < stockMinimo;
          final stockMedio = tieneInventario && stock >= stockMinimo && stock <= stockMinimo + 8;
          final stockSaludable = tieneInventario && stock > stockMinimo + 8;

          Color? bgColor;
          Color? bordeColor;
          if (sinStock) {
            bgColor = ColorApp.colorError.withValues(alpha: 0.08);
            bordeColor = ColorApp.colorError;
          } else if (bajoStock) {
            bgColor = ColorApp.colorAdvertencia.withValues(alpha: 0.08);
            bordeColor = ColorApp.colorAdvertencia;
          } else if (stockMedio) {
            bgColor = ColorApp.colorAcento.withValues(alpha: 0.08);
            bordeColor = ColorApp.colorAcento;
          } else if (stockSaludable) {
            bgColor = ColorApp.colorExito.withValues(alpha: 0.08);
            bordeColor = ColorApp.colorExito;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
                border: bordeColor != null ? Border.all(color: bordeColor, width: 1.5) : null,
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                title: Text(
                  prod['nombre'] as String? ?? '',
                  style: const TextStyle(color: ColorApp.colorTitulo, fontWeight: FontWeight.w600),
                ),
                subtitle: tieneInventario
                    ? Text(
                        'Stock: $stock  |  Mínimo: $stockMinimo',
                        style: TextStyle(
                          color: sinStock
                              ? ColorApp.colorError
                              : (bajoStock
                                  ? ColorApp.colorAdvertencia
                                  : (stockMedio
                                      ? ColorApp.colorAcento
                                      : (stockSaludable ? ColorApp.colorExito : ColorApp.colorSubTitulo))),
                          fontSize: 13,
                        ),
                      )
                    : const Text('Sin registro de inventario', style: TextStyle(color: ColorApp.colorTextoMuted, fontSize: 13)),
                trailing: tieneInventario
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: ColorApp.colorError),
                            tooltip: 'Disminuir stock',
                            onPressed: () => _mostrarAjusteStock(prod, false),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: ColorApp.colorExito),
                            tooltip: 'Aumentar stock',
                            onPressed: () => _mostrarAjusteStock(prod, true),
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
