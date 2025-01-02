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

import '../../dao/baby/baby_dao.dart';
import '../../dao/family/family_dao.dart';
import '../../getx/controller/manager_gex_controller.dart';
import '../../model/baby/BabyInfoRespVO.dart';
import '../../utils/baby_helper.dart';
import '../../utils/datime_helper.dart';
import '../../utils/family_helper.dart';
import '../../widget/button/default_button.dart';
import '../../widget/container/container_wrapper_card.dart';
import '../../widget/future/future_.dart';
import '../../widget/gap/gap_height.dart';

class BabySelectExistsPage extends StatefulWidget {
  BabySelectExistsPage({super.key});

  @override
  State<BabySelectExistsPage> createState() => _BabySelectExistsPageState();
}

class _BabySelectExistsPageState extends State<BabySelectExistsPage> {
  Future<List<BabyInfoRespVo>?> fetch() async {
    return await BabyDao.fetchAllBaby();
  }

  @override
  Widget build(BuildContext context) {
    return FutureLoading(
      future: fetch(),
      builder: (c, List<BabyInfoRespVo>? data) {
        if ((data ?? []).isEmpty) {
          return NoData();
        }
        return GreyBaseScaffoldStack(
          title: '选择宝宝',
          showBackIcon: false,
          child: ContainerWrapperCard(
              padding: EdgeInsets.all(
                10.w,
              ),
              width: 400.w,
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: _buildExistsBaby(data!),
              )),
        );
      },
    );
  }

  List<Widget> _buildExistsBaby(List<BabyInfoRespVo> data) {
    return data.map((e) {
      return buildItem(e);
    }).toList();
  }

  ContainerWrapperCard buildItem(BabyInfoRespVo e) {
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
          image: CachedNetworkImageProvider(e.avatarUrl!),
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
            e.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
            ),
          ),
          gapHeightSmall(),
          TDText(
            '创建时间:${formatDate(e.createTime!)}',
          ),
          gapHeightNormal(),
          DefaultButton(
            title: '选择宝宝',
            onPressed: () async {
              var res = await SmartDialog.show(builder: (_) {
                return TDAlertDialog(
                  content: '确定选择[${e.name!}]宝宝吗?',
                  leftBtnAction: () {
                    SmartDialog.dismiss(result: false);
                  },
                  rightBtnAction: () {
                    SmartDialog.dismiss(result: true);
                  },
                );
              });
              if (res) {
                await bindBaby(e);
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
