import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile_shop/config/app_constants.dart';
import 'package:mobile_shop/config/colors.dart';
import 'package:mobile_shop/gen/l10n/app_localizations.dart';
import 'package:mobile_shop/providers/settings_provider.dart';
import 'package:mobile_shop/screens/settings/currency_screen.dart';
import 'package:mobile_shop/screens/settings/language_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    final currentLocale = ref.watch(localeProvider);
    final currentCurrency = ref.watch(currencyProvider);

    final currentLanguageName =
        AppConstants.languageNames[currentLocale.languageCode] ??
            currentLocale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          _SettingsSectionHeader(
            title: l10n.appearance,
          ),

          // Language
          _SettingsTile(
            icon: Icons.language_outlined,
            title: l10n.language,
            subtitle: currentLanguageName,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LanguageScreen(),
                ),
              );
            },
          ),

          // Currency
          _SettingsTile(
            icon: Icons.monetization_on_outlined,
            title: l10n.currency,
            subtitle: currentCurrency.displayName,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CurrencyScreen(),
                ),
              );
            },
          ),

          const Divider(
            height: 24,
            indent: 16,
            endIndent: 16,
          ),

          _SettingsSectionHeader(
            title: l10n.general,
          ),

          // Notifications
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: l10n.notifications,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Notification settings coming soon!',
                  ),
                ),
              );
            },
          ),

          const Divider(
            height: 24,
            indent: 16,
            endIndent: 16,
          ),

          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(l10n.logout),
              onPressed: () {
                _showLogoutConfirmation(
                  context,
                  l10n.logout,
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(
                  color: AppColors.error,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(
    BuildContext context,
    String logoutText,
  ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                try {
                  await FirebaseAuth.instance.signOut();

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '$logoutText successful',
                      ),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Logout failed: ${e.message ?? 'Unknown error'}',
                      ),
                    ),
                  );
                } catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Logout failed: $e',
                      ),
                    ),
                  );
                }
              },
              child: Text(logoutText),
            ),
          ],
        );
      },
    );
  }
}

// ======================================================
// SETTINGS SECTION HEADER
// ======================================================

class _SettingsSectionHeader extends StatelessWidget {
  final String title;

  const _SettingsSectionHeader({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        8,
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

// ======================================================
// SETTINGS TILE
// ======================================================

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.textSecondary,
      ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}