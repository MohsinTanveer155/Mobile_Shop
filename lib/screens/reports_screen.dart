import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/report_summary.dart';
import '../models/sale.dart';
import '../providers/app_providers.dart';
import '../services/report_service.dart';
import '../services/pdf_export_service.dart';
import '../utils/date_utils.dart';
import '../widgets/best_sellers_widget.dart';
import '../widgets/payment_breakdown_widget.dart';
import '../widgets/period_selector.dart';
import '../widgets/report_chart_widget.dart';
import '../widgets/report_detail_list.dart';
import '../widgets/role_guard.dart';
import '../widgets/summary_card.dart';

/// Comprehensive Reports Screen for Mobile Shop POS.
/// Uses Riverpod to fetch [PosService] once, then manages all local UI state via [setState].
class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  // ==================== STATE ====================
  ReportPeriod _selectedPeriod = ReportPeriod.daily;
  bool _isCustomRange = false;
  DateTime? _customStartDate;
  DateTime? _customEndDate;

  ReportSummary _summary = ReportSummary.empty();
  List<Sale> _filteredSales = [];
  List<Map<String, dynamic>> _chartData = [];
  List<Map<String, dynamic>> _bestSellers = [];
  bool _isLoading = false;

  List<Sale> _allSales = [];

  // ==================== LIFECYCLE ====================

  @override
  void initState() {
    super.initState();
    // Defer initial load until first frame so ref is available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  void _initialize() {
    final serviceAsync = ref.read(posServiceProvider);
    serviceAsync.whenData((service) {
      _allSales = service.sales;
      _loadReportData();
    });
  }

  // ==================== DATA LOADING ====================

  /// Core method that filters sales, calculates summary, chart data, and best sellers.
  /// All updates are driven through [setState] as required.
  void _loadReportData() {
    if (!mounted) return;

    setState(() => _isLoading = true);

    // Allow a brief frame for the loading indicator to render.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final now = DateTime.now();
      List<Sale> filtered;
      String periodLabel;
      DateTime startDate;
      DateTime endDate;

      if (_isCustomRange && _customStartDate != null && _customEndDate != null) {
        filtered = ReportService.getCustomRangeSales(
          _allSales,
          _customStartDate!,
          _customEndDate!,
        );
        periodLabel =
            '${DateUtilsHelper.formatReportDate(_customStartDate!)} - ${DateUtilsHelper.formatReportDate(_customEndDate!)}';
        startDate = _customStartDate!;
        endDate = _customEndDate!;
      } else {
        switch (_selectedPeriod) {
          case ReportPeriod.daily:
            filtered = ReportService.getDailySales(_allSales);
            periodLabel = 'Today';
            startDate = DateUtilsHelper.startOfDay(now);
            endDate = DateUtilsHelper.endOfDay(now);
            break;
          case ReportPeriod.weekly:
            filtered = ReportService.getWeeklySales(_allSales);
            periodLabel = 'Last 7 Days';
            startDate = DateUtilsHelper.startOfDay(now.subtract(const Duration(days: 6)));
            endDate = DateUtilsHelper.endOfDay(now);
            break;
          case ReportPeriod.monthly:
            filtered = ReportService.getMonthlySales(_allSales);
            periodLabel = 'This Month';
            startDate = DateUtilsHelper.startOfMonth(now);
            endDate = DateUtilsHelper.endOfMonth(now);
            break;
          case ReportPeriod.yearly:
            filtered = ReportService.getYearlySales(_allSales);
            periodLabel = 'This Year';
            startDate = DateUtilsHelper.startOfYear(now);
            endDate = DateUtilsHelper.endOfYear(now);
            break;
        }
      }

      final summary = ReportService.calculateSummary(
        filtered,
        periodLabel,
        startDate,
        endDate,
      );

      final chartData = ReportService.getChartData(_allSales, _selectedPeriod);
      final bestSellers = ReportService.getBestSellers(filtered, limit: 5);

      if (mounted) {
        setState(() {
          _filteredSales = filtered;
          _summary = summary;
          _chartData = chartData;
          _bestSellers = bestSellers;
          _isLoading = false;
        });
      }
    });
  }

  // ==================== DATE PICKERS ====================

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _customStartDate ?? DateTime.now().subtract(const Duration(days: 7)),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        _customStartDate = picked;
        if (_customEndDate != null && _customEndDate!.isBefore(picked)) {
          _customEndDate = picked;
        }
      });
      _loadReportData();
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _customEndDate ?? DateTime.now(),
      firstDate: _customStartDate ?? DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() => _customEndDate = picked);
      _loadReportData();
    }
  }

  // ==================== EXPORT ====================

  Future<void> _exportPdf() async {
    if (_filteredSales.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data to export.')),
        );
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      await PdfExportService.generateAndShareReport(
        summary: _summary,
        sales: _filteredSales,
        periodTitle: _summary.periodLabel,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ==================== UI BUILDERS ====================

  @override
  Widget build(BuildContext context) {
    final serviceAsync = ref.watch(posServiceProvider);

    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reports'),
          actions: [
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              tooltip: 'Export PDF',
              onPressed: _isLoading ? null : _exportPdf,
            ),
          ],
        ),
        body: serviceAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (service) {
            // Cache all sales locally on first data arrival.
            _allSales = service.sales;
            return _buildBody();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period selector
          PeriodSelector(
            selectedPeriod: _selectedPeriod,
            onPeriodChanged: (period) {
              setState(() {
                _selectedPeriod = period;
                _isCustomRange = false;
              });
              _loadReportData();
            },
          ),
          const SizedBox(height: 12),

          // Custom range toggle & pickers
          _buildCustomRangeSection(),
          const SizedBox(height: 16),

          // Period title
          Text(
            _summary.periodLabel,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${DateUtilsHelper.formatReportDate(_summary.startDate)} - ${DateUtilsHelper.formatReportDate(_summary.endDate)}',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),

          // Loading indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            ),

          // Summary cards grid
          _buildSummaryCards(),
          const SizedBox(height: 16),

          // Chart
          ReportChartWidget(
            data: _chartData,
            title: '${_summary.periodLabel} Trend',
          ),
          const SizedBox(height: 16),

          // Payment breakdown
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PaymentBreakdownWidget(sales: _filteredSales),
            ),
          ),
          const SizedBox(height: 16),

          // Best sellers
          BestSellersWidget(bestSellers: _bestSellers),
          const SizedBox(height: 16),

          // Recent transactions
          ReportDetailList(sales: _filteredSales),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCustomRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isCustomRange = !_isCustomRange;
              if (!_isCustomRange) {
                _customStartDate = null;
                _customEndDate = null;
              } else {
                _customStartDate = DateTime.now().subtract(const Duration(days: 7));
                _customEndDate = DateTime.now();
              }
            });
            _loadReportData();
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  _isCustomRange ? Icons.check_box : Icons.check_box_outline_blank,
                  color: Colors.indigo,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Custom Date Range',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        if (_isCustomRange) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _DatePickerButton(
                  label: 'Start',
                  date: _customStartDate,
                  onTap: _pickStartDate,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward, size: 18, color: Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: _DatePickerButton(
                  label: 'End',
                  date: _customEndDate,
                  onTap: _pickEndDate,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSummaryCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive aspect ratio based on available width.
        // Each card gets ~half width minus spacing.
        final cardWidth = (constraints.maxWidth - 12) / 2;
        // Target height: enough for title + value with padding.
        const targetHeight = 110.0;
        final aspectRatio = cardWidth / targetHeight;

        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: aspectRatio > 0 ? aspectRatio : 1.0,
          ),
          children: [
            SummaryCard(
              title: 'Total Sales',
              value: 'Rs ${_summary.totalSales.toStringAsFixed(2)}',
              color: Colors.green.shade700,
            ),
            SummaryCard(
              title: 'Total Profit',
              value: 'Rs ${_summary.totalProfit.toStringAsFixed(2)}',
              color: Colors.orange.shade700,
            ),
            SummaryCard(
              title: 'Transactions',
              value: '${_summary.transactionCount}',
              color: Colors.teal,
            ),
            SummaryCard(
              title: 'Avg Transaction',
              value: 'Rs ${_summary.averageTransactionValue.toStringAsFixed(2)}',
              color: Colors.blueGrey,
            ),
          ],
        );
      },
    );
  }
}

/// Small reusable date picker button widget.
class _DatePickerButton extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const _DatePickerButton({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 2),
          Text(
            date == null ? 'Select' : DateUtilsHelper.formatReportDate(date!),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

