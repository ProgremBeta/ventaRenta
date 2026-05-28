import 'package:flutter/material.dart';
import 'package:frontend/src/core/themes/color_app.dart';
import 'package:frontend/src/core/themes/estilos_app.dart';

class ItemLista extends StatelessWidget {
  final String titulo;
  final String? subtitulo;
  final String? detalle;
  final VoidCallback? onTap;

  const ItemLista({
    super.key,
    required this.titulo,
    this.subtitulo,
    this.detalle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: EstilosApp.paddingGeneral,
        vertical: EstilosApp.paddingPequeno / 2,
      ),
      child: Material(
        color: ColorApp.colorElevado,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(EstilosApp.paddingMedio),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorApp.colorBordeInput.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          color: ColorApp.colorTitulo,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitulo != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            subtitulo!,
                            style: const TextStyle(
                              color: ColorApp.colorSubTitulo,
                              fontSize: 13,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (detalle != null)
                  Text(
                    detalle!,
                    style: const TextStyle(
                      color: ColorApp.colorTextoMuted,
                      fontSize: 13,
                    ),
                  ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
