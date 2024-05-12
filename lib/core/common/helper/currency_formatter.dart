import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  static final _usdFormat = NumberFormat.currency(locale: 'en_US', symbol: '\$');

  static String formatAsBRL(double value) {
    return _currencyFormat.format(value);
  }

  static String formatAsUSD(double value) {
    return _usdFormat.format(value);
  }
}
