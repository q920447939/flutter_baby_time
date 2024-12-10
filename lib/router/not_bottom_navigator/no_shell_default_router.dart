import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../page/base/auth/views/login_screen.dart';
import '../../page/base/auth/views/password_recovery_screen.dart';
import '../../page/base/auth/views/signup_screen.dart';
import '../../page/base/onbording/views/onbording_screnn.dart';
part 'no_shell_default_router.g.dart';

@TypedGoRoute<OnBordingScreenRouter>(path: '/welcome')
@immutable
class OnBordingScreenRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnBordingScreen();
  }
}

@TypedGoRoute<SignUpScreenRouter>(path: '/signup')
@immutable
class SignUpScreenRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SignUpScreen();
  }
}

@TypedGoRoute<SignInScreenRouter>(path: '/signin')
@immutable
class SignInScreenRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginScreen();
  }
}

@TypedGoRoute<PasswordRecoveryScreenRouter>(path: '/passwordRecovery')
@immutable
class PasswordRecoveryScreenRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PasswordRecoveryScreen();
  }
}
