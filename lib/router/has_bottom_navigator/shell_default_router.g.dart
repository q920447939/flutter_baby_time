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
