import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/app_providers.dart';

class BackupHistoryScreen extends ConsumerWidget {
  const BackupHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebase = ref.read(firebaseServiceProvider);
    final posAsync = ref.watch(posServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Backups')),
      body: FutureBuilder<List<String>>(
        future: firebase.listBackups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load backups: ${snapshot.error}'));
          }
          final backups = snapshot.data ?? [];
          if (backups.isEmpty) {
            return const Center(child: Text('No backups found in Firebase.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: backups.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final id = backups[index];
              final ts = _parseTimestampFromId(id);
              final subtitle = ts != null ? 'Created: ${ts.toLocal()}' : 'ID: $id';
              return ListTile(
                title: Text('Backup $id'),
                subtitle: Text(subtitle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.download),
                      tooltip: 'Restore',
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (c) => AlertDialog(
                            title: const Text('Restore Backup'),
                            content: const Text('This will replace local data. Continue?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                              ElevatedButton(onPressed: () => Navigator.pop(c, true), child: const Text('Restore')),
                            ],
                          ),
                        );
                        if (confirm != true) return;
                        final payload = await firebase.restoreBackup(id);
                        if (payload == null) {
                          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup not found')));
                          return;
                        }
                        final pos = posAsync.whenOrNull(data: (s) => s);
                        if (pos == null) {
                          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('POS service unavailable')));
                          return;
                        }
                        await pos.restoreFromBackupPayload(payload, merge: false);
                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup restored')));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      tooltip: 'Share backup JSON',
                      onPressed: () async {
                        final payload = await firebase.restoreBackup(id);
                        if (payload == null) {
                          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup not found')));
                          return;
                        }
                        final json = payload.toString();
                        await Share.share(json, subject: 'Firebase Backup $id');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.open_in_new),
                      tooltip: 'View',
                      onPressed: () async {
                        final payload = await firebase.restoreBackup(id);
                        if (payload == null) {
                          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup not found')));
                          return;
                        }
                        if (!context.mounted) return;
                        await showDialog<void>(
                          context: context,
                          builder: (c) => AlertDialog(
                            title: Text('Backup $id'),
                            content: SingleChildScrollView(child: Text(payload.toString())),
                            actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Close'))],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                onTap: () async {
                  // same as view
                  final payload = await firebase.restoreBackup(id);
                  if (payload == null) return;
                  if (!context.mounted) return;
                  await showDialog<void>(
                    context: context,
                    builder: (c) => AlertDialog(
                      title: Text('Backup $id'),
                      content: SingleChildScrollView(child: Text(payload.toString())),
                      actions: [TextButton(onPressed: () => Navigator.pop(c), child: const Text('Close'))],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  DateTime? _parseTimestampFromId(String id) {
    try {
      final ms = int.parse(id);
      return DateTime.fromMillisecondsSinceEpoch(ms);
    } catch (_) {
      return null;
    }
  }
}
