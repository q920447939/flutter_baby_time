import 'package:permission_handler/permission_handler.dart';

class RequestPermission {
  String permissionLocalName;

  List<Permission> permissions;

  bool isMust = false;

  String showTip = "";

  RequestPermission(
      {required this.permissionLocalName,
      required this.permissions,
      this.isMust = false,
      this.showTip = ""});

  get getPermissionLocalName => permissionLocalName;

  get getPermissions => permissions;

  get getIsMust => isMust;

  get getShowTip => showTip;
}
