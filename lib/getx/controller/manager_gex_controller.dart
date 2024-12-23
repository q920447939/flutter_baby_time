import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../page/my/baby_setting/baby_setting_controller.dart';
import 'family/family_logic.dart';
import 'member/member_logic.dart';

final MemberLogic memberLogic = Get.put(MemberLogic());
final BabySettingController babyController = Get.find();
final FamilyLogic familyLogic = Get.put(FamilyLogic());
