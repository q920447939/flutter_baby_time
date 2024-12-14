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

import '../../../../dao/baby/baby_dao.dart';
import '../../../../dao/upload_list/upload_list_dao.dart';
import '../../../../getx/controller/manager_gex_controller.dart';
import '../../../../model/uploadList/UploadListRespVO.dart';
import '../../../../utils/calculate_age_helper.dart';
import '../../../../utils/datime_helper.dart';
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
  Map<String, List<UploadDiscussRespVo>> discussMap = {};
  BabySettingController _babyController = Get.find();

  int? curYear;
  List<UploadListRespVo> uploadList = [];

  final int _DEFAULT_PAGE_NO = 1;
  late int pageNo = _DEFAULT_PAGE_NO;

  int size = 10;

  //构建时间线 ，为了降低性能开销 分批渲染数据
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> fetchUploadListInit() async {
    pageNo = _DEFAULT_PAGE_NO;
    uploadList = await BabyDao.fetchUploadList(pageNo, size, 1) ?? [];
    return uploadList;
  }

  Future<List<dynamic>> fetchUploadList(int pageNo, int babyId) async {
    uploadList = await BabyDao.fetchUploadList(pageNo, size, babyId) ?? [];
    return uploadList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: EasyRefreshWrapper<dynamic>(
        initLoad: (int pageNo, int pageSize) async {
          return fetchUploadListInit();
        },
        loadMore: (int pageNo, int pageSize) {
          return fetchUploadList(++pageNo, 1);
        },
        listBuilder: (List<dynamic> list, ScrollPhysics physics) {
          return TimeLineRefresh<dynamic>(
              data: list, childItem: _buildItem, physics: physics);
        },
      ),
    );
  }

  Widget _buildItem(item, index) {
    UploadListRespVo uploadInfo = item as UploadListRespVo;
    var key = index.toString();

    int len =
        uploadInfo.uploadType! == 1 ? uploadInfo.uploadImageRespVo.length : 1;
    TextEditingController controller;
    List<UploadDiscussRespVo> discussList = [];
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
      discussList = uploadInfo.uploadDiscussRespVo;
      discussMap.putIfAbsent(key, () {
        return uploadInfo.uploadDiscussRespVo;
      });
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (index > 0) gapHeightLarge(),
        if (index == 0 || uploadInfo.uploadTime!.year != curYear)
          _buildYear(uploadInfo.uploadTime!.year),
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
              '${uploadInfo.uploadTime!.month}月${uploadInfo.uploadTime!.day}日',
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
                '${calculateAge(Jiffy.parse(_babyController.birthday.value, pattern: 'yyyy-MM-dd'))}',
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
          height: len > 6 ? 360.h : (len > 3 ? 250.h : 180.h),
          child: GridView.builder(
            //取消滚动
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: len > 9 ? 9 : len,
            itemBuilder: (context, index) {
              Widget widget;
              if (index < 8) {
                widget = TDImage(
                  imgUrl: uploadInfo.uploadImageRespVo[index].imageUrl!,
                );
              } else {
                widget = Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    TDImage(
                      imgUrl: uploadInfo.uploadImageRespVo[index].imageUrl!,
                    ),
                    Center(
                      child: TDText(
                        '+${len - 9}',
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
              var imageUrls =
                  uploadInfo.uploadImageRespVo.map((e) => e.imageUrl!).toList();
              return GestureDetector(
                onTap: () {
                  TDImageViewer.showImageViewer(
                    defaultIndex: index > 8 ? 8 : index,
                    context: context,
                    images: imageUrls,
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
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TDText(
              uploadInfo.memberSimpleResVo!.memberNickName,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ),
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
                  var b = await UploadListDao.discuss({
                    "babyId": _babyController.babyId.value,
                    "uploadId": uploadInfo.id,
                    "content": result as String
                  });
                  if (b) {
                    await dialogSuccess('提交成功',
                        displayTime: const Duration(seconds: 1));
                    setState(() {
                      var curMemberId = memberLogic.memberInfo.value!.id!;
                      discussList.add(UploadDiscussRespVo.fromJson({
                        "id": -1,
                        "babyId": _babyController.babyId.value,
                        "discussMemberId": curMemberId,
                        "uploadId": curMemberId,
                        "content": result,
                        "createTime": formatDateTime(DateTime.now()),
                        "memberSimpleResVO": {
                          "memberCode":
                              memberLogic.memberInfo.value!.memberCode,
                          "memberNickName":
                              memberLogic.memberInfo.value!.memberNickName,
                          "avatar": memberLogic.memberInfo.value!.avatar
                        }
                      }));
                      discussMap[key] = discussList;
                      //重新调一下请求
                      //友好的用户体验,直接加到 discussList,让用户先看到
                    });
                  }
                }
                controller.clear();
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
    if (length <= 3) {
      return 1;
    }
    if (length <= 6) {
      return 2;
    } else {
      return 3;
    }
  }

  _buildDiscuss(List<UploadDiscussRespVo> discussList) {
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
                          avatarUrl: discuss.memberSimpleResVo!.avatar!,
                          size: TDAvatarSize.medium,
                          type: TDAvatarType.normal,
                          shape: TDAvatarShape.circle,
                          //defaultUrl: 'assets/img/baby_avator.jpeg',
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      gapWidthSmall(),
                      Baseline(
                        baseline: 25,
                        baselineType: TextBaseline.alphabetic,
                        child: TDText(
                          discuss.memberSimpleResVo!.memberNickName,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TDText(
                    '${Jiffy.parseFromDateTime(discuss.createTime!).format(pattern: 'yyyy年MM月dd日')}',
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
                  discuss.content!,
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

  _buildYear(newYear) {
    curYear = newYear;
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TDText(
          '$curYear年',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
