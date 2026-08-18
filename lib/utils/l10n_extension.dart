import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../gen/l10n/app_localizations.dart';
import '../models/currency.dart';
import '../providers/settings_provider.dart';
import 'currency_formatter.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension MoneyFormatRef on WidgetRef {
  Currency get selectedCurrency => watch(currencyProvider);

  String formatMoney(double amount) {
    return CurrencyFormatter.format(amount, selectedCurrency);
  }
}
