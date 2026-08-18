import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/warranty_record.dart';
import '../providers/app_providers.dart';

class WarrantyDetailScreen extends ConsumerStatefulWidget {
  final String warrantyId;

  const WarrantyDetailScreen({super.key, required this.warrantyId});

  @override
  ConsumerState<WarrantyDetailScreen> createState() => _WarrantyDetailScreenState();
}

class _WarrantyDetailScreenState extends ConsumerState<WarrantyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final warrantyAsync = ref.watch(warrantyServiceProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warranty Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Warranty'),
                  content: const Text('Are you sure you want to delete this warranty record?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(warrantyServiceProvider).whenData((service) {
                          service.deleteWarranty(widget.warrantyId);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Warranty deleted.')),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: warrantyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (service) {
          final record = service.findById(widget.warrantyId);
          if (record == null) {
            return const Center(child: Text('Warranty record not found.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusCard(record, colorScheme),
                const SizedBox(height: 16),
                _buildInfoCard(record, colorScheme),
                const SizedBox(height: 16),
                _buildActionsCard(record, colorScheme),
                const SizedBox(height: 16),
                _buildClaimsSection(record, colorScheme),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusCard(WarrantyRecord record, ColorScheme colorScheme) {
    final statusColor = record.status == WarrantyStatus.claimed
        ? Colors.orange
        : record.status == WarrantyStatus.void_
            ? Colors.red
            : record.isExpired
                ? Colors.grey
                : Colors.green;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.verified, color: statusColor, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.statusDisplay,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        record.isExpired
                            ? 'Expired on ${_formatDate(record.expiryDate)}'
                            : '${record.daysRemaining} days remaining',
                        style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: record.isExpired
                  ? 1.0
                  : (record.warrantyMonths * 30 - record.daysRemaining) / (record.warrantyMonths * 30),
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(WarrantyRecord record, ColorScheme colorScheme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product Information', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            _infoRow('Product', record.productName),
            _infoRow('Purchase Date', _formatDate(record.purchaseDate)),
            _infoRow('Expiry Date', _formatDate(record.expiryDate)),
            _infoRow('Warranty Period', '${record.warrantyMonths} months'),
            const Divider(height: 24),
            Text('Customer Information', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (record.customerName != null)
              _infoRow('Name', record.customerName!)
            else
              _infoRow('Name', 'Not specified'),
            if (record.customerPhone != null) _infoRow('Phone', record.customerPhone!),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsCard(WarrantyRecord record, ColorScheme colorScheme) {
    if (record.status != WarrantyStatus.active) return const SizedBox.shrink();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Actions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showFileClaimDialog(record),
                    icon: const Icon(Icons.report_problem),
                    label: const Text('File Claim'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Void Warranty'),
                          content: const Text('Are you sure you want to void this warranty? This action cannot be undone.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(warrantyServiceProvider).whenData((service) {
                                  service.voidWarranty(record.id);
                                  Navigator.pop(context);
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Warranty voided.')),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: const Text('Void'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.block),
                    label: const Text('Void'),
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimsSection(WarrantyRecord record, ColorScheme colorScheme) {
    if (record.claimHistory.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.history, size: 48, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                const SizedBox(height: 12),
                Text(
                  'No claims filed yet',
                  style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Claim History', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            ...record.claimHistory.map((claim) => _buildClaimItem(claim, colorScheme)),
          ],
        ),
      ),
    );
  }

  Widget _buildClaimItem(WarrantyClaim claim, ColorScheme colorScheme) {
    final statusColor = claim.claimStatus == ClaimStatus.resolved
        ? Colors.green
        : claim.claimStatus == ClaimStatus.approved
            ? Colors.blue
            : claim.claimStatus == ClaimStatus.rejected
                ? Colors.red
                : Colors.orange;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  claim.claimStatus.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                _formatDate(claim.date),
                style: TextStyle(fontSize: 12, color: colorScheme.onSurface.withValues(alpha: 0.5)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Issue: ${claim.issue}', style: const TextStyle(fontWeight: FontWeight.w600)),
          if (claim.resolution != null) ...[
            const SizedBox(height: 4),
            Text('Resolution: ${claim.resolution}'),
          ],
          if (claim.cost != null) ...[
            const SizedBox(height: 4),
            Text('Cost: Rs ${claim.cost!.toStringAsFixed(2)}', style: TextStyle(color: colorScheme.primary)),
          ],
        ],
      ),
    );
  }

  void _showFileClaimDialog(WarrantyRecord record) {
    final issueController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('File Warranty Claim'),
          content: TextField(
            controller: issueController,
            decoration: const InputDecoration(
              labelText: 'Describe the issue',
              border: OutlineInputBorder(),
              hintText: 'e.g. Screen not responding, battery issue...',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final issue = issueController.text.trim();
                if (issue.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please describe the issue.')),
                  );
                  return;
                }

                ref.read(warrantyServiceProvider).whenData((service) {
                  service.fileClaim(record.id, issue);
                  Navigator.pop(context);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Claim filed successfully.')),
                  );
                });
              },
              child: const Text('File Claim'),
            ),
          ],
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

