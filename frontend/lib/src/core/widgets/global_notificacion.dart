import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';

class GlobalNotificacion extends StatefulWidget {
  final Widget child;

  const GlobalNotificacion({super.key, required this.child});

  static final GlobalKey<GlobalNotificacionState> _key =
      GlobalKey<GlobalNotificacionState>();

  static Widget build({required Widget child}) {
    return GlobalNotificacion(key: _key, child: child);
  }

  static void mostrar({
    required String mensaje,
    required Color color,
    Duration duracion = const Duration(seconds: 4),
  }) {
    _key.currentState?.mostrar(mensaje: mensaje, color: color, duracion: duracion);
  }

  static void exito(String mensaje) => mostrar(mensaje: mensaje, color: ColorApp.colorExito);
  static void advertencia(String mensaje) => mostrar(mensaje: mensaje, color: ColorApp.colorAdvertencia);
  static void error(String mensaje) => mostrar(mensaje: mensaje, color: ColorApp.colorError);

  @override
  State<GlobalNotificacion> createState() => GlobalNotificacionState();
}

class GlobalNotificacionState extends State<GlobalNotificacion> {
  final List<_ToastData> _toasts = [];
  int _nextId = 0;

  void mostrar({
    required String mensaje,
    required Color color,
    Duration duracion = const Duration(seconds: 4),
  }) {
    final id = _nextId++;
    setState(() {
      _toasts.add(_ToastData(id, mensaje, color));
    });
    Future.delayed(duracion, () {
      if (mounted) {
        setState(() {
          _toasts.removeWhere((t) => t.id == id);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ..._toasts.map(
          (t) => Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            left: 16,
            right: 16,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Material(
                  color: Colors.transparent,
                  child: AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: t.color.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              t.mensaje,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToastData {
  final int id;
  final String mensaje;
  final Color color;
  _ToastData(this.id, this.mensaje, this.color);
}
