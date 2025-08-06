import 'package:intl/intl.dart';
import '../../../models/product_list.dart';
import '../../../models/product_price.dart';

class PriceGeneratorService {
  static String formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  static String getArabicDayName(DateTime date) {
    final days = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];
    return days[date.weekday % 7];
  }

  static DateTime parseDateFromString(String dateString) {
    try {
      final dateParts = dateString.split('/');
      if (dateParts.length == 3) {
        return DateTime(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2]),
        );
      }
    } catch (e) {
      // If parsing fails, return current date
    }
    return DateTime.now();
  }

  static bool validateProductPrices(Map<String, ProductPrice> productPrices) {
    return productPrices.isNotEmpty;
  }

  static ProductList createProductList({
    required String id,
    required DateTime selectedDate,
    required Map<String, ProductPrice> productPrices,
    required DateTime createdAt,
  }) {
    final dateString = formatDate(selectedDate);
    final dayString = getArabicDayName(selectedDate);

    return ProductList(
      id: id,
      date: dateString,
      day: dayString,
      products: productPrices.values.toList(),
      createdAt: createdAt,
    );
  }
}
