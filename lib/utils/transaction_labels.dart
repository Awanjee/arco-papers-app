import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

String docTypeLabel(String? dt) => docTypeLabels[dt] ?? dt ?? 'Unknown';

Color docTypeColor(BuildContext context, String? dt) {
  final key = dt ?? 'unknown';
  if (key == 'account_ledger') return AppColorsResolver.warning(context);
  if (key == 'calculation_note') return AppColorsResolver.success(context);
  if (key == 'unknown') return AppColorsResolver.text3(context);
  return AppColorsResolver.link(context);
}

String txTypeLabel(String? txType) =>
    txTypeLabels[txType ?? 'sale'] ?? txType ?? 'Sale';

Color txTypeColor(
  BuildContext context,
  String? txType, {
  bool detailScreen = false,
}) {
  final t = txType ?? 'sale';
  if (detailScreen) {
    if (t == 'expense') return AppColorsResolver.warning(context);
    return AppColorsResolver.link(context);
  }
  return switch (t) {
    'sale' => AppColorsResolver.link(context),
    'payment_received' => AppColorsResolver.success(context),
    'purchase' => AppColorsResolver.warning(context),
    'expense' => AppColorsResolver.warning(context),
    _ => AppColorsResolver.text3(context),
  };
}

const docTypeLabels = {
  'sales_slip': 'Sales Slip',
  'price_list': 'Price List',
  'distribution_record': 'Distribution',
  'account_ledger': 'Ledger',
  'calculation_note': 'Calculation',
  'unknown': 'Unknown',
};

const txTypeLabels = {
  'sale': 'Sale',
  'payment_received': 'Payment',
  'purchase': 'Purchase',
  'expense': 'Expense',
};

const txTypeLabelsLong = {
  'sale': 'Sale',
  'payment_received': 'Payment received',
  'purchase': 'Purchase',
  'expense': 'Expense',
};

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
