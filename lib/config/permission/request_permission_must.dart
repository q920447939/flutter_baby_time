import 'package:permission_handler/permission_handler.dart';

import '../../widget/permission/permission_item.dart';

List<PermissionItem> mustRequestPermission = [
  PermissionItem(
      permissionLocalName: '摄像头',
      permissions: [Permission.camera],
      isMust: true,
      showTip: "允许应用访问摄像头进行拍照,方便您上传照片"),
  PermissionItem(
      permissionLocalName: '位置',
      permissions: [
        Permission.location,
      ],
      isMust: true,
      showTip: "允许应用获取定位信息,方便您进行位置共享"),
  PermissionItem(
      permissionLocalName: '传感器',
      permissions: [
        Permission.sensors,
      ],
      isMust: false,
      showTip: "允许应用获取传感器状态"),
  PermissionItem(
      permissionLocalName: '联系人',
      permissions: [
        Permission.contacts,
      ],
      isMust: false,
      showTip: "允许应用获取联系人,方便找到您的朋友"),
  PermissionItem(
      permissionLocalName: '相册',
      permissions: [
        Permission.photos,
      ],
      isMust: false,
      showTip: "允许应用访问相册,方便您从相册中选择照片"),
  PermissionItem(
      permissionLocalName: '视频',
      permissions: [
        Permission.videos,
      ],
      isMust: true,
      showTip: "允许应用需要时访问视频文件,方便您从相册中选择视频"),
  PermissionItem(
      permissionLocalName: '录音文件',
      permissions: [
        Permission.audio,
      ],
      isMust: false,
      showTip: "允许应用需要时访问录音文件,方便您从相册中选择录音"),
  PermissionItem(
      permissionLocalName: '获取应用偏好',
      permissions: [Permission.requestInstallPackages],
      isMust: false,
      showTip: "允许获取应用偏好，方便对你个性化推荐"),
];

//get mustRequestPermission => _mustRequestPermission;
