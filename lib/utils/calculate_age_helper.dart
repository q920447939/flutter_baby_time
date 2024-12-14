import 'package:jiffy/jiffy.dart';

String calculateAge(Jiffy birthJiffy) {
  Jiffy currentJiffy = Jiffy.now();
  if (currentJiffy.year == birthJiffy.year) {
    return '${currentJiffy.month - birthJiffy.month}个月';
  }
  var numOfYear = currentJiffy.diff(birthJiffy, unit: Unit.year);
  int year = numOfYear.toInt();

  var numOfMonth = currentJiffy.diff(birthJiffy, unit: Unit.month);
  if (year == 0) {
    return '${numOfMonth.toInt()}个月';
  }

  return '$year岁${numOfMonth.toInt() - year * 12}个月';
}
