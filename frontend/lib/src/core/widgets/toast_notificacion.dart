import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';

enum TipoToast { exito, error, advertencia }

class ToastNotificacion {
  static void mostrar(
    BuildContext context, {
    required String mensaje,
    TipoToast tipo = TipoToast.exito,
    Duration duracion = const Duration(seconds: 4),
  }) {
    final color = switch (tipo) {
      TipoToast.exito => ColorApp.colorExito,
      TipoToast.error => ColorApp.colorError,
      TipoToast.advertencia => ColorApp.colorAdvertencia,
    };

    final icono = switch (tipo) {
      TipoToast.exito => Icons.check_circle,
      TipoToast.error => Icons.cancel,
      TipoToast.advertencia => Icons.warning_amber_rounded,
    };

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.95),
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
                  Icon(icono, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      mensaje,
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
    );

    overlay.insert(entry);

    Future.delayed(duracion, () {
      entry.remove();
    });
  }
}
