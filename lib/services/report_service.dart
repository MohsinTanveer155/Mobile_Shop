import '../models/sale.dart';
import '../models/report_summary.dart';
import '../utils/date_utils.dart';

/// Pure business-logic service for generating reports.
/// No Flutter dependencies — can be unit-tested independently.
class ReportService {
  ReportService._();

  // ==================== FILTER FUNCTIONS ====================

  /// Filters sales that occurred today.
  static List<Sale> getDailySales(List<Sale> sales) {
    final now = DateTime.now();
    final start = DateUtilsHelper.startOfDay(now);
    final end = DateUtilsHelper.endOfDay(now);
    return _filterByRange(sales, start, end);
  }

  /// Filters sales from the last 7 days (inclusive).
  static List<Sale> getWeeklySales(List<Sale> sales) {
    final now = DateTime.now();
    final end = DateUtilsHelper.endOfDay(now);
    final start = DateUtilsHelper.startOfDay(now.subtract(const Duration(days: 6)));
    return _filterByRange(sales, start, end);
  }

  /// Filters sales from the current calendar month.
  static List<Sale> getMonthlySales(List<Sale> sales) {
    final now = DateTime.now();
    final start = DateUtilsHelper.startOfMonth(now);
    final end = DateUtilsHelper.endOfMonth(now);
    return _filterByRange(sales, start, end);
  }

  /// Filters sales from the current calendar year.
  static List<Sale> getYearlySales(List<Sale> sales) {
    final now = DateTime.now();
    final start = DateUtilsHelper.startOfYear(now);
    final end = DateUtilsHelper.endOfYear(now);
    return _filterByRange(sales, start, end);
  }

  /// Filters sales within a custom date range [inclusive].
  static List<Sale> getCustomRangeSales(
    List<Sale> sales,
    DateTime start,
    DateTime end,
  ) {
    final s = DateUtilsHelper.startOfDay(start);
    final e = DateUtilsHelper.endOfDay(end);
    return _filterByRange(sales, s, e);
  }

  // ==================== SUMMARY CALCULATION ====================

  /// Computes a [ReportSummary] from a list of sales.
  static ReportSummary calculateSummary(
    List<Sale> filteredSales,
    String periodLabel,
    DateTime startDate,
    DateTime endDate,
  ) {
    final totalSales = filteredSales.fold<double>(
      0.0,
      (sum, s) => sum + s.totalPrice,
    );
    final totalProfit = filteredSales.fold<double>(
      0.0,
      (sum, s) => sum + s.profit,
    );
    final transactionCount = filteredSales.length;
    final totalQuantity = filteredSales.fold<int>(
      0,
      (sum, s) => sum + s.quantity,
    );
    final avgTransaction = transactionCount > 0
        ? totalSales / transactionCount
        : 0.0;

    return ReportSummary(
      totalSales: totalSales,
      totalProfit: totalProfit,
      transactionCount: transactionCount,
      totalQuantity: totalQuantity,
      averageTransactionValue: avgTransaction,
      periodLabel: periodLabel,
      startDate: startDate,
      endDate: endDate,
    );
  }

  // ==================== CHART DATA ====================

  /// Generates chart-ready data based on the selected period.
  /// Returns a list of maps with keys: 'label', 'sales', 'profit', 'transactions'.
  static List<Map<String, dynamic>> getChartData(
    List<Sale> sales,
    ReportPeriod period,
  ) {
    switch (period) {
      case ReportPeriod.daily:
        return _buildDailyChartData(sales);
      case ReportPeriod.weekly:
        return _buildWeeklyChartData(sales);
      case ReportPeriod.monthly:
        return _buildMonthlyChartData(sales);
      case ReportPeriod.yearly:
        return _buildYearlyChartData(sales);
    }
  }

  // ==================== BEST SELLERS ====================

  /// Returns top N best-selling products by quantity.
  static List<Map<String, dynamic>> getBestSellers(
    List<Sale> sales, {
    int limit = 5,
  }) {
    final Map<String, Map<String, dynamic>> productMap = {};
    for (final sale in sales) {
      if (productMap.containsKey(sale.productName)) {
        productMap[sale.productName]!['quantity'] += sale.quantity;
        productMap[sale.productName]!['totalPrice'] += sale.totalPrice;
        productMap[sale.productName]!['profit'] += sale.profit;
      } else {
        productMap[sale.productName] = {
          'name': sale.productName,
          'quantity': sale.quantity,
          'totalPrice': sale.totalPrice,
          'profit': sale.profit,
        };
      }
    }
    final sorted = productMap.values.toList()
      ..sort((a, b) => (b['quantity'] as int).compareTo(a['quantity'] as int));
    return sorted.take(limit).toList();
  }

  // ==================== PRIVATE HELPERS ====================

  static List<Sale> _filterByRange(List<Sale> sales, DateTime start, DateTime end) {
    return sales.where((sale) {
      return sale.date.isAfter(start.subtract(const Duration(milliseconds: 1))) &&
          sale.date.isBefore(end.add(const Duration(milliseconds: 1)));
    }).toList();
  }

  static List<Map<String, dynamic>> _buildDailyChartData(List<Sale> sales) {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final start = DateUtilsHelper.startOfDay(day);
      final end = DateUtilsHelper.endOfDay(day);
      final daySales = _filterByRange(sales, start, end);
      result.add({
        'label': DateUtilsHelper.formatShortDate(day),
        'sales': daySales.fold(0.0, (sum, s) => sum + s.totalPrice),
        'profit': daySales.fold(0.0, (sum, s) => sum + s.profit),
        'transactions': daySales.length,
      });
    }
    return result;
  }

  static List<Map<String, dynamic>> _buildWeeklyChartData(List<Sale> sales) {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    for (int i = 3; i >= 0; i--) {
      final weekEnd = DateUtilsHelper.endOfDay(now.subtract(Duration(days: i * 7)));
      final weekStart = DateUtilsHelper.startOfDay(weekEnd.subtract(const Duration(days: 6)));
      final weekSales = _filterByRange(sales, weekStart, weekEnd);
      result.add({
        'label': 'W${4 - i}',
        'sales': weekSales.fold(0.0, (sum, s) => sum + s.totalPrice),
        'profit': weekSales.fold(0.0, (sum, s) => sum + s.profit),
        'transactions': weekSales.length,
      });
    }
    return result;
  }

  static List<Map<String, dynamic>> _buildMonthlyChartData(List<Sale> sales) {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final start = DateUtilsHelper.startOfMonth(month);
      final end = DateUtilsHelper.endOfMonth(month);
      final monthSales = _filterByRange(sales, start, end);
      result.add({
        'label': DateUtilsHelper.formatMonthLabel(month),
        'sales': monthSales.fold(0.0, (sum, s) => sum + s.totalPrice),
        'profit': monthSales.fold(0.0, (sum, s) => sum + s.profit),
        'transactions': monthSales.length,
      });
    }
    return result;
  }

  static List<Map<String, dynamic>> _buildYearlyChartData(List<Sale> sales) {
    final result = <Map<String, dynamic>>[];
    final now = DateTime.now();
    // Show current year by month
    for (int i = 1; i <= 12; i++) {
      final month = DateTime(now.year, i, 1);
      final start = DateUtilsHelper.startOfMonth(month);
      final end = DateUtilsHelper.endOfMonth(month);
      final monthSales = _filterByRange(sales, start, end);
      result.add({
        'label': _monthAbbreviation(i),
        'sales': monthSales.fold(0.0, (sum, s) => sum + s.totalPrice),
        'profit': monthSales.fold(0.0, (sum, s) => sum + s.profit),
        'transactions': monthSales.length,
      });
    }
    return result;
  }

  static String _monthAbbreviation(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}

/// Enum representing report time periods.
enum ReportPeriod { daily, weekly, monthly, yearly }

