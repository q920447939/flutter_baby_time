import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';
import 'package:screen_brightness/screen_brightness.dart';

/// 屏幕亮度
class ScreenBrightnessInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    systemBrightness.then((value) {
      logger.i("system brightness is $value");
    });
    currentBrightness.then((value) {
      logger.i("current brightness is $value");
    });
  }

  Future<double> get systemBrightness async {
    try {
      return await ScreenBrightness().system;
    } catch (e) {
      print(e);
      throw 'Failed to get system brightness';
    }
  }

  Future<double> get currentBrightness async {
    try {
      return await ScreenBrightness().current;
    } catch (e) {
      print(e);
      throw 'Failed to get current brightness';
    }
  }
}
