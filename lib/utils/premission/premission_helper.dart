import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

Future<bool> requestPermission(BuildContext context) async {
  if (Platform.isAndroid || Platform.isIOS) {
    final status = await Permission.photos.status;
    if (status.isDenied) {
      final result = await Permission.photos.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      // 用户永久拒绝了权限
      final bool? openSettings = await SmartDialog.show(
        builder: (_) => TDAlertDialog(
          title: '需要相册权限',
          content: '请在设置中允许访问相册，以便选择上传的图片',
          leftBtn: TDDialogButtonOptions(
              title: '取消',
              action: () {
                SmartDialog.dismiss(result: false);
              }),
          rightBtn: TDDialogButtonOptions(
            title: '去设置',
            action: () {
              SmartDialog.dismiss(result: false);
            },
          ),
        ),
      );
      if (openSettings == true) {
        await openAppSettings();
        // 用户从设置页面返回后，重新检查权限
        final status = await Permission.photos.status;
        if (!status.isGranted) {
          await dialogFailure('获取权限失败!');
          // 如果权限仍然未授予，才返回上一页
          if (context.mounted) {
            context.pop();
          }
        }
        return true;
      }
      return false;
    }
    return status.isGranted;
  } else if (kIsWeb) {
    return true;
  }
  return false;
}
