import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/app_constants.dart';
import '../../config/colors.dart';
import '../../providers/settings_provider.dart';
import '../../utils/l10n_extension.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentLocale = ref.watch(localeProvider);

    final locales = AppConstants.supportedLocales.where((locale) {
      if (_searchQuery.isEmpty) return true;
      final code = locale.languageCode;
      final query = _searchQuery.toLowerCase();
      final english = AppConstants.languageEnglishNames[code] ?? '';
      final native = AppConstants.languageNames[code] ?? '';
      return english.toLowerCase().contains(query) ||
          native.toLowerCase().contains(query) ||
          code.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectLanguage)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: l10n.searchLanguage,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: locales.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final locale = locales[index];
                final code = locale.languageCode;
                final nativeName = AppConstants.languageNames[code] ?? code;
                final englishName = AppConstants.languageEnglishNames[code] ?? nativeName;
                final emoji = AppConstants.languageFlagEmojis[code] ?? '🌐';
                final isSelected = currentLocale.languageCode == code;

                return ListTile(
                  onTap: () {
                    ref.read(localeProvider.notifier).setLocale(locale);
                    Navigator.of(context).pop();
                  },
                  leading: Text(emoji, style: const TextStyle(fontSize: 24)),
                  title: Text(englishName),
                  subtitle: Text(nativeName),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColors.primary)
                      : const Icon(Icons.radio_button_unchecked, color: AppColors.border),
                  selected: isSelected,
                  selectedTileColor: AppColors.primary.withValues(alpha: 0.05),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
