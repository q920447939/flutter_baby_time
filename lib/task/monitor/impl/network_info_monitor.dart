import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';
//import 'package:network_info_plus/network_info_plus.dart';

class NetWorkInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    /*final info = NetworkInfo();
    final wifiName = await info.getWifiName(); // "FooNetwork"
    logger.i("net_work_info  wifiName is $wifiName");
    final wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    logger.i("net_work_info  wifiBSSID is $wifiBSSID");
    final wifiIP = await info.getWifiIP(); // 192.168.1.43
    logger.i("net_work_info  wifiIP is $wifiIP");
    final wifiIPv6 =
        await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    logger.i("net_work_info  wifiIPv6 is $wifiIPv6");
    final wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    logger.i("net_work_info  wifiSubmask is $wifiSubmask");
    final wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    logger.i("net_work_info  wifiBroadcast is $wifiBroadcast");
    final wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1
    logger.i("net_work_info  wifiGateway is $wifiGateway");*/
  }
}
