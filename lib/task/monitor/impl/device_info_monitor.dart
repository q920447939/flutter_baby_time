import '../app_monitor.dart';
import 'package:cron/cron.dart';
//import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    final cron = Cron();
    cron.schedule(Schedule.parse('*/5 * * * * *'), () {
      _print();
    });
  }

  Future<void> _print() async {
    /*final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    final allInfo = deviceInfo.data;
    print("allInfo is $allInfo");*/
  }
}
