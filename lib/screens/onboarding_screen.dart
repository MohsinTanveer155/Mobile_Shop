import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_constants.dart';
import '../config/colors.dart';
import '../providers/settings_provider.dart';
import '../utils/l10n_extension.dart';
import 'login_screen.dart';

/// First-run screen for language and currency selection.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentLocale = ref.watch(localeProvider);
    final currentCurrency = ref.watch(currencyProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Icon(Icons.storefront, size: 64, color: AppColors.primary),
              const SizedBox(height: 16),
              Text(
                l10n.onboardingTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboardingSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 32),
              Text(
                l10n.chooseLanguage,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 3,
                child: Card(
                  child: ListView(
                    children: AppConstants.supportedLocales.map((locale) {
                      final code = locale.languageCode;
                      final native = AppConstants.languageNames[code] ?? code;
                      final english = AppConstants.languageEnglishNames[code] ?? native;
                      final emoji = AppConstants.languageFlagEmojis[code] ?? '🌐';
                      final selected = currentLocale.languageCode == code;

                      return RadioListTile<String>(
                        value: code,
                        groupValue: currentLocale.languageCode,
                        onChanged: (_) {
                          ref.read(localeProvider.notifier).setLocale(locale);
                        },
                        title: Text('$emoji $english'),
                        subtitle: Text(native),
                        selected: selected,
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.chooseCurrency,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              Expanded(
                flex: 2,
                child: Card(
                  child: ListView(
                    children: AppConstants.supportedCurrencies.map((currency) {
                      final selected = currentCurrency.code == currency.code;
                      return RadioListTile<String>(
                        value: currency.code,
                        groupValue: currentCurrency.code,
                        onChanged: (_) {
                          ref.read(currencyProvider.notifier).setCurrency(currency);
                        },
                        title: Text(currency.code),
                        subtitle: Text(currency.name),
                        secondary: Text(
                          currency.symbol,
                          style: const TextStyle(fontSize: 18),
                        ),
                        selected: selected,
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  await ref.read(preferencesServiceProvider).setOnboardingComplete();
                  if (!context.mounted) return;
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(l10n.getStarted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
