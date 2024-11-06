import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionItem extends StatelessWidget {
  String permissionLocalName;

  List<Permission> permissions;

  bool isMust = false;

  String showTip = "";

  get getPermissionLocalName => permissionLocalName;

  PermissionItem({
    super.key,
    required this.permissionLocalName,
    required this.permissions,
    this.isMust = false,
    this.showTip = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      child: Text(
        showTip,
        style: TextStyle(fontSize: 12.sp),
      ),
    );
  }
}
