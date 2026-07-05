final _thousandsSeparator = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

/// Formats a number with thousands separators (no decimals).
String formatPkr(double amount, {bool absolute = false}) {
  final v = absolute ? amount.abs() : amount;
  return v
      .toStringAsFixed(0)
      .replaceAllMapped(_thousandsSeparator, (m) => '${m[1]},');
}

/// Formats amount for line items; keeps up to 2 decimals when needed.
String formatAmount(double v) {
  if (v >= 1000) {
    return v
        .toStringAsFixed(0)
        .replaceAllMapped(_thousandsSeparator, (m) => '${m[1]},');
  }
  return v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(2);
}

/// Parses ISO date string to DD/MM/YYYY. Returns fallback when null or invalid.
String formatTxDate(String? iso, {String fallback = 'No date'}) {
  if (iso == null) return fallback;
  try {
    final d = DateTime.parse(iso);
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  } catch (_) {
    return iso;
  }
}

/// Optional date: returns null when input is null.
String? formatTxDateOptional(String? iso) {
  if (iso == null) return null;
  return formatTxDate(iso, fallback: iso);
}
