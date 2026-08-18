import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_constants.dart';

/// Persists language, currency, and first-run preferences locally.
class PreferencesService {
  static const String _languageCodeKey = 'user_language_code';
  static const String _currencyCodeKey = 'user_currency_code';
  static const String _onboardingCompleteKey = 'onboarding_complete';

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String getLanguageCode() {
    return _prefs.getString(_languageCodeKey) ?? AppConstants.defaultLanguageCode;
  }

  Future<void> setLanguageCode(String code) async {
    await _prefs.setString(_languageCodeKey, code);
  }

  String getCurrencyCode() {
    return _prefs.getString(_currencyCodeKey) ?? AppConstants.defaultCurrencyCode;
  }

  Future<void> setCurrencyCode(String code) async {
    await _prefs.setString(_currencyCodeKey, code);
  }

  bool isOnboardingComplete() {
    return _prefs.getBool(_onboardingCompleteKey) ?? false;
  }

  Future<void> setOnboardingComplete() async {
    await _prefs.setBool(_onboardingCompleteKey, true);
  }
}
