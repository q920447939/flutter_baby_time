import 'package:flutter/material.dart';
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
    return ListView.builder(itemBuilder: (_, index) {
      return childItem(data[index], index);
    });
  }
}
