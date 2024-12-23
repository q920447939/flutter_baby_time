import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../widget/no_data.dart';
import '../../../widget/refresh/simple_easy_refresher.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';

import '../../dao/family/family_dao.dart';
import '../../model/family/FamilyApplyRespVO.dart';

class FamilyApplyHistoryPage extends StatefulWidget {
  const FamilyApplyHistoryPage({super.key});

  @override
  State<FamilyApplyHistoryPage> createState() => _FamilyApplyHistoryPageState();
}

class _FamilyApplyHistoryPageState extends State<FamilyApplyHistoryPage> {
  late TabController _tabController;
  EasyRefreshController _controller = EasyRefreshController();
  ScrollController _scrollController = ScrollController();

  List tabs = ["申请中", "申请完成"];

  final int _DEFAULT_PAGE_NO = 1;
  late int pageNo = _DEFAULT_PAGE_NO;

  int size = 10;

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
    FamilyDao.applyPage(_DEFAULT_PAGE_NO, size).then((result) {
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
    FamilyDao.applyPage(++pageNo, size).then((result) {
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GreyBaseScaffoldStack(
      title: '申请历史',
      child: SimpleEasyRefresher(
        easyRefreshController: _controller,
        onRefresh: _refresh,
        onLoad: _loadMore,
        childBuilder: (context, physics) {
          return datas.isEmpty
              ? const NoData()
              : ListView.builder(
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  controller: _scrollController,
                  physics: physics,
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    var data = datas[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: ExpansionTileCard(
                        borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
                        animateTrailing: true,
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: SvgPicture.asset("/assets/svg/apply.svg"),
                        ),
                        title: TDText('申请家庭编号:${data.applyFamilyCode!}'),
                        subtitle: Text(DateUtil.formatDate(data.createTime!)),
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
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      '申请原因:${data.applyFamilyCode}',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: Text(
                                        '12312321',
                                      ),
                                    ),
                                  ],
                                ),
                                if (null != data.failReason)
                                  Text(
                                    '拒绝原因:${data.failReason}',
                                  ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
