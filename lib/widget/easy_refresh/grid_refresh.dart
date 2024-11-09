import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridRefresh<T> extends StatelessWidget {
  List<T> data;
  ScrollPhysics physics;
  Widget Function(dynamic item, int idx) childItem;
  GridRefresh({
    super.key,
    required this.data,
    required this.childItem,
    required this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      physics: physics, // 使用 EasyRefresh 提供的 physics
      padding: const EdgeInsets.all(8),
      itemCount: data.length,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return childItem(data[index], index);
      },
    );
  }
}
