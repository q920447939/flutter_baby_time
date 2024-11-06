import 'dart:async';

import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../main.dart';
import '../../../utils/logger_helper.dart';
import '../../../widget/upgrade/upgrade_dialog.dart';
import '../app_times.dart';

Timer? _timer;

bool _visible = false;

class UpgradeTimes with AppTimes {
  @override
  void start() {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 60 * 60), (timer) async {
      if (_visible) {
        return;
      }
      _visible = true;
      /*AppUpgradeVersionDao.getLatestVersion().then((res) {
        if (null == res) {
          _visible = false;
          return;
        }
        SmartDialog.show(
            clickMaskDismiss: false,
            permanent: true,
            tag: 'upgrade',
            builder: (_) {
              return UpgradeDialog(
                title: res.upgradeTitle ?? '升级提示',
                content: res.upgradeContent ?? '',
                upgradeButtonText: '立即升级',
                forceUpdate: res.forceUpgrade! == 1 ? false : true,
                onTapUpgrade: () async {
                  */ /*await EasyLauncher.url(
                      url: "https://pub.dev", mode: Mode.externalApp);*/ /*
                },
              );
            }).then((res) {
          _visible = false;
        });
      }).catchError((e) {
        _visible = false;
        logger.e("UpgradeTimes error $e");
      });*/
    });
  }

  @override
  void stop() {
    // TODO: implement stop
  }
}
