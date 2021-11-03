import 'package:intl/intl.dart';

class FormattedDateTime {
  final DateFormat allTimeFormatter = DateFormat('d MMMM HH:mm');
  final DateFormat timeFormatter = DateFormat('HH:mm');

  final DateTime date;

  FormattedDateTime(this.date);

  String get formattedDate => _prefix + _dateFormat.format(date);

  String get _prefix {
    final daysBetween = _daysBetweenNow;
    if (daysBetween == 0) {
      return 'Сегодня в ';
    } else if (daysBetween == 1) {
      return '$daysBetween день назад в ';
    } else if (daysBetween <= 3) {
      return '$daysBetween дня назад в ';
    } else {
      return '';
    }
  }

  DateFormat get _dateFormat {
    if (_daysBetweenNow > 3) {
      return allTimeFormatter;
    }
    return timeFormatter;
  }

  int get _daysBetweenNow {
    final today = DateTime.now();
    final beginDay = DateTime(date.year, date.month, date.day);
    return today.difference(beginDay).inDays;
  }
}
