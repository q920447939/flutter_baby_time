import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/skeletonizer_helper.dart';

class FutureLoading<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(BuildContext, T) builder;
  final Widget loadingWidget;
  final Widget Function(BuildContext, dynamic)? errorBuilder;

  const FutureLoading({
    Key? key,
    required this.future,
    required this.builder,
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.errorBuilder,
  }) : super(key: key);

  @override
  _FutureLoadingState<T> createState() => _FutureLoadingState<T>();
}

class _FutureLoadingState<T> extends State<FutureLoading<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget;
        } else if (snapshot.hasError) {
          return widget.errorBuilder?.call(context, snapshot.error) ??
              Center(child: Text('错误：${snapshot.error}'));
        } else if (snapshot.hasData) {
          return widget.builder(context, snapshot.data as T);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
