import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_constants.dart';
import '../config/colors.dart';
import '../providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/l10n_extension.dart';
import 'backup_history_screen.dart';
import 'login_screen.dart';
import 'notification_settings_screen.dart';
import 'settings/currency_screen.dart';
import 'settings/language_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(WidgetRef ref, BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(authServiceProvider).signOut();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final user = ref.watch(authProvider);
    final themeMode = ref.watch(themeProvider);
    final currentLocale = ref.watch(localeProvider);
    final currentCurrency = ref.watch(currencyProvider);
    final currentLanguageName =
        AppConstants.languageNames[currentLocale.languageCode] ??
            currentLocale.languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.deepIndigo.withValues(alpha: 0.12),
                child: user != null
                    ? Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                        style: const TextStyle(color: AppColors.deepIndigo, fontWeight: FontWeight.w700),
                      )
                    : const Icon(Icons.person_outline, color: AppColors.deepIndigo),
                ),
                title: Text(
                  user?.name ?? l10n.user,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  user?.email ??
                      (user?.isAdmin == true ? l10n.administrator : l10n.employee),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _SettingsSectionHeader(title: l10n.appearance),
          _SettingsTile(
            icon: Icons.language_outlined,
            title: l10n.language,
            subtitle: currentLanguageName,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const LanguageScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.monetization_on_outlined,
            title: l10n.currency,
            subtitle: currentCurrency.displayName,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CurrencyScreen()),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              children: [
                _ThemeOptionTile(
                  title: l10n.light,
                  selected: themeMode == ThemeMode.light,
                  onTap: () => ref.read(themeProvider.notifier).setTheme(ThemeMode.light),
                ),
                _ThemeOptionTile(
                  title: l10n.dark,
                  selected: themeMode == ThemeMode.dark,
                  onTap: () => ref.read(themeProvider.notifier).setTheme(ThemeMode.dark),
                ),
                _ThemeOptionTile(
                  title: l10n.systemDefault,
                  selected: themeMode == ThemeMode.system,
                  onTap: () => ref.read(themeProvider.notifier).setTheme(ThemeMode.system),
                ),
              ],
            ),
          ),
          const Divider(height: 24, indent: 16, endIndent: 16),
          _SettingsSectionHeader(title: l10n.general),
          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: l10n.notifications,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
            ),
          ),
          _SettingsTile(
            icon: Icons.backup_outlined,
            title: l10n.backupHistory,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const BackupHistoryScreen()),
            ),
          ),
          const Divider(height: 24, indent: 16, endIndent: 16),
          _SettingsSectionHeader(title: l10n.about),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(l10n.appFullTitle),
              subtitle: Text(l10n.versionLabel),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.logout),
              label: Text(l10n.logout),
              onPressed: () => _logout(ref, context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSectionHeader extends StatelessWidget {
  final String title;
  const _SettingsSectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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

class _ThemeOptionTile extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOptionTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      selected: selected,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: selected ? AppColors.deepIndigo : AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}

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
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
