import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HeightRecordBodyPage1 extends StatefulWidget {
  const HeightRecordBodyPage1({super.key});

  @override
  State<HeightRecordBodyPage1> createState() => _HeightRecordBodyPage1State();
}

class _HeightRecordBodyPage1State extends State<HeightRecordBodyPage1> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  List<_SalesData> data1 = [
    _SalesData('Jan', 352),
    _SalesData('Feb', 218),
    _SalesData('Mar', 343),
    _SalesData('Apr', 345),
    _SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          // Enable legend
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: [
            LineSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true)),
            LineSeries<_SalesData, String>(
                dataSource: data1,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ]),
    ]);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
