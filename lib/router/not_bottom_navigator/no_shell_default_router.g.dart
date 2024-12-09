// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_shell_default_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $onBordingScreenRouter,
    ];

RouteBase get $onBordingScreenRouter => GoRouteData.$route(
      path: '/welcome',
      factory: $OnBordingScreenRouterExtension._fromState,
    );

extension $OnBordingScreenRouterExtension on OnBordingScreenRouter {
  static OnBordingScreenRouter _fromState(GoRouterState state) =>
      OnBordingScreenRouter();

  String get location => GoRouteData.$location(
        '/welcome',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
