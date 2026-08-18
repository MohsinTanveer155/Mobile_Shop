import 'package:equatable/equatable.dart';

/// ISO 4217 currency with formatting locale.
class Currency extends Equatable {
  final String code;
  final String name;
  final String symbol;
  final String locale;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.locale,
  });

  String get displayName => '$code - $name';

  /// Currencies that typically display without fractional digits.
  bool get usesWholeUnits => code == 'JPY' || code == 'PKR';

  @override
  List<Object?> get props => [code, name, symbol, locale];
}
