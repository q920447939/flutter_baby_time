import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../dao/family/family_dao.dart';
import '../../../getx/controller/manager_gex_controller.dart';
import '../../../model/family/FamilyRelationRespVO.dart';
import '../../../utils/family_member_role_helper.dart';
import '../../../widget/custom_safe_area/CustomSafeArea.dart';
import '../../../widget/future/future_.dart';
import '../../../widget/gap/gap_height.dart';

class FamilyManagerMemberPage extends StatefulWidget {
  const FamilyManagerMemberPage({super.key});

  @override
  State<FamilyManagerMemberPage> createState() =>
      _FamilyManagerMemberPageState();
}

class _FamilyManagerMemberPageState extends State<FamilyManagerMemberPage> {
  Future<List<FamilyRelationRespVo>?> fetch() {
    return FamilyDao.familyManager();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.grey.withOpacity(0.5),
        ),
        CustomerSafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: ContainerWrapperCard(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white, // 添加背景色
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0.r),
                  ),
                ),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                      title: Center(
                        child: TDText('家庭成员'),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                      )),
                  body: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      child: FutureLoading(
                          future: fetch(),
                          builder: (_, list) {
                            return ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: _buildContent(list),
                            );
                          })),
                )),
          ),
        )
      ],
    );
  }

  _buildContent(List<FamilyRelationRespVo>? list) {
    if (null == list || list.isEmpty) {
      return Container();
    }
    var resultList = list.map((e) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 50.w,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(
                    e.memberSimpleMoreResVo!.avatar!,
                  ),
                  radius: 20.w,
                ),
              ),
            ),
            gapHeightNormal(),
            Padding(
              padding: EdgeInsets.only(
                left: 5.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TDText(
                    e.memberSimpleMoreResVo!.memberNickName!,
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  TDText(
                    '权限:${e.roleName!}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            if (memberLogic.get()!.id! != e.memberSimpleMoreResVo!.id!)
              TDButton(
                text: '操作',
                size: TDButtonSize.small,
                type: TDButtonType.text,
                shape: TDButtonShape.round,
                onTap: () {
                  Navigator.of(context).push(
                    TDSlidePopupRoute(
                        modalBarrierColor: TDTheme.of(context).fontGyColor2,
                        slideTransitionFrom: SlideTransitionFrom.bottom,
                        builder: (context1) {
                          return TDPopupBottomDisplayPanel(
                            title: '操作',
                            hideClose: false,
                            closeClick: () {
                              Navigator.maybePop(context1);
                            },
                            child: Container(
                              height: 150.w,
                              margin: EdgeInsets.only(top: 20.h),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildOptionItem(
                                      '移出家庭',
                                      () async {
                                        var res = await SmartDialog.show(
                                            builder: (_) {
                                          return TDAlertDialog(
                                            content: '确定将该用户移出家庭吗?',
                                            leftBtnAction: () {
                                              SmartDialog.dismiss(
                                                  result: false);
                                            },
                                            rightBtnAction: () {
                                              SmartDialog.dismiss(result: true);
                                            },
                                          );
                                        });
                                        if (null != res && res) {
                                          await FamilyDao.removeFamilyMember(
                                              e.memberSimpleMoreResVo!.id!);
                                          if (context1.mounted) {
                                            Navigator.maybePop(context1);
                                            setState(() {});
                                          }
                                        }
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1),
                                      child: _buildOptionItem(
                                        '设置用户角色',
                                        () async {
                                          await SmartDialog.show(
                                              tag: "_changeRadio",
                                              builder: (c) {
                                                return ContainerWrapperCard(
                                                  width: 200.w,
                                                  height: 110.h,
                                                  child: Center(
                                                    child: _radioStatus(
                                                        context1, e),
                                                  ),
                                                );
                                              });
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
          ],
        ),
      );
    }).toList();
    return resultList;
  }

  Widget _buildOptionItem(String title, VoidCallback onTap) {
    return GestureDetector(
      child: _itemCreate(title),
      onTap: onTap,
    );
  }

  Widget _itemCreate(String title) {
    return Container(
      color: Colors.white,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _radioStatus(
      BuildContext context, FamilyRelationRespVo familyRelationRespVo) {
    return TDRadioGroup(
      contentDirection: TDContentDirection.right,
      selectId: familyRelationRespVo.roleId.toString(),
      onRadioGroupChange: (roleId) async {
        await FamilyDao.setFamilyMemberRole(
            familyRelationRespVo.memberSimpleMoreResVo!.id!,
            int.parse(roleId!));
        SmartDialog.dismiss(tag: "_changeRadio", force: true);
        if (context.mounted) {
          Navigator.maybePop(context);
        }
      },
      child: Column(
        children: _buildRadio(),
      ),
    );
  }

  List<Widget> _buildRadio() {
    return RoleEnums.values.map((mode) {
      return TDRadio(
        id: '${mode.id}',
        title: mode.label,
        radioStyle: TDRadioStyle.circle,
      );
    }).toList();
  }
}
