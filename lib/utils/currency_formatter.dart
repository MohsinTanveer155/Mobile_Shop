import 'package:intl/intl.dart';

import '../models/currency.dart';

class CurrencyFormatter {
  /// Formats [value] using the selected currency's locale and symbol.
  static String format(double value, Currency currency) {
    final hasFraction = value != value.truncateToDouble();
    final decimalDigits = currency.usesWholeUnits && !hasFraction ? 0 : 2;

    final formatter = NumberFormat.currency(
      locale: currency.locale,
      symbol: currency.symbol,
      decimalDigits: decimalDigits,
    );

    return formatter.format(value);
  }
}
