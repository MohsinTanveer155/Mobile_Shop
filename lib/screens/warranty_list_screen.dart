import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/warranty_record.dart';
import '../providers/app_providers.dart';
import '../widgets/role_guard.dart';
import 'warranty_detail_screen.dart';

class WarrantyListScreen extends ConsumerStatefulWidget {
  const WarrantyListScreen({super.key});

  @override
  ConsumerState<WarrantyListScreen> createState() => _WarrantyListScreenState();
}

class _WarrantyListScreenState extends ConsumerState<WarrantyListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filterStatus = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddWarrantyDialog() {
    final productNameController = TextEditingController();
    final customerNameController = TextEditingController();
    final customerPhoneController = TextEditingController();
    int warrantyMonths = 12;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add Warranty'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: productNameController,
                      decoration: const InputDecoration(
                        labelText: 'Product Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: customerNameController,
                      decoration: const InputDecoration(
                        labelText: 'Customer Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: customerPhoneController,
                      decoration: const InputDecoration(
                        labelText: 'Customer Phone',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Warranty: '),
                        Expanded(
                          child: Slider(
                            value: warrantyMonths.toDouble(),
                            min: 1,
                            max: 36,
                            divisions: 35,
                            label: '$warrantyMonths months',
                            onChanged: (value) {
                              setDialogState(() {
                                warrantyMonths = value.toInt();
                              });
                            },
                          ),
                        ),
                        Text('$warrantyMonths mo'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final productName = productNameController.text.trim();
                    if (productName.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter product name.')),
                      );
                      return;
                    }

                    ref.read(warrantyServiceProvider).whenData((service) {
                      service.createWarranty(
                        productName: productName,
                        customerName: customerNameController.text.trim().isEmpty ? null : customerNameController.text.trim(),
                        customerPhone: customerPhoneController.text.trim().isEmpty ? null : customerPhoneController.text.trim(),
                        purchaseDate: DateTime.now(),
                        warrantyMonths: warrantyMonths,
                      );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Warranty added successfully.')),
                      );
                      setState(() {});
                    });
                  },
                  child: const Text('Add Warranty'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(WarrantyRecord record) {
    if (record.status == WarrantyStatus.claimed) return Colors.orange;
    if (record.status == WarrantyStatus.void_) return Colors.red;
    if (record.isExpired) return Colors.grey;
    if (record.daysRemaining <= 30) return Colors.amber;
    return Colors.green;
  }

  String _getStatusText(WarrantyRecord record) {
    if (record.status == WarrantyStatus.claimed) return 'Claimed';
    if (record.status == WarrantyStatus.void_) return 'Void';
    if (record.isExpired) return 'Expired';
    if (record.daysRemaining <= 30) return 'Expiring Soon';
    return 'Active';
  }

  @override
  Widget build(BuildContext context) {
    final warrantyAsync = ref.watch(warrantyServiceProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Warranty Management'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddWarrantyDialog,
            ),
          ],
        ),
        body: warrantyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) {
            debugPrint('Warranty load error: $err');
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Unable to load this information. Please try again.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          data: (service) {
            var records = service.records;

            final query = _searchController.text.trim();
            if (query.isNotEmpty) {
              records = service.search(query);
            }

            if (_filterStatus == 'active') {
              records = records.where((r) => r.status == WarrantyStatus.active && !r.isExpired).toList();
            } else if (_filterStatus == 'expired') {
              records = records.where((r) => r.isExpired && r.status == WarrantyStatus.active).toList();
            } else if (_filterStatus == 'claimed') {
              records = records.where((r) => r.status == WarrantyStatus.claimed).toList();
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Search product or customer',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: query.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {});
                                  },
                                )
                              : null,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _filterChip('All', 'all', colorScheme),
                            _filterChip('Active', 'active', colorScheme),
                            _filterChip('Expired', 'expired', colorScheme),
                            _filterChip('Claimed', 'claimed', colorScheme),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: records.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.verified, size: 64, color: colorScheme.onSurface.withValues(alpha: 0.3)),
                              const SizedBox(height: 16),
                              Text(
                                'No warranty records found',
                                style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.5)),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            final record = records[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: _getStatusColor(record).withValues(alpha: 0.1),
                                  child: Icon(
                                    Icons.verified,
                                    color: _getStatusColor(record),
                                  ),
                                ),
                                title: Text(record.productName, overflow: TextOverflow.ellipsis),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (record.customerName != null)
                                      Text('Customer: ${record.customerName}'),
                                  ],
                                ),
                                trailing: Chip(
                                  label: Text(
                                    _getStatusText(record),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: _getStatusColor(record),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: _getStatusColor(record).withValues(alpha: 0.1),
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => WarrantyDetailScreen(warrantyId: record.id),
                                    ),
                                  ).then((_) => setState(() {}));
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddWarrantyDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _filterChip(String label, String value, ColorScheme colorScheme) {
    final isSelected = _filterStatus == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _filterStatus = value),
        selectedColor: colorScheme.primary.withValues(alpha: 0.2),
        checkmarkColor: colorScheme.primary,
      ),
    );
  }
}

