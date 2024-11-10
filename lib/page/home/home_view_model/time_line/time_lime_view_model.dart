import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baby_time/page/home/home_view_model/time_line/time_line_refresh.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jiffy/jiffy.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../widget/easy_refresh/easy_refresh_wrapper.dart';
import '../../../../widget/gap/gap_height.dart';
import '../../../../widget/gap/gap_width.dart';
import '../../../my/baby_setting/baby_setting_controller.dart';

class TimeLimeViewModel extends StatefulWidget {
  double height;

  TimeLimeViewModel({super.key, this.height = 300});

  @override
  State<TimeLimeViewModel> createState() => _TimeLimeViewModelState();
}

class _TimeLimeViewModelState extends State<TimeLimeViewModel> {
  Map<String, TextEditingController> controllerMap = {};
  Map<String, Color?> _likeMapColor = {};
  Map<String, List<String>> discussMap = {};
  BabySettingController _babyController = Get.find();

  List<Jiffy> data = [];

  late Jiffy start;

  late int curYear;
  //构建时间线 ，为了降低性能开销 分批渲染数据
  @override
  void initState() {
    super.initState();
    start = Jiffy.parse('2023-1-3', pattern: 'yyyy-MM-dd');
    curYear = start.year;
    data = List.generate(10, (idx) => start = start.subtract(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: EasyRefreshWrapper<dynamic>(
        initLoad: (int pageNo, int pageSize) async {
          return Future.delayed(Duration(seconds: 2)).then((_) {
            var list = List.generate(10, (index) => 'initLoad $index');
            return Future.value(list);
          });
        },
        loadMore: (int pageNo, int pageSize) {
          return Future.delayed(Duration(seconds: 2)).then((_) {
            var list = List.generate(10, (index) => 'loadMore $index');
            return Future.value(list);
          });
        },
        listBuilder: (List<dynamic> list, ScrollPhysics physics) {
          return TimeLineRefresh<dynamic>(
              data: list, childItem: _buildItem, physics: physics);
        },
      ),
    );
  }

  Widget _buildItem(item, index) {
    var key = index.toString();
    TextEditingController controller;
    List<String> discussList = [];
    Color? colorIsLike;
    if (controllerMap.containsKey(key)) {
      controller = controllerMap[key]!;
      discussList = discussMap[key]!;
      colorIsLike = _likeMapColor[key];
    } else {
      controller = TextEditingController();
      controllerMap.putIfAbsent(key, () {
        return controller;
      });
      discussMap.putIfAbsent(key, () {
        return [];
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (index > 0) gapHeightLarge(),
        if (index == 0) _buildYear(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.podcasts,
              color: Colors.red,
              size: 16.w,
            ),
            gapWidthSmall(),
            TDText(
              '11月6日',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapWidthNormal(),
            Baseline(
              baseline: 18,
              baselineType: TextBaseline.alphabetic,
              child: TDText(
                '9个月15天',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
        gapHeightNormal(),
        ContainerWrapperCard(
          width: 350.w,
          height: 360.h,
          child: GridView.builder(
            //取消滚动
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _buildCrossAxis(data.length),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: data.length > 9 ? 9 : data.length,
            itemBuilder: (context, index) {
              Widget widget;
              if (index < 8) {
                widget = TDImage(
                  assetUrl: 'assets/img/baby_photo.jpg',
                );
              } else {
                widget = Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    const TDImage(
                      assetUrl: 'assets/img/baby_photo.jpg',
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: TDText(
                        '+16',
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                );
              }

              return GestureDetector(
                onTap: () {
                  TDImageViewer.showImageViewer(
                    defaultIndex: index,
                    context: context,
                    images: List.generate(
                      10,
                      (idx) {
                        return 'assets/img/baby_photo.jpg';
                      },
                    ),
                  );
                },
                child: widget,
              );
            },
          ),
        ),
        gapHeightSmall(),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: _buildTag(),
        ),
        gapHeightSmall(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  colorIsLike = (colorIsLike == Colors.amberAccent)
                      ? null
                      : Colors.amberAccent;

                  _likeMapColor[key] = colorIsLike;
                });
                dialogSuccess(
                    colorIsLike == Colors.amberAccent ? "收藏成功" : "取消收藏");
              },
              child: SvgPicture.asset(
                "assets/svg/like.svg",
                width: 22.w,
                color: colorIsLike,
              ),
            ),
            gapWidthLarge(),
            GestureDetector(
              onTap: () async {
                var result = await SmartDialog.show(
                    tag: "discuss",
                    builder: (_) {
                      return ContainerWrapperCard(
                        width: 350.w,
                        height: 200.h,
                        margin: EdgeInsets.only(bottom: 60.h),
                        child: Column(
                          children: [
                            Container(
                              height: 100.h,
                              child: TDInput(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: Colors.black12),
                                  color: Colors.black,
                                ),
                                type: TDInputType.cardStyle,
                                leftLabel: '',
                                controller: controller,
                                hintText: '请输入评论',
                                maxLength: 100,
                                additionInfo: '最大输入100个字符',
                                onChanged: (text) {},
                                onClearTap: () {
                                  controller.clear();
                                },
                              ),
                            ),
                            gapHeightNormal(),
                            TDButton(
                              text: '确认',
                              size: TDButtonSize.medium,
                              type: TDButtonType.fill,
                              shape: TDButtonShape.rectangle,
                              theme: TDButtonTheme.primary,
                              onTap: () {
                                SmartDialog.dismiss(
                                    tag: "discuss",
                                    force: true,
                                    result: controller.value.text);
                              },
                            ),
                          ],
                        ),
                      );
                    });
                if (result != null && result != "") {
                  dialogSuccess('提交成功');
                  setState(() {
                    discussList.add(result);
                    //重新调一下请求
                  });
                }
              },
              child: SvgPicture.asset(
                "assets/svg/discuss.svg",
                width: 22.w,
              ),
            ),
            gapWidthLarge(),
            GestureDetector(
              onTap: () {
                // 接上面滚动生成的文件，直接调用分享即可
                try {
                  Share.shareUri(
                    Uri.parse("http://www.baidu.com"),
                  );
                } on PlatformException catch (e) {
                  // 捕获并处理平台异常
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('分享时发生错误：${e.message}')),
                  );
                }
              },
              child: SvgPicture.asset(
                "assets/svg/share.svg",
                width: 22.w,
              ),
            ),
            gapWidthLarge(),
          ],
        ),
        gapWidthSmall(),
        if (discussList.isNotEmpty)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildDiscuss(discussList),
          ),
      ],
    );
  }

  List<Widget> _buildTag() {
    return List.generate(10, (idx) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 150.w, minWidth: 80.w),
        child: TDTag(
          '一周年纪念',
          isOutline: true,
          needCloseIcon: false,
          theme: TDTagTheme.primary,
        ),
      );
    });
  }

  @override
  void dispose() {
    // 逐个调用每个 TextEditingController 的 dispose 方法
    for (var controller in controllerMap.values) {
      controller.dispose();
    }
    // 清空 Map
    controllerMap.clear();

    _likeMapColor = {};
    discussMap = {};
    super.dispose();
  }

  _buildCrossAxis(int length) {
    if (length < 3) {
      return 1;
    }
    if (length <= 6) {
      return 2;
    } else {
      return 3;
    }
  }

  _buildDiscuss(List<String> discussList) {
    var list = discussList
        .map(
          (discuss) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              gapWidthLarge(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30.w,
                        child: TDAvatar(
                          size: TDAvatarSize.medium,
                          type: TDAvatarType.normal,
                          shape: TDAvatarShape.circle,
                          defaultUrl: 'assets/img/baby_avator.jpeg',
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      gapWidthSmall(),
                      Baseline(
                        baseline: 25,
                        baselineType: TextBaseline.alphabetic,
                        child: TDText(
                          _babyController.babyName.value,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TDText(
                    '2024年10月2日',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              gapWidthNormal(),
              Padding(
                padding: EdgeInsets.only(left: 35.w),
                child: TDText(
                  discuss,
                  style: TextStyle(fontSize: 14.sp),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        )
        .toList();
    return list;
  }

  _buildYear() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TDText(
          '2023年',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
