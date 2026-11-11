import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatMinorUnits(int amountMinorUnits, Locale locale) {
    final isVietnamese = locale.languageCode == 'vi';
    final formatter = NumberFormat.currency(
      locale: isVietnamese ? 'vi_VN' : 'en_US',
      name: isVietnamese ? 'VND' : 'USD',
      symbol: isVietnamese ? '₫' : r'$',
      decimalDigits: isVietnamese ? 0 : 2,
    );
    return formatter.format(amountMinorUnits / 100);
  }
}
