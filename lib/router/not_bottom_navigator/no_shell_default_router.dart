import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

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
