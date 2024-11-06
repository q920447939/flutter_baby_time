import '../../model/app_config/navigator/app_navigator_config_model.dart';

Map<String, int> _bottomBarIndexMap = {};

void bottomBarIndexMap(List<NavigationConfigVo> appNavigatorConfigList) {
  for (int i = 0; i < appNavigatorConfigList.length; i++) {
    var item = appNavigatorConfigList[i];
    _bottomBarIndexMap[item.targetUri!] = i;
  }
}

Map<String, int> getBottomBarIndexMap() {
  return _bottomBarIndexMap;
}

int getBottomBarIndex(String uri) {
  return _bottomBarIndexMap[uri]!;
}
