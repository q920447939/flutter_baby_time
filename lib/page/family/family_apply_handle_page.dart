import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:expandable_richtext/expandable_rich_text.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/getx/controller/manager_gex_controller.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../widget/dialog/cupertino_dialog.dart';
import '../../../widget/no_data.dart';
import '../../../widget/refresh/simple_easy_refresher.dart';
import '../../dao/family/family_dao.dart';
import '../../model/family/FamilyApplyRespVO.dart';
import '../../utils/family_helper.dart';
import '../../utils/family_member_role_helper.dart';
import '../../widget/base_stack/base_stack.dart';

/**
 * 家庭申请审核
 */
class FamilyApplyHandlePage extends StatefulWidget {
  const FamilyApplyHandlePage({super.key});

  @override
  State<FamilyApplyHandlePage> createState() => _FamilyApplyHandlePageState();
}

class _FamilyApplyHandlePageState extends State<FamilyApplyHandlePage>
    with SingleTickerProviderStateMixin {
  EasyRefreshController _controller = EasyRefreshController();
  ScrollController _scrollController = ScrollController();

  final int _DEFAULT_PAGE_NO = 1;
  late int pageNo = _DEFAULT_PAGE_NO;

  int size = 20;

  List<FamilyApplyRespVo> datas = [];

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );

    _refresh();
  }

  Future<void> _refresh() async {
    // 模拟刷新操作
    FamilyDao.applyPage(
      _DEFAULT_PAGE_NO,
      size,
      applyFamilyCode: familyLogic.get()!.familyCode!,
    ).then((result) {
      if (null != result && result.isNotEmpty) {
        setState(() {
          datas = result;
        });
      }
      _controller.finishRefresh();
    });
  }

  Future<void> _loadMore() async {
    // 模拟加载更多操作
    FamilyDao.applyPage(
      ++pageNo,
      size,
      applyFamilyCode: familyLogic.get()!.familyCode!,
    ).then((result) {
      if (null != result && result.isNotEmpty) {
        setState(() {
          datas = result;
        });
      }
      _controller.finishRefresh();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
        title: '家庭申请审核',
        child: SimpleEasyRefresher(
          easyRefreshController: _controller,
          onRefresh: _refresh,
          onLoad: _loadMore,
          childBuilder: (context, physics) {
            return datas.isEmpty
                ? const NoData()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      controller: _scrollController,
                      physics: physics,
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        var data = datas[index];
                        /*Color color = data.cashStatusDesc == '提现成功'
                            ? Colors.green
                            : Colors.black;*/
                        var appStatusDesc = '';
                        Color color = Colors.black;
                        if (data.applyStatus == 1) {
                          appStatusDesc = '申请中';
                          color = Colors.black;
                        } else if (data.applyStatus == 2) {
                          appStatusDesc = '申请成功';
                          color = Colors.green;
                        } else if (data.applyStatus == 3) {
                          appStatusDesc = '拒绝';
                          color = Colors.red;
                        } else if (data.applyStatus == 4) {
                          appStatusDesc = '申请人撤销';
                          color = Colors.grey;
                        }
                        var applyInfo = data.applyInfo;
                        return Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: ExpansionTileCard(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0.r)),
                            animateTrailing: false,
                            trailing: Text(
                              appStatusDesc,
                              style: TextStyle(color: color),
                            ),
                            leading: TDAvatar(
                              size: TDAvatarSize.medium,
                              type: TDAvatarType.normal,
                              shape: TDAvatarShape.circle,
                              avatarUrl: data.applyInfo!.avatar!,
                              //avatarUrl: memberLogic.get()!.avatar!,
                              backgroundColor: Colors.transparent,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  '申请人: ',
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                AutoSizeText(
                                  applyInfo!.memberNickName!,
                                  style: TextStyle(fontSize: 14.sp),
                                  maxLines: 1, // 设置最大行数
                                  overflow:
                                      TextOverflow.ellipsis, // 设置文本溢出时的处理方式
                                )
                              ],
                            ),
                            subtitle: Text(
                                '申请时间: ${DateUtil.formatDate(data.createTime!)}'),
                            children: <Widget>[
                              const Divider(
                                thickness: 1.0,
                                height: 1.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0.w,
                                    vertical: 8.0.h,
                                  ),
                                  child: _buildSubWidget(data),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
          },
        ));
  }

  void updateApplyStatus(String title) {}

  _buildSubWidget(FamilyApplyRespVo data) {
    if (data.applyStatus == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TDButton(
            size: TDButtonSize.medium,
            type: TDButtonType.fill,
            shape: TDButtonShape.rectangle,
            theme: TDButtonTheme.primary,
            text: '通过',
            onTap: () async {
              var b = await FamilyDao.updateApplyStatus(data.id!, 2);
              if (null != b && b) {
                dialogSuccess('处理成功');
                FamilyDao.get().then((res) async {
                  //查询新的 家庭信息,并进行绑定
                  var e = res!.where((e) {
                    return e.id == familyLogic.get()!.id;
                  }).first;
                  await bindFamily(e);
                  await FamilyMemberRoleHelper.setRole(e);
                });
                setState(() {});
                _refresh();
              }
            },
          ),
          TDButton(
            size: TDButtonSize.medium,
            type: TDButtonType.fill,
            shape: TDButtonShape.rectangle,
            theme: TDButtonTheme.primary,
            text: '拒绝',
            textStyle: TextStyle(color: Colors.red),
            onTap: () async {
              var b = await FamilyDao.updateApplyStatus(data.id!, 3);
              if (null != b && b) {
                dialogSuccess('拒绝成功');
                setState(() {});
                _refresh();
              }
            },
          ),
        ],
      );
    } else if (data.applyStatus == 2) {
      return TDText('通过时间:${DateUtil.formatDate(data.updateTime!)}');
    } else if (data.applyStatus == 3) {
      return TDText('拒绝时间:${DateUtil.formatDate(data.updateTime!)}');
    } else {
      return Container();
    }
  }
}
