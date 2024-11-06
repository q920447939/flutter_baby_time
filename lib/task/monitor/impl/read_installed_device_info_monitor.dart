import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';

import 'package:device_apps/device_apps.dart';

//获取已安装的APP
class ReadInstalledDeviceInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    List<Application> apps = await DeviceApps.getInstalledApplications();
    logger.i('已安装的应用有${apps.length}个');
    for (var element in apps) {
      logger.i("已安装的应用详情  ${element.toString()}");
    }
  }
}
