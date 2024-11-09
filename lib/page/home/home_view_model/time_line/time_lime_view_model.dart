import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/page/home/home_view_model/time_line/time_line_refresh.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../widget/easy_refresh/easy_refresh_wrapper.dart';
import '../../../../widget/easy_refresh/grid_refresh.dart';
import '../../../../widget/gap/gap_height.dart';
import '../../../../widget/gap/gap_width.dart';
import '../../../../widget/smart_dialog/smart_dialog_helper.dart';

class TimeLimeViewModel extends StatefulWidget {
  double height;

  TimeLimeViewModel({super.key, this.height = 300});

  @override
  State<TimeLimeViewModel> createState() => _TimeLimeViewModelState();
}

class _TimeLimeViewModelState extends State<TimeLimeViewModel> {
  //构建时间线 ，为了降低性能开销 分批渲染数据
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
          return TimeLineRefresh<dynamic>(
              data: list, childItem: _buildItem, physics: physics);
        },
      ),
    );
  }

  Widget _buildItem(item, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.podcasts,
              color: Colors.red,
            ),
            TDText(
              '11月6日',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapWidthTiny(),
            TDText(
              '9个月15天',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ],
        ),
        gapHeightNormal(),
        ContainerWrapperCard(
          child: TDImage(
            assetUrl: 'assets/img/baby_photo.jpg',
            type: TDImageType.roundedSquare,
            fit: BoxFit.cover,
            height: 290.h,
            width: double.infinity,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
