import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    final info = await PackageInfo.fromPlatform();
    logger.i("app info is $info");
  }
}
