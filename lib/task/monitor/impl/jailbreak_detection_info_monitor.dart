import 'dart:io';

import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

///越狱检测
class JailbreakDetectionInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    logger.i("jailbroken: $jailbroken");
    if (Platform.isAndroid) {
      bool developerMode =
          await FlutterJailbreakDetection.developerMode; // android only.
      logger.i("developerMode: $developerMode");
    }
  }
}
