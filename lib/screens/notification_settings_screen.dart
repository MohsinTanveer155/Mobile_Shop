import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/app_providers.dart';
import 'backup_history_screen.dart';
import '../widgets/role_guard.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(title: const Text('Notification Settings')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Alerts & Reminders',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Configure how you want to be notified about your store activity.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      notificationState.notificationsEnabled
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      color: notificationState.notificationsEnabled ? Colors.indigo : Colors.grey,
                    ),
                    title: const Text('Enable Notifications'),
                    subtitle: Text(
                      notificationState.notificationsEnabled
                          ? 'Notifications are active'
                          : 'Tap to enable notifications',
                    ),
                    trailing: Switch(
                      value: notificationState.notificationsEnabled,
                      onChanged: (value) async {
                        if (value) {
                          final granted = await notifier.requestPermissions();
                          if (!granted && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Notification permissions denied. Please enable in settings.'),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.warning_amber, color: Colors.orange),
                    title: const Text('Low Stock Warnings'),
                    subtitle: const Text('Get alerted when products are running low'),
                    trailing: Switch(
                      value: notificationState.lowStockEnabled,
                      onChanged: notificationState.notificationsEnabled
                          ? (value) => notifier.toggleLowStock(value)
                          : null,
                    ),
                    enabled: notificationState.notificationsEnabled,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.today, color: Colors.teal),
                    title: const Text('Daily Sales Reminder'),
                    subtitle: const Text('Receive a summary of daily sales'),
                    trailing: Switch(
                      value: notificationState.dailyReminderEnabled,
                      onChanged: notificationState.notificationsEnabled
                          ? (value) => notifier.toggleDailyReminder(value)
                          : null,
                    ),
                    enabled: notificationState.notificationsEnabled,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Low Stock Threshold',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You will be notified when any product drops to ${notificationState.lowStockThreshold} or fewer items.',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: notificationState.lowStockThreshold.toDouble(),
                      min: 1,
                      max: 20,
                      divisions: 19,
                      label: '${notificationState.lowStockThreshold}',
                      onChanged: notificationState.notificationsEnabled && notificationState.lowStockEnabled
                          ? (value) => notifier.setLowStockThreshold(value.toInt())
                          : null,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1', style: TextStyle(color: Colors.grey.shade500)),
                        Text('20', style: TextStyle(color: Colors.grey.shade500)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (notificationState.notificationsEnabled)
              ElevatedButton.icon(
                onPressed: () async {
                  final service = await ref.read(posServiceProvider.future);
                  await ref.read(notificationServiceProvider).showDailySalesReminder(service);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Test daily reminder sent.')),
                    );
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Send Test Daily Reminder'),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final service = await ref.read(posServiceProvider.future);
                final backupJson = await service.exportBackupJson();
                await Share.share(backupJson, subject: 'Mobile Shop POS Backup');
              },
              icon: const Icon(Icons.backup),
              label: const Text('Export Local Backup'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                final service = await ref.read(posServiceProvider.future);
                final firebase = ref.read(firebaseServiceProvider);
                try {
                  await firebase.backupData(service.generateBackupPayload());
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Firebase backup completed successfully.')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Firebase backup failed: $e')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text('Backup to Firebase'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                final documentIdController = TextEditingController();
                final documentId = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Restore From Firebase'),
                    content: TextField(
                      controller: documentIdController,
                      decoration: const InputDecoration(
                        labelText: 'Backup document ID',
                        hintText: 'Enter Firebase backup ID',
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, documentIdController.text.trim()),
                        child: const Text('Restore'),
                      ),
                    ],
                  ),
                );
                if (documentId == null || documentId.isEmpty) return;
                final service = await ref.read(posServiceProvider.future);
                final firebase = ref.read(firebaseServiceProvider);
                try {
                  final payload = await firebase.restoreBackup(documentId);
                  if (payload == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Backup not found.')),
                      );
                    }
                    return;
                  }
                  await service.restoreFromBackupPayload(payload, merge: false);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Restored backup from Firebase.')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Restore failed: $e')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.cloud_download),
              label: const Text('Restore From Firebase'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                if (!context.mounted) return;
                await Navigator.push(context, MaterialPageRoute(builder: (_) => const BackupHistoryScreen()));
              },
              icon: const Icon(Icons.history),
              label: const Text('Browse Firebase Backups'),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                final dataController = TextEditingController();
                final jsonString = await showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Import Backup JSON'),
                    content: TextField(
                      controller: dataController,
                      decoration: const InputDecoration(
                        labelText: 'Backup JSON',
                        hintText: 'Paste JSON backup data here',
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 6,
                      maxLines: 12,
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, dataController.text.trim()),
                        child: const Text('Import'),
                      ),
                    ],
                  ),
                );
                if (jsonString == null || jsonString.isEmpty) return;
                final service = await ref.read(posServiceProvider.future);
                try {
                  await service.importBackupJson(jsonString, merge: false);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Backup imported successfully.')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Import failed: $e')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.file_upload),
              label: const Text('Import Backup JSON'),
            ),
          ],
        ),
      ),
    );
  }
}
