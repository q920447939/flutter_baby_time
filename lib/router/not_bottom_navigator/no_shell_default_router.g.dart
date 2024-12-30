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
      $familyManagerPageRouter,
      $familyCreatePageRouter,
      $familySelectExistsPageRouter,
      $familyApplyPageRouter,
      $familyApplyHistoryPageRouter,
      $babyInfoCreatePageRouter,
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

RouteBase get $familyManagerPageRouter => GoRouteData.$route(
      path: '/familyManager',
      factory: $FamilyManagerPageRouterExtension._fromState,
    );

extension $FamilyManagerPageRouterExtension on FamilyManagerPageRouter {
  static FamilyManagerPageRouter _fromState(GoRouterState state) =>
      FamilyManagerPageRouter();

  String get location => GoRouteData.$location(
        '/familyManager',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familyCreatePageRouter => GoRouteData.$route(
      path: '/familyManager/create',
      factory: $FamilyCreatePageRouterExtension._fromState,
    );

extension $FamilyCreatePageRouterExtension on FamilyCreatePageRouter {
  static FamilyCreatePageRouter _fromState(GoRouterState state) =>
      FamilyCreatePageRouter();

  String get location => GoRouteData.$location(
        '/familyManager/create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familySelectExistsPageRouter => GoRouteData.$route(
      path: '/familyManager/selectExists',
      factory: $FamilySelectExistsPageRouterExtension._fromState,
    );

extension $FamilySelectExistsPageRouterExtension
    on FamilySelectExistsPageRouter {
  static FamilySelectExistsPageRouter _fromState(GoRouterState state) =>
      FamilySelectExistsPageRouter();

  String get location => GoRouteData.$location(
        '/familyManager/selectExists',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familyApplyPageRouter => GoRouteData.$route(
      path: '/familyManager/applyFamily',
      factory: $FamilyApplyPageRouterExtension._fromState,
    );

extension $FamilyApplyPageRouterExtension on FamilyApplyPageRouter {
  static FamilyApplyPageRouter _fromState(GoRouterState state) =>
      FamilyApplyPageRouter();

  String get location => GoRouteData.$location(
        '/familyManager/applyFamily',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $familyApplyHistoryPageRouter => GoRouteData.$route(
      path: '/familyManager/applyFamilyHistory',
      factory: $FamilyApplyHistoryPageRouterExtension._fromState,
    );

extension $FamilyApplyHistoryPageRouterExtension
    on FamilyApplyHistoryPageRouter {
  static FamilyApplyHistoryPageRouter _fromState(GoRouterState state) =>
      FamilyApplyHistoryPageRouter();

  String get location => GoRouteData.$location(
        '/familyManager/applyFamilyHistory',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $babyInfoCreatePageRouter => GoRouteData.$route(
      path: '/babyInfo/create',
      factory: $BabyInfoCreatePageRouterExtension._fromState,
    );

extension $BabyInfoCreatePageRouterExtension on BabyInfoCreatePageRouter {
  static BabyInfoCreatePageRouter _fromState(GoRouterState state) =>
      BabyInfoCreatePageRouter();

  String get location => GoRouteData.$location(
        '/babyInfo/create',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
