import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_baby_time/page/my/my_page.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../getx/controller/manager_gex_controller.dart';
import '../../page/family/family_apply_handle_page.dart';
import '../../page/family/family_manger/family_manager_member_page.dart';
import '../../page/heightWeight/height_weight_manage_page.dart';
import '../../page/home/home_page.dart';
import '../../page/my/baby_setting/baby_setting.dart';
import '../../page/my/my_profile/my_profile_page.dart';
import '../../page/my/tag_settring/tag_setting_page.dart';
import '../../page/upload/upload_file_page/upload_file_page.dart';
import '../../widget/image_edit/image_edit.dart';
import '../../widget/image_edit/image_edit_type.dart';

part 'shell_default_router.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
)
@immutable
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    bottomBarIndexLogic.setCurrIndex(0);
    return const HomePage();
  }
}

@TypedGoRoute<MyRoute>(
  path: '/my',
)
@immutable
class MyRoute extends GoRouteData {
  const MyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    bottomBarIndexLogic.setCurrIndex(2);
    return const MyPage();
  }
}

@TypedGoRoute<BabySettingRoute>(
  path: '/baby-setting',
)
@immutable
class BabySettingRoute extends GoRouteData {
  const BabySettingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BabySetting();
  }
}

@TypedGoRoute<UploadFileRoute>(
  path: '/upload',
)
@immutable
class UploadFileRoute extends GoRouteData {
  const UploadFileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    bottomBarIndexLogic.setCurrIndex(1);
    return UploadFilePage();
  }
}

@TypedGoRoute<ImageEditorPageRouter>(path: '/image/image-edit')
@immutable
class ImageEditorPageRouter extends GoRouteData {
  String filePath;
  ImageEditType imageEditType;
  ImageEditCropLayerType imageEditCropLayerType;

  ImageEditorPageRouter({
    required this.filePath,
    required this.imageEditType,
    required this.imageEditCropLayerType,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ImageEditorPage(
      filePath: filePath,
      imageEditType: imageEditType,
      editorCropLayerPainter:
          imageEditCropLayerType.getEditorCropLayerPainter(),
    );
  }
}

@TypedGoRoute<TagSettingRoute>(
  path: '/tag-setting',
)
@immutable
class TagSettingRoute extends GoRouteData {
  const TagSettingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TagSettingPage();
  }
}

@TypedGoRoute<MyProfileRoute>(
  path: '/my-profile',
)
@immutable
class MyProfileRoute extends GoRouteData {
  const MyProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MyProfilePage();
  }
}

@TypedGoRoute<HeightWeightManageRoute>(
  path: '/height-weight-manage',
)
@immutable
class HeightWeightManageRoute extends GoRouteData {
  const HeightWeightManageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HeightWeightManagePage();
  }
}

@TypedGoRoute<FamilyApplyHandlePageRoute>(
  path: '/family/familyApply',
)
@immutable
class FamilyApplyHandlePageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FamilyApplyHandlePage();
  }
}

@TypedGoRoute<FamilyManagerMemberPageRoute>(
  path: '/family-manager/familyManagerMemberPage',
)
@immutable
class FamilyManagerMemberPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FamilyManagerMemberPage();
  }
}
