import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';
import 'package:clipboard/clipboard.dart';

//TODO 未测试
class RedClipboardInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    FlutterClipboard.paste().then((value) {
      logger.i("red clipboard is $value");
    });
  }
}
