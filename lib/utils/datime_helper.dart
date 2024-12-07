//把datime格式化成字符串
import 'package:easy_localization/easy_localization.dart';

String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

DateTime parseDate(String dateStr) {
  return DateFormat('yyyy-MM-dd').parse(dateStr);
}

DateTime parseDateTime(String dateStr) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateStr);
}

/**
 * 判断投资周期，
 * 如果 开始时间和 结束时间的差值 小于 3天，那么显示小时数(分钟数省略)
 * 超过三天，那么 就显示 x天 x小时  ，如果是 0 小时，那么就显示 x天即可
 */
String formatDateTimeDifferenceDay(DateTime startTime, DateTime endTime) {
  final difference = endTime.difference(startTime);
  final days = difference.inDays;

  return '${days}天';
}

/**
 * 判断投资周期，
 * 如果 开始时间和 结束时间的差值 小于 3天，那么显示小时数(分钟数省略)
 * 超过三天，那么 就显示 x天 x小时  ，如果是 0 小时，那么就显示 x天即可
 */
String formatTimeDifference(DateTime startTime, DateTime endTime) {
  final difference = endTime.difference(startTime);
  final days = difference.inDays;
  final hours = difference.inHours.remainder(24);

  if (days < 3) {
    // 如果时间差小于 3 天,只显示小时数
    return '${hours}小时';
  } else {
    // 否则显示 x 天 x 小时
    if (hours == 0) {
      return '${days}天';
    } else {
      return '${days}天 ${hours}小时';
    }
  }
}
