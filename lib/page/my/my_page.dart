import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/config/go_router_config.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/gap/gap_width.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/base/member/member_dao.dart';
import '../../dao/family/family_dao.dart';
import '../../design_pattern/view_model/ViewModel.dart';
import '../../getx/controller/manager_gex_controller.dart';
import '../../handle/token_manager/token_manager.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import '../../router/has_bottom_navigator/shell_default_router.dart';
import '../../router/not_bottom_navigator/no_shell_default_router.dart';
import '../../utils/baby_helper.dart';
import '../../utils/family_helper.dart';
import '../../utils/family_member_role_helper.dart';
import '../../widget/image_pick/ImagePickerType.dart';
import '../baby_info/baby_info_create_page.dart';
import '../family/family_manger/family_manager_member_page.dart';
import '../home/view_model_controller.dart';
import '../../getx/controller/baby/baby_setting_controller.dart';
import 'global_setting/global_setting_controller.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ViewModeController _viewModeController = Get.find();
  GlobalSettingController _globalSettingController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '个人中心',
      showBackIcon: false,
      appBarSize: 0,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          gapHeightLarge(),
          SizedBox(
            width: 560.w,
            height: 150.h,
            child: CachedNetworkImage(
              imageUrl: familyLogic.familyRespVo.value!.familyBackgroundUrl!,
              fit: BoxFit.cover,
            ),
          ),
          gapHeightNormal(),
          _buildPersonInfo(),
          gapHeightSmall(),
          _buildPersonAvatar(),
          gapHeightSmall(),
          _buildFamilySelect(),
          gapHeightSmall(),
          _buildAdminPremissionHandle(),
          _buildLogout(),
        ],
      ),
    );
  }

  GestureDetector _buildGlobalBackgroundImage() {
    return GestureDetector(
      onTap: () {
        SmartDialog.showToast('功能开发中');
      },
      child: ContainerWrapperCard(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TDText(
                '背景',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => TDText(
                      '' == _globalSettingController.globalBackgroundImage.value
                          ? '系统默认背景'
                          : '自定义')),
                  gapWidthSmall(),
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ],
          )),
    );
  }

  ContainerWrapperCard homeViewModel(BuildContext context) {
    return ContainerWrapperCard(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TDText('首页预览模式'),
          GestureDetector(
            onTap: () async {
              await _changeReadModel();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() {
                  return TDText(
                    _viewModeController.currentMode.value.label,
                  );
                }),
                gapWidthSmall(),
                Icon(
                  Icons.arrow_right_outlined,
                  size: 18.w,
                  color: TDTheme.of(context).brandNormalColor,
                ),
                gapWidthSmall(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _changeReadModel() async {
    var result = await SmartDialog.show(
        tag: "_changeReadModel",
        builder: (c) {
          return ContainerWrapperCard(
            width: 200.w,
            height: 110.h,
            child: Center(
              child: _radioStatus(context),
            ),
          );
        });
    print("result is $result");
  }

  Widget _radioStatus(BuildContext context) {
    return TDRadioGroup(
      contentDirection: TDContentDirection.right,
      selectId: _viewModeController.currentMode.value.value,
      onRadioGroupChange: (selectedId) {
        _viewModeController.changeViewMode(ViewMode.fromString(selectedId));
        SmartDialog.dismiss(
            tag: "_changeReadModel", force: true, result: selectedId);
      },
      child: Column(
        children: _buildViewModelTDRadio(),
      ),
    );
  }

  List<Widget> _buildViewModelTDRadio() {
    return ViewMode.values.map((mode) {
      return TDRadio(
        id: mode.value,
        title: mode.label,
        radioStyle: TDRadioStyle.circle,
      );
    }).toList();
  }

  _babySetting() {
    return _buildRowInfo('宝宝资料', () {
      const BabySettingRoute().push(context);
    });
  }

  _buildTag() {
    return _buildRowInfo('标签管理', () {
      const TagSettingRoute().push(context);
    });
  }

  _buildPersonInfo() {
    return _buildRowInfo(
      '昵称',
      () {
        const MyProfileRoute().push(context);
      },
      rightWidget: Obx(
        () => TDText(
            null == memberLogic.get() ? '' : memberLogic.get()!.memberNickName),
      ),
    );
  }

  _buildPersonAvatar() {
    return _buildRowInfo(
      '头像',
      () async {
        var list = await ImagePickerHelper.pickAndUploadImages(
            type: ImagePickerType.gallery);
        if (list.isNotEmpty) {
          var b = await MemberDao.updateAvatar(list.first);
          if (b) {
            await dialogSuccess('更换头像成功');
          }
        }
      },
      rightWidget: Obx(
        () => SizedBox(
          width: 30.w,
          child: null == memberLogic.get()
              ? Container()
              : CachedNetworkImage(
                  imageUrl: memberLogic.get()!.avatar!,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }

  _buildRowInfo(String leftText, GestureTapCallback onTap,
      {Widget? rightWidget}) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: ContainerWrapperCard(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TDText(
                leftText,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (rightWidget != null) rightWidget,
                  Icon(Icons.arrow_right_outlined),
                ],
              ),
            ],
          )),
    );
  }

  _buildLogout() {
    return _buildRowInfo('退出登录', () async {
      var res = await SmartDialog.show(builder: (_) {
        return TDAlertDialog(
          content: '确定要退出登录吗?',
          leftBtnAction: () {
            SmartDialog.dismiss(result: false);
          },
          rightBtnAction: () {
            SmartDialog.dismiss(result: true);
          },
        );
      });
      if (res == true) {
        await loginOut();
        await dialogSuccess('退出登录成功', onDismiss: () {
          if (context.mounted) {
            SignInScreenRouter().replace(context);
          }
        });
      }
    });
  }

  _buildFamilySelect() {
    return _buildRowInfo('重新选择家庭', () async {
      var res = await SmartDialog.show(builder: (_) {
        return TDAlertDialog(
          content: '确定要重新选择家庭吗?',
          leftBtnAction: () {
            SmartDialog.dismiss(result: false);
          },
          rightBtnAction: () {
            SmartDialog.dismiss(result: true);
          },
        );
      });
      if (res == true) {
        await unbindFamily();
        await unbindBaby();
        await dialogSuccess('退出当前家庭成功', onDismiss: () async {
          if (context.mounted) {
            FamilyManagerPageRouter().replace(context);
          }
        });
      }
    },
        rightWidget: Obx(() => null == familyLogic.familyRespVo.value
            ? TDText('')
            : TDText(familyLogic.familyRespVo.value!.familyName)));
  }

  _buildAddBaby() {
    return _buildRowInfo('新增宝宝资料', () async {
      BabyInfoCreatePageRouter().push(context);
    });
  }

  _buildFamilyApplyHandle() {
    return _buildRowInfo('家庭申请审核', () async {
      FamilyApplyHandlePageRoute().push(context);
    });
  }

  _buildAdminPremissionHandle() {
    if (!FamilyMemberRoleHelper.familyMemberRoleHasAdmin()) {
      return Container();
    }
    return Column(
      children: [
        _babySetting(),
        gapHeightSmall(),
        _buildTag(),
        gapHeightSmall(),
        _buildAddBaby(),
        gapHeightSmall(),
        _buildFamilyApplyHandle(),
        gapHeightSmall(),
        _buildFamilyMemberManager(),
        gapHeightSmall(),
      ],
    );
  }

  _buildFamilyMemberManager() {
    return _buildRowInfo('家庭成员管理', () async {
      FamilyManagerMemberPageRoute().push(context);
    });
  }
}
