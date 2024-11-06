import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

confirmDialog(
  String content, {
  Function()? leftBtnAction,
  Function()? rightBtnAction,
}) async {
  await SmartDialog.show(
      tag: 'confirmDialog',
      builder: (context) {
        return TDAlertDialog(
            content: content,
            leftBtnAction: () {
              SmartDialog.dismiss(tag: 'confirmDialog', force: true);
              leftBtnAction?.call();
            },
            rightBtnAction: () {
              SmartDialog.dismiss(tag: 'confirmDialog', force: true);
              rightBtnAction?.call();
            });
      });
}
