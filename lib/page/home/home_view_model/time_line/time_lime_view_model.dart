import 'package:animate_do/animate_do.dart';
import 'package:expandable_richtext/expandable_rich_text.dart';
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
import '../../../../model/baby/BabyUploadTagRespVO.dart' as tag;
import '../../../../model/uploadList/UploadListRespVO.dart';
import '../../../../utils/calculate_age_helper.dart';
import '../../../../utils/datime_helper.dart';
import '../../../../widget/easy_refresh/easy_refresh_wrapper.dart';
import '../../../../widget/future/future_.dart';
import '../../../../widget/gap/gap_height.dart';
import '../../../../widget/gap/gap_width.dart';
import '../../../../getx/controller/baby/baby_setting_controller.dart';

class TimeLimeViewModel extends StatefulWidget {
  double height;
  bool queryCollect;
  bool isCollect;
  TimeLimeViewModel(
      {super.key,
      this.height = 300,
      this.queryCollect = false,
      this.isCollect = false});

  @override
  State<TimeLimeViewModel> createState() => _TimeLimeViewModelState();
}

class _TimeLimeViewModelState extends State<TimeLimeViewModel>
    with SingleTickerProviderStateMixin {
  Map<String, TextEditingController> controllerMap = {};
  Map<String, Color?> _likeMapColor = {};
  Map<String, List<UploadDiscussRespVo>> discussMap = {};
  Map<String, List<BabyUploadTagRespVo>> uploadListTagMap = {};
  BabySettingController _babyController = Get.find();

  int? curYear;
  List<UploadListRespVo> uploadList = [];

  final int _DEFAULT_PAGE_NO = 1;
  late int pageNo = _DEFAULT_PAGE_NO;

  int size = 10;

  AnimationController? animationController;

  int maxTag = 3;

  //构建时间线 ，为了降低性能开销 分批渲染数据
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> fetchUploadListInit() async {
    pageNo = _DEFAULT_PAGE_NO;
    uploadList = await BabyDao.fetchUploadList(
            pageNo, size, widget.queryCollect, widget.isCollect) ??
        [];
    return uploadList;
  }

  Future<List<dynamic>> fetchUploadList(int pageNo, int babyId) async {
    uploadList = await BabyDao.fetchUploadList(
            pageNo, size, widget.queryCollect, widget.isCollect) ??
        [];
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
    List<BabyUploadTagRespVo> uploadListTag = [];

    if (controllerMap.containsKey(key)) {
      controller = controllerMap[key]!;
      discussList = discussMap[key]!;
      colorIsLike = _likeMapColor[key];
      uploadListTag = uploadListTagMap[key]!;
    } else {
      controller = TextEditingController();
      controllerMap.putIfAbsent(key, () {
        return controller;
      });
      discussList = uploadInfo.uploadDiscussRespVo;
      discussMap.putIfAbsent(key, () {
        return uploadInfo.uploadDiscussRespVo;
      });
      _likeMapColor.putIfAbsent(key, () {
        return Colors.amberAccent;
      });
      if (uploadInfo.babyUploadTagRespVos.isNotEmpty) {
        uploadListTag = uploadInfo.babyUploadTagRespVos;
      }
      uploadListTagMap.putIfAbsent(key, () {
        return uploadListTag;
      });
      if (null != uploadInfo.isCollect) {
        //使用后台的逻辑
        colorIsLike = uploadInfo.isCollect! ? Colors.amberAccent : null;
      } else {
        //使用默认的逻辑
        if (widget.queryCollect) {
          if (widget.isCollect) {
            colorIsLike = Colors.amberAccent;
          } else {
            colorIsLike = null;
          }
        } else {
          colorIsLike = null;
        }
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                '${calculateAge(Jiffy.parse(formatDate(babyController.get()!.birthday!), pattern: 'yyyy-MM-dd'))}',
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
          height: len > 6 ? 360.h : (len > 3 ? 250.h : 120.h),
          child: GridView.builder(
            //取消滚动
            //physics: const NeverScrollableScrollPhysics(),
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
        if (null != uploadInfo.remark && uploadInfo.remark!.isNotEmpty)
          ExpandableRichText(uploadInfo.remark!,
              expandText: '查看更多',
              collapseText: '收起',
              maxLines: 3,
              toggleTextStyle: TextStyle(
                color: Colors.blue,
              )
              //linkColor: Colors.blue,
              ),
        gapHeightSmall(),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: _buildTag(key, uploadInfo),
        ),
        gapHeightSmall(),
        Align(
          alignment: Alignment.centerLeft,
          child: TDText(
            uploadInfo.memberSimpleResVo!.memberNickName,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                var b = await UploadListDao.markLikeOrCancel(
                    uploadInfo.id!, (colorIsLike != Colors.amberAccent));
                if (b) {
                  setState(() {
                    colorIsLike = (colorIsLike == Colors.amberAccent)
                        ? null
                        : Colors.amberAccent;

                    _likeMapColor[key] = colorIsLike;
                  });
                  dialogSuccess(
                      colorIsLike == Colors.amberAccent ? "收藏成功" : "取消收藏");
                }
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
                    "babyId": babyController.get()!.id!,
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
                        "babyId": babyController.get()!.id!,
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
/*            GestureDetector(
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
            gapWidthLarge(),*/
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

  List<Widget> _buildTag(String key, UploadListRespVo uploadInfo) {
    var tagList = uploadListTagMap[key];
    var tag = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 150.w, minWidth: 80.w),
      child: BounceInRight(
        duration: const Duration(milliseconds: 3000),
        controller: (c) {
          animationController = c;
          animationController!.forward();
        },
        child: GestureDetector(
          onTap: () async {
            var uploadListTagList = uploadListTagMap[key];
            if (null != uploadListTagList &&
                uploadListTagList.length >= maxTag) {
              dialogFailure('最多添加$maxTag个标签');
              return;
            }
            var babyUploadTagRespVO1 = await SmartDialog.show(
              tag: "radioTag",
              builder: (context) {
                return Center(
                  child: ContainerWrapperCard(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 400.h,
                    child: Column(
                      children: [
                        _horizontalRadios(context),
                        gapHeightNormal(),
                        _buildBody(key),
                      ],
                    ),
                  ),
                );
              },
            );
            if (null != babyUploadTagRespVO1) {
              // babyUploadTagRespVO1 = tag.BabyUploadTagRespVo
              setState(() {
                var uploadListTagList = uploadListTagMap[key];
                uploadListTagMap[key] = [
                  ...uploadListTagList!,
                  BabyUploadTagRespVo(
                      id: babyUploadTagRespVO1.id,
                      tagName: babyUploadTagRespVO1.tagName)
                ];
              });
              UploadListDao.relationTag(
                  uploadInfo.id!, babyUploadTagRespVO1.id);
              await dialogSuccess('添加标签成功');
            }
          },
          child: TDTag(
            '添加/选择标签',
            isOutline: true,
            needCloseIcon: false,
            theme: TDTagTheme.success,
          ),
        ),
      ),
    );

    if (tagList?.isNotEmpty ?? false) {
      var list = List.generate(tagList!.length, (idx) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 150.w, minWidth: 80.w),
          child: TDTag(
            tagList[idx].tagName!,
            isOutline: true,
            needCloseIcon: true,
            theme: TDTagTheme.primary,
            onCloseTap: () async {
              var removeBabyUploadTagResp =
                  await SmartDialog.show(builder: (_) {
                return TDAlertDialog(
                  content: '确定删除${tagList[idx].tagName!}标签吗?',
                  leftBtnAction: () {
                    SmartDialog.dismiss(result: false);
                  },
                  rightBtnAction: () {
                    SmartDialog.dismiss(result: tagList[idx]);
                  },
                );
              });
              if (null != removeBabyUploadTagResp) {
                var uploadListTagList = uploadListTagMap[key];
                var b = await UploadListDao.uploadListCancelTag(
                    uploadInfo.id!, removeBabyUploadTagResp.id);
                if (b) {
                  setState(() {
                    var list = uploadListTagList!
                        .where((e) => e.id! != removeBabyUploadTagResp.id)
                        .toList();
                    uploadListTagMap[key] = list;
                  });
                  await dialogSuccess(
                    '取消关联标签成功',
                    displayTime: const Duration(seconds: 3),
                  );
                } else {
                  await dialogFailure(
                    '取消关联标签失败',
                    displayTime: const Duration(seconds: 3),
                  );
                }
              }
            },
          ),
        );
      });
      list.add(tag);
      return list;
    } else {
      return [tag];
    }
  }

  String radioSelect = '0';
  Widget _horizontalRadios(BuildContext context) {
    return TDRadioGroup(
      selectId: radioSelect,
      direction: Axis.horizontal,
      directionalTdRadios: const [
        TDRadio(
          id: '0',
          title: '选择标签',
          radioStyle: TDRadioStyle.circle,
          showDivider: true,
        ),
        TDRadio(
          id: '1',
          title: '新增标签',
          radioStyle: TDRadioStyle.circle,
          showDivider: false,
          enable: false,
        ),
      ],
    );
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
    uploadListTagMap = {};
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

  _buildBody(String key) {
    switch (radioSelect) {
      case "0": //选择
        return FutureLoading(
            future: fetchTag(),
            builder: (_, list) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _radioBuildTag(key, list),
                  //已选择的标签
                  gapHeightNormal(),
                  TDDivider(),
                  if (null != uploadListTagMap[key] &&
                      uploadListTagMap[key]!.isNotEmpty)
                    _buildSelectedTags(key),
                ],
              );
            });
      case "1":
        return Container();
    }
  }

  Future<List<tag.BabyUploadTagRespVo>?> fetchTag() {
    return UploadListDao.getBabyUploadTagAll();
  }

  _radioBuildTag(String key, List<tag.BabyUploadTagRespVo>? list) {
    if (null == list || list.isEmpty) {
      return TDText(
        '还没有标签哦',
        style: TextStyle(color: Colors.grey.withOpacity(0.7)),
      );
    }
    return Wrap(
      runSpacing: 20.w,
      spacing: 30.w,
      children: _radioBuildTags(context, key, list),
    );
  }

  _radioBuildTags(
      BuildContext context, String key, List<tag.BabyUploadTagRespVo> list) {
    var uploadListTagNameList =
        (uploadListTagMap[key] ?? []).map((e) => e.tagName!).toList();
    return list.where((e) => !uploadListTagNameList.contains(e.tagName)).map(
      (e) {
        return GestureDetector(
          onTap: () async {
            var res = await SmartDialog.show(
                tag: "radioSelectTag",
                builder: (_) {
                  return TDAlertDialog(
                    content: '确定选择该标签吗?',
                    leftBtnAction: () {
                      SmartDialog.dismiss(tag: "radioSelectTag");
                    },
                    rightBtnAction: () {
                      SmartDialog.dismiss(tag: "radioSelectTag", result: e);
                    },
                  );
                });
            SmartDialog.dismiss(
                tag: "radioTag", result: res as tag.BabyUploadTagRespVo);
          },
          child: TDTag(
            e.tagName!,
            size: TDTagSize.large,
          ),
        );
      },
    ).toList();
  }

  buildSelectTag(String key) {
    var uploadListTagList = uploadListTagMap[key];
    if (null == uploadListTagList || uploadListTagList.isEmpty) {
      return SizedBox();
    }
    return Wrap(
      runSpacing: 20.w,
      spacing: 10.w,
      children: uploadListTagList.map((e) {
        return TDTag(
          e.tagName!,
          size: TDTagSize.large,
        );
      }).toList(),
    );
  }

  _buildSelectedTags(String key) {
    return Column(
      children: [
        TDText(
          '已选择的标签',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        gapHeightSmall(),
        buildSelectTag(key),
      ],
    );
  }
}
