import 'package:intl/intl.dart';

extension TimeFormatter on String {
  String formatTime(String isoTime) {
    final dateTime = DateTime.parse(isoTime); // تبدیل رشته ISO به DateTime
    return DateFormat.Hm().format(dateTime); // فرمت کردن زمان به ساعت و دقیقه
  }
}
