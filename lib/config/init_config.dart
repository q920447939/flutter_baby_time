import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../utils/logger_helper.dart';
import 'app_task_config.dart';
import 'dio_config.dart';
import 'monitor_config.dart';

Future<void> init() async {
  await dotenv.load();
  SP = await SharedPreferences.getInstance();
  //monitor();
  initDioConfig();
  task();
  logger.i("load env file success ${dotenv.env['SERVER_HOST']}");
}
