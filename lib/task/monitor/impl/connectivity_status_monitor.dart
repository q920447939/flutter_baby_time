import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatusInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      logger.i("I am connected to a mobile network");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      logger.i("I am connected to a wifi network");
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      // I am connected to a ethernet network.
      logger.i("I am connected to a ethernet network");
    } else if (connectivityResult == ConnectivityResult.vpn) {
      // I am connected to a vpn network.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
      logger.i("I am connected to a vpn network");
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      // I am connected to a bluetooth.
      logger.i("I am connected to a bluetooth network");
    } else if (connectivityResult == ConnectivityResult.other) {
      // I am connected to a network which is not in the above mentioned networks.
      logger.i(
          "I am connected to a network which is not in the above mentioned networks");
    } else if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to any network.
      logger.i("I am not connected to any network");
    }
  }
}
