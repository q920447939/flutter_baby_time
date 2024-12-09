// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_shell_default_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $onBordingScreenRouter,
      $signUpScreenRouter,
      $signInScreenRouter,
      $passwordRecoveryScreenRouter,
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

RouteBase get $signUpScreenRouter => GoRouteData.$route(
      path: '/signup',
      factory: $SignUpScreenRouterExtension._fromState,
    );

extension $SignUpScreenRouterExtension on SignUpScreenRouter {
  static SignUpScreenRouter _fromState(GoRouterState state) =>
      SignUpScreenRouter();

  String get location => GoRouteData.$location(
        '/signup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signInScreenRouter => GoRouteData.$route(
      path: '/signin',
      factory: $SignInScreenRouterExtension._fromState,
    );

extension $SignInScreenRouterExtension on SignInScreenRouter {
  static SignInScreenRouter _fromState(GoRouterState state) =>
      SignInScreenRouter();

  String get location => GoRouteData.$location(
        '/signin',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $passwordRecoveryScreenRouter => GoRouteData.$route(
      path: '/passwordRecovery',
      factory: $PasswordRecoveryScreenRouterExtension._fromState,
    );

extension $PasswordRecoveryScreenRouterExtension
    on PasswordRecoveryScreenRouter {
  static PasswordRecoveryScreenRouter _fromState(GoRouterState state) =>
      PasswordRecoveryScreenRouter();

  String get location => GoRouteData.$location(
        '/passwordRecovery',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
