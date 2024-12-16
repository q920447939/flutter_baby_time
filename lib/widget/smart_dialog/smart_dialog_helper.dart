import 'dart:ui';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<void> dialogFailure(String msg,
    {Duration displayTime = const Duration(seconds: 3),
    VoidCallback? onDismiss}) async {
  return await SmartDialog.showNotify(
      msg: msg,
      notifyType: NotifyType.failure,
      displayTime: displayTime,
      onDismiss: onDismiss);
}

Future<void> dialogSuccess(String msg,
    {Duration displayTime = const Duration(seconds: 3),
    bool clickMaskDismiss = false,
    VoidCallback? onDismiss}) async {
  return await SmartDialog.showNotify(
      msg: msg,
      notifyType: NotifyType.success,
      displayTime: displayTime,
      debounce: true,
      clickMaskDismiss: clickMaskDismiss,
      onDismiss: () async {
        onDismiss?.call();
        await SmartDialog.dismiss();
      });
}

Future<void> dialogWarning(
  String msg, {
  Duration displayTime = const Duration(seconds: 2),
}) async {
  return await SmartDialog.showNotify(
    msg: msg,
    notifyType: NotifyType.warning,
    displayTime: displayTime,
  );
}

void dialogLoading({
  String msg = '加载中...',
  bool clickMaskDismiss = false,
  Duration displayTime = const Duration(seconds: 3),
  VoidCallback? onDismiss,
}) {
  SmartDialog.showLoading(msg: msg, clickMaskDismiss: clickMaskDismiss);
}
