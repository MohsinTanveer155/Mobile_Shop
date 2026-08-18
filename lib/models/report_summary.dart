/// Immutable data class representing a computed report summary.
/// Used by the UI layer to display aggregated metrics.
class ReportSummary {
  final double totalSales;
  final double totalProfit;
  final int transactionCount;
  final int totalQuantity;
  final double averageTransactionValue;
  final String periodLabel;
  final DateTime startDate;
  final DateTime endDate;

  const ReportSummary({
    required this.totalSales,
    required this.totalProfit,
    required this.transactionCount,
    required this.totalQuantity,
    required this.averageTransactionValue,
    required this.periodLabel,
    required this.startDate,
    required this.endDate,
  });

  /// Empty summary for initial state.
  factory ReportSummary.empty() {
    final now = DateTime.now();
    return ReportSummary(
      totalSales: 0.0,
      totalProfit: 0.0,
      transactionCount: 0,
      totalQuantity: 0,
      averageTransactionValue: 0.0,
      periodLabel: 'No Data',
      startDate: now,
      endDate: now,
    );
  }

  /// Profit margin percentage (0.0 to 1.0).
  double get profitMargin => totalSales > 0 ? totalProfit / totalSales : 0.0;
}

