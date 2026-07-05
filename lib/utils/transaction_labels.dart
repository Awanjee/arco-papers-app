import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

const docTypeLabels = {
  'sales_slip': 'Sales Slip',
  'price_list': 'Price List',
  'distribution_record': 'Distribution',
  'account_ledger': 'Ledger',
  'calculation_note': 'Calculation',
  'unknown': 'Unknown',
};

const docTypeColors = {
  'sales_slip': AppColors.accent,
  'price_list': AppColors.accent,
  'distribution_record': AppColors.accent,
  'account_ledger': AppColors.warning,
  'calculation_note': AppColors.success,
  'unknown': AppColors.text3,
};

const txTypeLabels = {
  'sale': 'Sale',
  'payment_received': 'Payment',
  'purchase': 'Purchase',
  'expense': 'Expense',
};

const txTypeColors = {
  'sale': AppColors.accent,
  'payment_received': AppColors.success,
  'purchase': AppColors.warning,
  'expense': AppColors.warning,
};

const txTypeLabelsLong = {
  'sale': 'Sale',
  'payment_received': 'Payment received',
  'purchase': 'Purchase',
  'expense': 'Expense',
};

String docTypeLabel(String? dt) =>
    docTypeLabels[dt] ?? dt ?? 'Unknown';

Color docTypeColor(String? dt) =>
    docTypeColors[dt] ?? AppColors.text3;

String txTypeLabel(String? txType) =>
    txTypeLabels[txType ?? 'sale'] ?? txType ?? 'Sale';

Color txTypeColor(String? txType, {bool detailScreen = false}) {
  if (detailScreen) {
    const detailColors = {
      'sale': AppColors.accent,
      'payment_received': AppColors.accent,
      'purchase': AppColors.accent,
      'expense': AppColors.warning,
    };
    return detailColors[txType ?? 'sale'] ?? AppColors.text3;
  }
  return txTypeColors[txType ?? 'sale'] ?? AppColors.text3;
}

const _sizeExpansions = {
  'a/4': 'A4',
  'a4': 'A4',
  'f/s': 'Foolscap',
  'f15': 'Foolscap',
  'a/3': 'A3',
  '9x4': '9×4"',
  '11x5': '11×5"',
  '8x10': '8×10"',
  '9x6': '9×6"',
  '7x5': '7×5"',
  '7.5x5': '7.5×5"',
};

const _typeExpansions = {
  'prt': 'Print',
  'print': 'Print',
  'dcp': 'Digital Copy',
  'g-2': 'Grade 2',
  'g2': 'Grade 2',
  'usa': 'USA Import',
  'windo': 'Window',
  'window': 'Window',
  'callon': 'Carbon Copy',
  'callory': 'Carbon Copy',
  'open': 'Offset',
};

String expandProductCode(String? raw) {
  if (raw == null || raw.trim().isEmpty) return 'Unknown';
  final parts = raw.trim().split(RegExp(r'[-/\s]+'));
  final expanded = parts
      .map((p) {
        final lower = p.toLowerCase();
        return _sizeExpansions[lower] ??
            _typeExpansions[lower] ??
            p.toUpperCase();
      })
      .join(' ');
  return expanded;
}
