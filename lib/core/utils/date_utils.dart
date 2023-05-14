import 'package:intl/intl.dart';

abstract class Formatters {
  static final allTime = DateFormat('d MMMM HH:mm', 'ru_RU');
  static final time = DateFormat('HH:mm', 'ru_RU');
  static final operation = DateFormat('yyyy-MM-ddTHH:mm:ss');
}


extension DateTimeUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    final todayNight = DateTime(now.year, now.month, now.day);

    return isAfter(todayNight);
  }

  String get formatted => _prefix + _dateFormat.format(this);

  String get _prefix {
    final daysBetween = _daysBetweenNow;
    if (daysBetween == 0) {
      return 'Сегодня в ';
    } else if (daysBetween == 1) {
      return 'Вчера в ';
    } else if (daysBetween <= 3) {
      return '$daysBetween дня назад в ';
    } else {
      return '';
    }
  }

  DateFormat get _dateFormat {
    if (_daysBetweenNow > 3) {
      return Formatters.allTime;
    }
    return Formatters.time;
  }

  int get _daysBetweenNow {
    final today = DateTime.now();
    final beginDay = DateTime(year, month, day);
    return today.difference(beginDay).inDays;
  }
}
