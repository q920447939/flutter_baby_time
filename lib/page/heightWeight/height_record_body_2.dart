import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/future/future_.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../dao/height_record/height_dao.dart';
import '../../model/height_record/BabyHeightRecordRespVO.dart';
import '../../utils/datime_helper.dart';
import '../../widget/no_data.dart';

class HeightRecordBodyPage2 extends StatefulWidget {
  const HeightRecordBodyPage2({super.key});

  @override
  State<HeightRecordBodyPage2> createState() => _HeightRecordBodyPage2State();
}

class _HeightRecordBodyPage2State extends State<HeightRecordBodyPage2> {
  Future<List<BabyHeightRecordRespVo>?> fetch() {
    return HeightRecordDao.getAllRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        gapHeightNormal(),
        TDText(
          '历史记录',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        gapHeightNormal(),
        gapHeightNormal(),
        Expanded(
          // 添加 Expanded
          child: FutureLoading(
              future: fetch(),
              builder: (context, list) {
                if ((list ?? []).isEmpty) {
                  return NoData();
                }
                return ListView.builder(
                  // 使用 ListView.builder 更高效
                  itemCount: list!.length,
                  itemBuilder: (context, idx) {
                    return Padding(
                      padding: EdgeInsets.all(5.h),
                      child: _buildHistory(list[idx]),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  _buildHistory(BabyHeightRecordRespVo babyHeightRecordRespVo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TDText(formatDate(babyHeightRecordRespVo.recordTime!)),
            TDText.rich(
              TextSpan(children: [
                TDTextSpan(
                  text: babyHeightRecordRespVo.height!.toStringAsFixed(2),
                ),
                TextSpan(
                    text: ' cm',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: TDTheme.of(context).brandNormalColor)),
              ]),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
          child: Container(
            alignment: Alignment.center,
            child: const TDDivider(),
          ),
        ),
      ],
    );
  }
}
