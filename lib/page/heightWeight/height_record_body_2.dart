import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class HeightRecordBodyPage2 extends StatefulWidget {
  const HeightRecordBodyPage2({super.key});

  @override
  State<HeightRecordBodyPage2> createState() => _HeightRecordBodyPage2State();
}

class _HeightRecordBodyPage2State extends State<HeightRecordBodyPage2> {
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
        //构建历史记录
        /*ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(100, (idx) {
            return Padding(
                padding: EdgeInsets.all(5.h), child: _buildHistory());
          }),
        ),*/
        Expanded(
          // 添加 Expanded
          child: ListView.builder(
            // 使用 ListView.builder 更高效
            itemCount: 100,
            itemBuilder: (context, idx) {
              return Padding(
                padding: EdgeInsets.all(5.h),
                child: _buildHistory(),
              );
            },
          ),
        ),
      ],
    );
  }

  _buildHistory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TDText('2023-01-01'),
            TDText.rich(
              TextSpan(children: [
                TDTextSpan(
                  text: '65',
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
