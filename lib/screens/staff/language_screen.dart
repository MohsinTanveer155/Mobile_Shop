import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_shop/config/app_constants.dart';
import 'package:mobile_shop/config/colors.dart';
import 'package:mobile_shop/gen/l10n/app_localizations.dart';
import 'package:mobile_shop/providers/settings_provider.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectLanguage),
      ),
      body: ListView.separated(
        itemCount: AppConstants.supportedLocales.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final locale = AppConstants.supportedLocales[index];
          final languageCode = locale.languageCode;
          final languageName = AppConstants.languageNames[languageCode] ?? languageCode;

          // For displaying the English name of the language
          final englishLanguageName = AppConstants.languageNames[languageCode] ?? languageName;

          final isSelected = currentLocale.languageCode == languageCode;

          return ListTile(
            onTap: () {
              ref.read(localeProvider.notifier).setLocale(locale);
              Navigator.of(context).pop();
            },
            title: Text(englishLanguageName),
            subtitle: Text(languageName),
            trailing: isSelected
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                  )
                : const Icon(
                    Icons.radio_button_unchecked,
                    color: AppColors.border,
                  ),
            selected: isSelected,
            selectedTileColor: AppColors.primary.withValues(alpha: 0.05),
          );
        },
      ),
    );
  }
}