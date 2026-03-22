import 'package:intl/intl.dart';

class Formatter {
  static String formatPrice(num price) {
    final formatter = NumberFormat('#,##,##0.00', 'en_IN');
    return formatter.format(price);
  }

  static String formatChange(double change) {
    return "${change.toStringAsFixed(2)}%";
  }
}
