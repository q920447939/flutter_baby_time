// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shell_default_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
      $myRoute,
      $babySettingRoute,
      $uploadFileRoute,
      $imageEditorPageRouter,
      $tagSettingRoute,
      $myProfileRoute,
      $heightWeightManageRoute,
      $familyApplyHandlePageRoute,
      $familyManagerMemberPageRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myRoute => GoRouteData.$route(
      path: '/my',
      factory: $MyRouteExtension._fromState,
    );

extension $MyRouteExtension on MyRoute {
  static MyRoute _fromState(GoRouterState state) => const MyRoute();

  String get location => GoRouteData.$location(
        '/my',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $babySettingRoute => GoRouteData.$route(
      path: '/baby-setting',
      factory: $BabySettingRouteExtension._fromState,
    );

extension $BabySettingRouteExtension on BabySettingRoute {
  static BabySettingRoute _fromState(GoRouterState state) =>
      const BabySettingRoute();

  String get location => GoRouteData.$location(
        '/baby-setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $uploadFileRoute => GoRouteData.$route(
      path: '/upload',
      factory: $UploadFileRouteExtension._fromState,
    );

extension $UploadFileRouteExtension on UploadFileRoute {
  static UploadFileRoute _fromState(GoRouterState state) =>
      const UploadFileRoute();

  String get location => GoRouteData.$location(
        '/upload',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $imageEditorPageRouter => GoRouteData.$route(
      path: '/image/image-edit',
      factory: $ImageEditorPageRouterExtension._fromState,
    );

extension $ImageEditorPageRouterExtension on ImageEditorPageRouter {
  static ImageEditorPageRouter _fromState(GoRouterState state) =>
      ImageEditorPageRouter(
        filePath: state.uri.queryParameters['file-path']!,
        imageEditType: _$ImageEditTypeEnumMap
            ._$fromName(state.uri.queryParameters['image-edit-type']!),
        imageEditCropLayerType: _$ImageEditCropLayerTypeEnumMap._$fromName(
            state.uri.queryParameters['image-edit-crop-layer-type']!),
      );

  String get location => GoRouteData.$location(
        '/image/image-edit',
        queryParams: {
          'file-path': filePath,
          'image-edit-type': _$ImageEditTypeEnumMap[imageEditType],
          'image-edit-crop-layer-type':
              _$ImageEditCropLayerTypeEnumMap[imageEditCropLayerType],
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$ImageEditTypeEnumMap = {
  ImageEditType.default_: 'default_',
  ImageEditType.end: 'end',
};

const _$ImageEditCropLayerTypeEnumMap = {
  ImageEditCropLayerType.circle: 'circle',
  ImageEditCropLayerType.rectangle: 'rectangle',
  ImageEditCropLayerType.end: 'end',
};

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}

RouteBase get $tagSettingRoute => GoRouteData.$route(
      path: '/tag-setting',
      factory: $TagSettingRouteExtension._fromState,
    );

extension $TagSettingRouteExtension on TagSettingRoute {
  static TagSettingRoute _fromState(GoRouterState state) =>
      const TagSettingRoute();

  String get location => GoRouteData.$location(
        '/tag-setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myProfileRoute => GoRouteData.$route(
      path: '/my-profile',
      factory: $MyProfileRouteExtension._fromState,
    );

extension $MyProfileRouteExtension on MyProfileRoute {
  static MyProfileRoute _fromState(GoRouterState state) =>
      const MyProfileRoute();

  String get location => GoRouteData.$location(
        '/my-profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $heightWeightManageRoute => GoRouteData.$route(
      path: '/height-weight-manage',
      factory: $HeightWeightManageRouteExtension._fromState,
    );

extension $HeightWeightManageRouteExtension on HeightWeightManageRoute {
  static HeightWeightManageRoute _fromState(GoRouterState state) =>
      const HeightWeightManageRoute();

  String get location => GoRouteData.$location(
        '/height-weight-manage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familyApplyHandlePageRoute => GoRouteData.$route(
      path: '/family/familyApply',
      factory: $FamilyApplyHandlePageRouteExtension._fromState,
    );

extension $FamilyApplyHandlePageRouteExtension on FamilyApplyHandlePageRoute {
  static FamilyApplyHandlePageRoute _fromState(GoRouterState state) =>
      FamilyApplyHandlePageRoute();

  String get location => GoRouteData.$location(
        '/family/familyApply',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familyManagerMemberPageRoute => GoRouteData.$route(
      path: '/family-manager/familyManagerMemberPage',
      factory: $FamilyManagerMemberPageRouteExtension._fromState,
    );

extension $FamilyManagerMemberPageRouteExtension
    on FamilyManagerMemberPageRoute {
  static FamilyManagerMemberPageRoute _fromState(GoRouterState state) =>
      FamilyManagerMemberPageRoute();

  String get location => GoRouteData.$location(
        '/family-manager/familyManagerMemberPage',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
