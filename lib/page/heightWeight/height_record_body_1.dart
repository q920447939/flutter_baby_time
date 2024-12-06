import 'package:flutter/cupertino.dart';
import 'package:flutter_baby_time/widget/future/future_.dart';
import 'package:flutter_baby_time/widget/future/future_more.dart';
import 'package:flutter_baby_time/widget/no_data.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../dao/height_record/height_dao.dart';
import '../../model/height_record/BabyHeightRecordRespVO.dart';
import '../../model/height_record/BabyHeightRecordStandardRelationRespVO.dart';
import '../../utils/datime_helper.dart';
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

  @override
  void initState() {
    super.initState();
  }

  Future<List<BabyHeightRecordRespVo>?> fetch() async {
    babyHeightRecordRespVoList = await HeightRecordDao.getAllRecord();
    return babyHeightRecordRespVoList;
  }

  Future<List<BabyHeightRecordStandardRelationRespVo>?>
      fetchBabyHeightRecordStandardRelation() async {
    babyHeightRecordStandardRelationRespVoList =
        await HeightRecordDao.getBabyHeightRecordStandardByCountryCode();
    return babyHeightRecordStandardRelationRespVoList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureMoreLoading(
      future: [fetch(), fetchBabyHeightRecordStandardRelation()],
      builder: (context, _) {
        if ((babyHeightRecordRespVoList ?? []).isEmpty) {
          return NoData();
        }
        List<HeightData> combinedData = [
          ...babyHeightRecordRespVoList!.map((record) => HeightData(
                recordTime: record.recordTime!,
                height: record.height!,
                isStandard: false,
              )),
          ...babyHeightRecordStandardRelationRespVoList!
              .map((standard) => HeightData(
                    recordTime: standard.relationTime!,
                    height: standard.standardHeight!,
                    isStandard: true,
                  )),
        ];
        return Column(
          children: [
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <LineSeries<HeightData, String>>[
                LineSeries<HeightData, String>(
                  dataSource:
                      combinedData.where((data) => !data.isStandard).toList(),
                  xValueMapper: (HeightData data, _) =>
                      formatDate(data.recordTime),
                  yValueMapper: (HeightData data, _) => data.height,
                  name: '身高',
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
                LineSeries<HeightData, String>(
                  dataSource:
                      combinedData.where((data) => data.isStandard).toList(),
                  xValueMapper: (HeightData data, _) =>
                      formatDate(data.recordTime),
                  yValueMapper: (HeightData data, _) => data.height,
                  name: '标准身高(${_babyController.sex.value.label})',
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class HeightData {
  final DateTime recordTime;
  final double height;
  final bool isStandard;

  HeightData({
    required this.recordTime,
    required this.height,
    required this.isStandard,
  });
}
