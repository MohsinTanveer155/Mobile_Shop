import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_constants.dart';
import '../models/currency.dart';
import '../services/preferences_service.dart';

/// Provider for PreferencesService instance
final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  // This is overridden in main.dart after initialization
  throw UnimplementedError();
});


/// === LOCALE (LANGUAGE) PROVIDER ===

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return LocaleNotifier(preferencesService);
});

class LocaleNotifier extends StateNotifier<Locale> {
  final PreferencesService _preferencesService;

  LocaleNotifier(this._preferencesService)
      : super(Locale(_preferencesService.getLanguageCode()));

  Future<void> setLocale(Locale locale) async {
    if (AppConstants.supportedLocales.contains(locale)) {
      state = locale;
      await _preferencesService.setLanguageCode(locale.languageCode);
    }
  }
}


/// === CURRENCY PROVIDER ===

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return CurrencyNotifier(preferencesService);
});

class CurrencyNotifier extends StateNotifier<Currency> {
  final PreferencesService _preferencesService;

  CurrencyNotifier(this._preferencesService)
      : super(
          AppConstants.findCurrencyByCode(
                _preferencesService.getCurrencyCode(),
              ) ??
              AppConstants.defaultCurrency,
        );

  Future<void> setCurrency(Currency currency) async {
    if (AppConstants.supportedCurrencies.any((c) => c.code == currency.code)) {
      state = currency;
      await _preferencesService.setCurrencyCode(currency.code);
    }
  }
}