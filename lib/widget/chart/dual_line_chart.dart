import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/gap/gap_height.dart';
import 'dart:math' as math; // 添加这行导入

class DualLineChart extends StatefulWidget {
  final List<DualLineData> data;
  final String primaryName;
  final String secondaryName;
  final String yAxisTitle;
  final Color primaryColor;
  final Color secondaryColor;
  final double height;
  final String Function(DateTime) dateFormatter;

  // 新增自定义选项
  final TextStyle? yAxisTitleStyle;
  final TextStyle? yAxisValueStyle;
  final double yAxisTitleSpacing;
  final bool showGrid;
  final Color gridColor;
  final double gridLineWidth;

  const DualLineChart({
    Key? key,
    required this.data,
    required this.primaryName,
    required this.secondaryName,
    required this.yAxisTitle,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.red,
    this.height = 300,
    this.dateFormatter = defaultDateFormatter,
    this.yAxisTitleStyle,
    this.yAxisValueStyle,
    this.yAxisTitleSpacing = 8.0,
    this.showGrid = true,
    this.gridColor = Colors.black12,
    this.gridLineWidth = 1.0,
  }) : super(key: key);

  static String defaultDateFormatter(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  State<DualLineChart> createState() => _DualLineChartState();
}

class _DualLineChartState extends State<DualLineChart> {
  bool showPrimary = true;
  bool showSecondary = true;

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
              border: Border.all(color: color, width: 2),
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

  List<FlSpot> _getSpots(bool isSecondary) {
    List<String> allDates = widget.data
        .map((data) => widget.dateFormatter(data.time))
        .toSet()
        .toList()
      ..sort();

    var filteredData = widget.data
        .where((item) => item.isSecondary == isSecondary)
        .toList()
      ..sort((a, b) => a.time.compareTo(b.time));

    return filteredData.map((item) {
      int index = allDates.indexOf(widget.dateFormatter(item.time));
      return FlSpot(index.toDouble(), item.value);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(
                widget.primaryName,
                widget.primaryColor,
                showPrimary,
                () => setState(() => showPrimary = !showPrimary),
              ),
              SizedBox(width: 20),
              _buildLegendItem(
                widget.secondaryName,
                widget.secondaryColor,
                showSecondary,
                () => setState(() => showSecondary = !showSecondary),
              ),
            ],
          ),
          Row(
            children: [
              // Y轴标题
              RotatedBox(
                quarterTurns: 0,
                child: Text(
                  widget.yAxisTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          gapHeightNormal(),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: widget.showGrid,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: widget.gridColor,
                      strokeWidth: widget.gridLineWidth,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: widget.gridColor,
                      strokeWidth: widget.gridLineWidth,
                    );
                  },
                  checkToShowVerticalLine: (value) {
                    return value >= 0 && value <= getMaxX();
                  },
                  checkToShowHorizontalLine: (value) {
                    return value >= calculateMinY() && value <= calculateMaxY();
                  },
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    left: BorderSide(color: Colors.black87),
                    bottom: BorderSide(color: Colors.black87),
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        List<String> allDates = widget.data
                            .map((data) => widget.dateFormatter(data.time))
                            .toSet()
                            .toList()
                          ..sort();

                        if (value.toInt() >= 0 &&
                            value.toInt() < allDates.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Transform.rotate(
                              angle: -0.5,
                              child: Text(
                                allDates[value.toInt()],
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          );
                        }
                        return Text('');
                      },
                      reservedSize: 42,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                minY: calculateMinY(),
                maxY: calculateMaxY(),
                minX: 0,
                maxX: getMaxX(),
                lineBarsData: [
                  if (showPrimary)
                    LineChartBarData(
                      spots: _getSpots(false),
                      isCurved: true,
                      color: widget.primaryColor,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  if (showSecondary)
                    LineChartBarData(
                      spots: _getSpots(true),
                      isCurved: true,
                      color: widget.secondaryColor,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    //tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItems: (List<LineBarSpot> touchedSpots) {
                      return touchedSpots.map((LineBarSpot spot) {
                        List<String> allDates = widget.data
                            .map((data) => widget.dateFormatter(data.time))
                            .toSet()
                            .toList()
                          ..sort();

                        String date = allDates[spot.x.toInt()];

                        return LineTooltipItem(
                          '${spot.barIndex == 0 ? widget.primaryName : widget.secondaryName}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: '\n日期: $date',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: '\n数值: ${spot.y.toStringAsFixed(1)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }

  // 在 LineChartData 中添加
  double calculateMinY() {
    final min = widget.data.map((e) => e.value).reduce(math.min);
    final max = widget.data.map((e) => e.value).reduce(math.max);
    final range = max - min;
    return min - (range * 0.1); // 下边界减少 10% 的范围
  }

  double calculateMaxY() {
    final min = widget.data.map((e) => e.value).reduce(math.min);
    final max = widget.data.map((e) => e.value).reduce(math.max);
    final range = max - min;
    return max + (range * 0.1); // 上边界增加 10% 的范围
  }

  // 计算 X 轴最大值
  double getMaxX() {
    return (getAllDates().length - 1).toDouble();
  }

  // 获取所有唯一的日期
  List<String> getAllDates() {
    return widget.data
        .map((data) => widget.dateFormatter(data.time))
        .toSet()
        .toList()
      ..sort();
  }
}

class DualLineData {
  final DateTime time;
  final double value;
  final bool isSecondary;

  DualLineData({
    required this.time,
    required this.value,
    required this.isSecondary,
  });

  // 可选：添加一个工厂方法来帮助转换数据
  static List<DualLineData> fromHeightData(List<Data> data) {
    return data
        .map((item) => DualLineData(
              time: item.recordTime,
              value: item.height,
              isSecondary: item.isStandard,
            ))
        .toList();
  }
}

class Data {
  final DateTime recordTime;
  final double height;
  final bool isStandard;

  Data({
    required this.recordTime,
    required this.height,
    required this.isStandard,
  });
}
