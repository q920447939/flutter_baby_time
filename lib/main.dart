import 'dart:async';
import 'dart:convert'; // For jsonDecode
import 'dart:io';
import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baby_time/config/server_config.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/init_config.dart';
import 'config/material_app_config.dart';
import 'handle/timer_handle/update_token_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tdesign_flutter/src/util/log.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'intl/intl_resource_delegate.dart';

late SharedPreferences SP;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Add this line
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();

  Log.setCustomLogPrinter((level, tag, msg) => print('[$level] $tag ==> $msg'));

  await init();
  _checkPlatform();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  //强制竖屏
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(
        SafeArea(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: DevicePreview(
              enabled: false,
              builder: (context) => EasyLocalization(
                supportedLocales: [
                  Locale('en', 'US'),
                  Locale('zh'),
                ],
                path:
                    'assets/translations', // <-- change the path of the translation files
                child: MyApp(savedThemeMode: savedThemeMode),
                fallbackLocale: Locale('zh'),
                startLocale: Locale('zh'),
                saveLocale: true,
                useOnlyLangCode: true,
              ), // Wrap your app
            ),
          ),
        ),
      ));
}

///是否是首次使用，如果是首次使用返回true,否則返回faluse ,通过调用shared_perf。。组件
bool _isFirstUse() {
  return SP.getBool("isFirstUse") ?? true;
}

void _checkPlatform() {
  var allowPlatforms = ServerConfig().allowPlatform;
  //根据配置文件 获取允许支持的平台 ,忽略大小写
  //web 单独判断
  if (kIsWeb) {
    if (!allowPlatforms.contains("web")) {
      Log.e("不支持的平台:${Platform.operatingSystem}");
      exit(0);
    }
    return;
  }
  if (!allowPlatforms.contains(Platform.operatingSystem.toLowerCase())) {
    Log.e("不支持的平台:${Platform.operatingSystem}");
    exit(0);
  }
}

class MyApp extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({
    super.key,
    this.savedThemeMode,
  });

  @override
  State<MyApp> createState() => _MyAppState(savedThemeMode: savedThemeMode);
}

class _MyAppState extends State<MyApp> {
  final AdaptiveThemeMode? savedThemeMode;
  late TDThemeData _themeData;
  Locale? locale = const Locale('zh');

  @override
  _MyAppState({
    this.savedThemeMode,
  });

  @override
  void initState() {
    super.initState();
    _themeData = TDThemeData.defaultData();
  }

  @override
  Widget build(BuildContext context) {
    // 使用多套主题
    TDTheme.needMultiTheme();
    // 适配3.16的字体居中前,先禁用字体居中功能
    // kTextForceVerticalCenterEnable = false;
    var delegate = IntlResourceDelegate(context);
    bool isFirstUse = _isFirstUse();
    return buildMaterialApp(isFirstUse, _themeData, context, locale, delegate);
  }
}
