import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/easy_refresh/grid_refresh.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_baby_time/widget/gap/gap_width.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../widget/easy_refresh/easy_refresh_wrapper.dart';

class FallLoadViewModel extends StatefulWidget {
  double height;

  FallLoadViewModel({super.key, this.height = 300});

  @override
  _FallLoadViewModelState createState() => _FallLoadViewModelState();
}

class _FallLoadViewModelState extends State<FallLoadViewModel> {
  @override
  void initState() {
    super.initState();
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
          return GridRefresh<dynamic>(
              data: list, childItem: _buildItem, physics: physics);
        },
      ),
    );
  }

  Widget _buildItem(item, index) {
    // 构建网格项
    return Container(
      height: 470.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TDImage(
            assetUrl: 'assets/img/baby_photo.jpg',
            type: TDImageType.roundedSquare,
            fit: BoxFit.cover,
            height: 290.h,
            width: double.infinity,
          ),
          gapHeightSmall(),
          TDText(
            '小熙熙一岁啦,学会走路咯!!! $index',
          ),
          gapHeightSmall(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TDAvatar(
                  size: TDAvatarSize.small,
                  type: TDAvatarType.normal,
                  shape: TDAvatarShape.circle,
                  defaultUrl: 'assets/img/td_avatar_1.png',
                  backgroundColor: Colors.transparent,
                ),
                gapWidthSmall(),
                TDText(
                  '小心心',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                dialogSuccess('123');
              },
              child: Padding(
                padding: EdgeInsets.only(right: 5.w),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    "assets/svg/like.svg",
                    width: 16.w,
                  ),
                ),
              ),
            ),
          ]),
          gapHeightSmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TDText(
                '2022年12月12日 12点 (1岁1月)',
                style: TextStyle(fontSize: 12.sp),
              ),
            ],
          ),
          gapHeightSmall(),
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TDTag(
                '一周年纪念',
                isOutline: true,
                needCloseIcon: false,
                theme: TDTagTheme.primary,
              ),
            ),
          ),
          gapHeightNormal(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
