import 'package:flutter/material.dart';

import '../models/currency.dart';

class AppConstants {
  static const supportedLocales = [
    Locale('en'),
    Locale('ur'),
    Locale('ar'),
    Locale('es'),
    Locale('fr'),
    Locale('de'),
    Locale('zh'),
    Locale('tr'),
  ];

  /// Native language names for display.
  static const Map<String, String> languageNames = {
    'en': 'English',
    'ur': 'اردو',
    'ar': 'العربية',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
    'zh': '中文',
    'tr': 'Türkçe',
  };

  /// English names for language picker subtitles.
  static const Map<String, String> languageEnglishNames = {
    'en': 'English',
    'ur': 'Urdu',
    'ar': 'Arabic',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'zh': 'Chinese',
    'tr': 'Turkish',
  };

  static const Map<String, String> languageFlagEmojis = {
    'en': '🌐',
    'ur': '🇵🇰',
    'ar': '🇸🇦',
    'es': '🇪🇸',
    'fr': '🇫🇷',
    'de': '🇩🇪',
    'zh': '🇨🇳',
    'tr': '🇹🇷',
  };

  static const List<Currency> supportedCurrencies = [
    Currency(code: 'USD', name: 'US Dollar', symbol: '\$', locale: 'en_US'),
    Currency(code: 'EUR', name: 'Euro', symbol: '€', locale: 'de_DE'),
    Currency(code: 'GBP', name: 'British Pound', symbol: '£', locale: 'en_GB'),
    Currency(code: 'PKR', name: 'Pakistani Rupee', symbol: '₨', locale: 'en_PK'),
    Currency(code: 'AED', name: 'UAE Dirham', symbol: 'د.إ', locale: 'ar_AE'),
    Currency(code: 'SAR', name: 'Saudi Riyal', symbol: '﷼', locale: 'ar_SA'),
    Currency(code: 'CAD', name: 'Canadian Dollar', symbol: '\$', locale: 'en_CA'),
    Currency(code: 'AUD', name: 'Australian Dollar', symbol: '\$', locale: 'en_AU'),
    Currency(code: 'CNY', name: 'Chinese Yuan', symbol: '¥', locale: 'zh_CN'),
    Currency(code: 'TRY', name: 'Turkish Lira', symbol: '₺', locale: 'tr_TR'),
    Currency(code: 'INR', name: 'Indian Rupee', symbol: '₹', locale: 'en_IN'),
    Currency(code: 'JPY', name: 'Japanese Yen', symbol: '¥', locale: 'ja_JP'),
  ];

  static const String defaultLanguageCode = 'en';
  static const String defaultCurrencyCode = 'USD';

  static Currency get defaultCurrency => findCurrencyByCode(defaultCurrencyCode)!;

  static Currency? findCurrencyByCode(String code) {
    for (final currency in supportedCurrencies) {
      if (currency.code == code) return currency;
    }
    return null;
  }

  static bool isRtlLanguage(String languageCode) =>
      languageCode == 'ur' || languageCode == 'ar';
}
