import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/config/server_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../intl/intl_resource_delegate.dart';
import 'go_router_config.dart';

Widget buildMaterialApp(bool isFirstUse, TDThemeData themeData,
    BuildContext context, Locale? locale, IntlResourceDelegate delegate) {
  // here
  final initSmartDialog = FlutterSmartDialog.init();
  //填入设计稿中设备的屏幕尺寸,单位dp
  return ScreenUtilInit(
    designSize: const Size(412, 892),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      // 设置文案代理,国际化需要在MaterialApp初始化完成之后才生效,而且需要每次更新context
      TDTheme.setResourceBuilder((context) => delegate..updateContext(context),
          needAlwaysBuild: true);
      return MediaQuery(
        data:
            MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: locale,
          debugShowCheckedModeBanner: false,
          title: ServerConfig().appName,
          theme: ThemeData(
              extensions: [themeData],
              colorScheme:
                  ColorScheme.light(primary: themeData.brandNormalColor)),
          routerConfig: router,
          builder: initSmartDialog,
        ),
      );
    },
  );
}
