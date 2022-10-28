import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}

bool comapararDatas(DateTime data1, DateTime data2) {
  return data1.day == data2.day &&
      data1.month == data2.month &&
      data1.year == data2.year;
}
