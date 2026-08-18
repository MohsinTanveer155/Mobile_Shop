import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/sale.dart';
import '../models/report_summary.dart';
import '../utils/date_utils.dart';

/// Service for generating and sharing PDF reports.
class PdfExportService {
  PdfExportService._();

  /// Generates a styled PDF report and opens the system share sheet.
  static Future<void> generateAndShareReport({
    required ReportSummary summary,
    required List<Sale> sales,
    required String periodTitle,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          _buildHeader(periodTitle, summary),
          pw.SizedBox(height: 20),
          _buildSummaryTable(summary),
          pw.SizedBox(height: 20),
          _buildTransactionsTable(sales),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final fileName =
        'report_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${output.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles(
      [XFile(file.path)],
      subject: 'Mobile Shop POS Report - $periodTitle',
    );
  }

  static pw.Widget _buildHeader(String title, ReportSummary summary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Mobile Shop POS',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.indigo,
          ),
        ),
        pw.Text(
          'Report: $title',
          style: const pw.TextStyle(fontSize: 16),
        ),
        pw.Text(
          'Generated on ${DateUtilsHelper.formatReportDate(DateTime.now())}',
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
        ),
        pw.Text(
          'Period: ${DateUtilsHelper.formatReportDate(summary.startDate)} - ${DateUtilsHelper.formatReportDate(summary.endDate)}',
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
        ),
      ],
    );
  }

  static pw.Widget _buildSummaryTable(ReportSummary summary) {
    return pw.TableHelper.fromTextArray(
      headerDecoration: const pw.BoxDecoration(color: PdfColors.indigo),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
      ),
      headers: ['Metric', 'Value'],
      data: [
        ['Total Sales', 'Rs ${summary.totalSales.toStringAsFixed(2)}'],
        ['Total Profit', 'Rs ${summary.totalProfit.toStringAsFixed(2)}'],
        ['Transactions', '${summary.transactionCount}'],
        ['Items Sold', '${summary.totalQuantity}'],
        [
          'Average Transaction',
          'Rs ${summary.averageTransactionValue.toStringAsFixed(2)}'
        ],
        [
          'Profit Margin',
          '${(summary.profitMargin * 100).toStringAsFixed(1)}%'
        ],
      ],
    );
  }

  static pw.Widget _buildTransactionsTable(List<Sale> sales) {
    if (sales.isEmpty) {
      return pw.Text('No transactions for this period.');
    }

    final sorted = List<Sale>.from(sales)
      ..sort((a, b) => b.date.compareTo(a.date));

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Transactions',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headers: ['Date', 'Product', 'Qty', 'Total', 'Profit'],
          data: sorted.map((sale) {
            return [
              DateUtilsHelper.formatDateTime(sale.date),
              sale.productName,
              '${sale.quantity}',
              'Rs ${sale.totalPrice.toStringAsFixed(2)}',
              'Rs ${sale.profit.toStringAsFixed(2)}',
            ];
          }).toList(),
        ),
      ],
    );
  }
}

