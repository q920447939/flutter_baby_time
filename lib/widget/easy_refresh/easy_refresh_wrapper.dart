import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/no_data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../refresh/simple_easy_refresher.dart';
import 'grid_refresh.dart';

typedef PageData<T> = Future<List<T>> Function(int pageNo, int pageSize);

class EasyRefreshWrapper<T> extends StatefulWidget {
  PageData<T> initLoad; // 使用 InitLoad 类型
  PageData<T> loadMore;
  int pageSize;
  // 添加新的回调函数，用于构建列表视图
  Widget Function(List<T> list, ScrollPhysics physics) listBuilder;

  EasyRefreshWrapper({
    super.key,
    required this.initLoad,
    required this.loadMore,
    this.pageSize = 10,
    required this.listBuilder, // 新增必需参数
  });

  @override
  State<EasyRefreshWrapper> createState() => _EasyRefreshWrapperState();
}

class _EasyRefreshWrapperState<T> extends State<EasyRefreshWrapper> {
  final EasyRefreshController _controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  List<T> _list = [];
  final int _defaultPageNo = 1;
  late int pageNo = _defaultPageNo;
  late int size;

  @override
  void initState() {
    size = widget.pageSize;
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    pageNo = _defaultPageNo; // 重置页码
    try {
      final list = await widget.initLoad(_defaultPageNo, size);
      setState(() {
        _list = List<T>.from(list);
      });
      _controller.finishRefresh();
      // 如果数据不足一页，说明没有更多数据
      if (list.length < size) {
        _controller.finishLoad();
      }
    } catch (e) {
      _controller.finishRefresh();
    }
  }

  Future<void> _loadMore() async {
    try {
      final list = await widget.loadMore(++pageNo, size);
      setState(() {
        _list.addAll(List<T>.from(list));
      });
      //TODO 获取总页数
      _controller.finishLoad();
    } catch (e) {
      pageNo--; // 加载失败，页码回退
      _controller.finishLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleEasyRefresher(
      easyRefreshController: _controller,
      onRefresh: _refresh,
      onLoad: _loadMore,
      childBuilder: (context, physics) {
        return _list.isEmpty
            ? const NoData()
            : widget.listBuilder(_list, physics); // 使用传入的 listBuilder
      },
    );
  }
}
