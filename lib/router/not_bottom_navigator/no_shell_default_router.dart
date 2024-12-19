import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../model/baby/BabyInfoRespVO.dart';
import '../../page/base/auth/views/login_screen.dart';
import '../../page/base/auth/views/password_recovery_screen.dart';
import '../../page/base/auth/views/signup_screen.dart';
import '../../page/base/onbording/views/onbording_screnn.dart';
import '../../page/family/family_create_page.dart';
import '../../page/family/family_manager_page.dart';
import '../../page/family/family_select_exists_page.dart';
import '../../utils/member_helper.dart';
import '../../utils/response/response_utils.dart';
part 'no_shell_default_router.g.dart';

@TypedGoRoute<OnBordingScreenRouter>(path: '/welcome')
@immutable
class OnBordingScreenRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    updateFirstUse();
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

@TypedGoRoute<FamilyManagerPageRouter>(path: '/familyManager')
@immutable
class FamilyManagerPageRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FamilyManagerPage();
  }
}

@TypedGoRoute<FamilyCreatePageRouter>(path: '/familyManager/create')
@immutable
class FamilyCreatePageRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FamilyCreatePage();
  }
}

@TypedGoRoute<FamilySelectExistsPageRouter>(path: '/familyManager/selectExists')
@immutable
class FamilySelectExistsPageRouter extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FamilySelectExistsPage();
  }
}
