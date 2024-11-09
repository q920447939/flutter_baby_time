import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TimeLineRefresh<T> extends StatelessWidget {
  List<T> data;
  ScrollPhysics physics;
  Widget Function(dynamic item, int idx) childItem;
  TimeLineRefresh({
    super.key,
    required this.data,
    required this.childItem,
    required this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: ListView.builder(
        itemBuilder: (_, index) {
          return childItem(data[index], index);
        },
      ),
    );
  }
}
