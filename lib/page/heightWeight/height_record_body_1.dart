import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/no_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../dao/height_record/height_dao.dart';
import '../../model/height_record/BabyHeightRecordRespVO.dart';
import '../../model/height_record/BabyHeightRecordStandardRelationRespVO.dart';
import '../../utils/datime_helper.dart';
import '../../widget/chart/dual_line_chart.dart';
import '../my/baby_setting/baby_setting_controller.dart';

class HeightRecordBodyPage1 extends StatefulWidget {
  const HeightRecordBodyPage1({super.key});

  @override
  State<HeightRecordBodyPage1> createState() => _HeightRecordBodyPage1State();
}

class _HeightRecordBodyPage1State extends State<HeightRecordBodyPage1> {
  List<BabyHeightRecordRespVo>? babyHeightRecordRespVoList;
  List<BabyHeightRecordStandardRelationRespVo>?
      babyHeightRecordStandardRelationRespVoList;

  BabySettingController _babyController = Get.find();

  bool showActualHeight = true;
  bool showStandardHeight = true;

  @override
  void initState() {
    super.initState();
    fetchBabyHeightRecordStandardRelation();
  }

  Future<List<BabyHeightRecordRespVo>?> fetch() async {
    babyHeightRecordRespVoList = await HeightRecordDao.getAllRecord();
    return babyHeightRecordRespVoList;
  }

  Future<List<BabyHeightRecordStandardRelationRespVo>?>
      fetchBabyHeightRecordStandardRelation() async {
    babyHeightRecordStandardRelationRespVoList =
        await HeightRecordDao.getBabyHeightRecordStandardByCountryCode();
    fetch().then((_) => setState(() {}));
    return babyHeightRecordStandardRelationRespVoList;
  }

  @override
  Widget build(BuildContext context) {
    if ((babyHeightRecordRespVoList ?? []).isEmpty) {
      return NoData();
    }
    List<Data> combinedData = [
      ...babyHeightRecordRespVoList!.map((record) => Data(
            recordTime: record.recordTime!,
            height: record.height!,
            isStandard: false,
          )),
      ...babyHeightRecordStandardRelationRespVoList!.map((standard) => Data(
            recordTime: standard.relationTime!,
            height: standard.standardHeight!,
            isStandard: true,
          )),
    ];
    // 转换你的数据为 DualLineData 格式
    List<DualLineData> chartData = combinedData
        .map((data) => DualLineData(
              time: data.recordTime,
              value: data.height,
              isSecondary: data.isStandard,
            ))
        .toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: DualLineChart(
        data: chartData,
        primaryName: '身高',
        secondaryName: '标准身高(${_babyController.sex.value.label})',
        yAxisTitle: '身高(cm)',
        yAxisTitleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
        yAxisValueStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
        showGrid: true,
        gridColor: Colors.grey.withOpacity(0.2),
        gridLineWidth: 0.5,
      ),
    );
  }

// 新的辅助方法来获取统一的数据点
  List<FlSpot> _getSpots(List<Data> data, bool isStandard) {
    // 获取所有排序后的唯一日期
    List<String> allDates = data
        .map((data) => formatDate(data.recordTime))
        .toSet()
        .toList()
      ..sort();

    // 过滤并排序数据
    var filteredData = data
        .where((item) => item.isStandard == isStandard)
        .toList()
      ..sort((a, b) => a.recordTime.compareTo(b.recordTime));

    // 创建数据点
    return filteredData.map((item) {
      // 找到日期在统一时间轴上的索引位置
      int index = allDates.indexOf(formatDate(item.recordTime));
      return FlSpot(index.toDouble(), item.height);
    }).toList();
  }

  Widget _buildLegendItem(
      String label, Color color, bool isVisible, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isVisible ? color : Colors.grey.shade300,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isVisible ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
