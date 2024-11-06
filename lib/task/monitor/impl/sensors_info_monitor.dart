import '../../../utils/logger_helper.dart';
import '../app_monitor.dart';
import 'package:sensors_plus/sensors_plus.dart';

//传感器
// 调用 AccelerometerEvent event 次数过多
class SensorsInfoMonitor with AppMonitor {
  @override
  Future<void> monitor() async {
    accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        //logger.i("sensor AccelerometerEvent event $event");
      },
      onError: (error) {
// Logic to handle error
// Needed for Android in case sensor is not available
        logger.i("sensor AccelerometerEvent error $error");
      },
      cancelOnError: true,
    );
// [AccelerometerEvent (x: 0.0, y: 9.8, z: 0.0)]

/*    userAccelerometerEventStream().listen(
      (UserAccelerometerEvent event) {
        print(event);
        logger.i("sensor UserAccelerometerEvent event $event");
      },
      onError: (error) {
// Logic to handle error
// Needed for Android in case sensor is not available
        logger.i("sensor UserAccelerometerEvent error $error");
      },
      cancelOnError: true,
    );
// [UserAccelerometerEvent (x: 0.0, y: 0.0, z: 0.0)]

    gyroscopeEventStream().listen(
      (GyroscopeEvent event) {
        logger.i("sensor GyroscopeEvent event $event");
      },
      onError: (error) {
// Logic to handle error
// Needed for Android in case sensor is not available
        logger.i("sensor GyroscopeEvent error $error");
      },
      cancelOnError: true,
    );
// [GyroscopeEvent (x: 0.0, y: 0.0, z: 0.0)]

    magnetometerEventStream().listen(
      (MagnetometerEvent event) {
        logger.i("sensor MagnetometerEvent event $event");
      },
      onError: (error) {
// Logic to handle error
// Needed for Android in case sensor is not available
        logger.i("sensor MagnetometerEvent error $error");
      },
      cancelOnError: true,
    );*/
  }
}
