import 'package:battery_plus/battery_plus.dart';

import '../app_monitor.dart';

class BatteryInfoMonitor with AppMonitor {
  // Instantiate it
  var battery = Battery();

  @override
  Future<void> monitor() async {
    print("battery is start ... ");
    // Access current battery level
    var batteryLevel = await battery.batteryLevel;
    print(" battery level is $batteryLevel");

// Be informed when the state (full, charging, discharging) changes
    battery.onBatteryStateChanged.listen((BatteryState state) {
      // Do something with new state
      print(" battery state is $state");
    });

// Check if device in battery save mode
// Currently available on Android, iOS and Windows platforms only
    var isInBatterySaveMode = await battery.isInBatterySaveMode;
    print(" isInBatterySaveMode is $isInBatterySaveMode");

    print("battery is end ... ");
  }
}
