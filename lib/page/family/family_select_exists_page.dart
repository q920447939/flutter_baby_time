import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/no_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/family/family_dao.dart';
import '../../getx/controller/manager_gex_controller.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import '../../utils/family_helper.dart';
import '../../utils/family_member_role_helper.dart';
import '../../widget/button/default_button.dart';
import '../../widget/container/container_wrapper_card.dart';
import '../../widget/future/future_.dart';
import '../../widget/gap/gap_height.dart';

class FamilySelectExistsPage extends StatefulWidget {
  FamilySelectExistsPage({super.key});

  @override
  State<FamilySelectExistsPage> createState() => _FamilySelectExistsPageState();
}

class _FamilySelectExistsPageState extends State<FamilySelectExistsPage> {
  Future<List<FamilyRespVo>?> fetch() async {
    return await FamilyDao.get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureLoading(
      future: fetch(),
      builder: (c, List<FamilyRespVo>? data) {
        if ((data ?? []).isEmpty) {
          return NoData();
        }
        return GreyBaseScaffoldStack(
          title: '选择家庭',
          showBackIcon: false,
          child: ContainerWrapperCard(
              padding: EdgeInsets.all(
                10.w,
              ),
              width: 400.w,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _buildExistsFamily(data!),
              )),
        );
      },
    );
  }

  List<Widget> _buildExistsFamily(List<FamilyRespVo> data) {
    return data.map((e) {
      return buildFamilyItem(e);
    }).toList();
  }

  ContainerWrapperCard buildFamilyItem(FamilyRespVo e) {
    return ContainerWrapperCard(
      padding: EdgeInsets.all(10.r),
      height: 172.h,
      width: 400.w,
      decoration: BoxDecoration(
        //color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
        image: DecorationImage(
          image: CachedNetworkImageProvider(e.familyBackgroundUrl!),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.2),
            BlendMode.modulate,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TDText(
            e.familyName!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          gapHeightSmall(),
          TDText(
            '您的角色:${e.roleName!}',
          ),
          gapHeightNormal(),
          DefaultButton(
            title: '进入家庭',
            onPressed: () async {
              var res = await SmartDialog.show(builder: (_) {
                return TDAlertDialog(
                  content: '确定选择[${e.familyName!}]家庭吗?',
                  leftBtnAction: () {
                    SmartDialog.dismiss(result: false);
                  },
                  rightBtnAction: () {
                    SmartDialog.dismiss(result: true);
                  },
                );
              });
              if (res) {
                await bindFamily(e);
                await FamilyMemberRoleHelper.setRole(e);
                if (mounted) {
                  context.go("/");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
