import 'package:get/get.dart';

import '../../design_pattern/view_model/ViewModel.dart';
import '../../main.dart';

class ViewModeController extends GetxController {
  static const String _viewModeKey = 'view_mode';
  final Rx<ViewMode> currentMode = ViewMode.timeline.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedViewMode();
  }

  Future<void> loadSavedViewMode() async {
    final savedMode = SP.getString(_viewModeKey);
    currentMode.value = ViewMode.fromString(savedMode);
  }

  Future<void> changeViewMode(ViewMode mode) async {
    currentMode.value = mode;
    await SP.setString(_viewModeKey, mode.name);
  }
}
