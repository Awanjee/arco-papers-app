import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ArcoTypeChip extends StatelessWidget {
  const ArcoTypeChip({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s2,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: AppRadius.rPill,
      ),
      child: Text(label, style: AppText.chip.copyWith(color: color)),
    );
  }
}
