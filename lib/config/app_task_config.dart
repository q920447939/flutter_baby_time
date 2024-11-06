import '../task/timers/app_times.dart';
import '../task/timers/impl/update_token_times.dart';
import '../task/timers/impl/upgrade_times.dart';

List<AppTimes> tasks = [
  UpdateTokenTimes(),
  UpgradeTimes(),
];

void task() async {
  for (var task in tasks) {
    try {
      task.start();
    } catch (e) {
      print(e);
    }
  }
}
