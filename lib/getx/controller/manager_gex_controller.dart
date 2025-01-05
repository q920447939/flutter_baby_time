import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'baby/baby_setting_controller.dart';
import 'base/bottom_bar_index/bottom_bar_index_logic.dart';
import 'family/family_logic.dart';
import 'member/member_logic.dart';

final MemberLogic memberLogic = Get.put(MemberLogic());
final BabySettingController babyController = Get.find();
final FamilyLogic familyLogic = Get.put(FamilyLogic());
final BottomBarIndexLogic bottomBarIndexLogic = Get.put(BottomBarIndexLogic());
