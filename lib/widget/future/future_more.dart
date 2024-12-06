import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/skeletonizer_helper.dart';

class FutureMoreLoading extends StatefulWidget {
  final List<Future> future;
  final Widget Function(BuildContext, void) builder;
  final Widget loadingWidget;
  final Widget Function(BuildContext, dynamic)? errorBuilder;

  const FutureMoreLoading({
    Key? key,
    required this.future,
    required this.builder,
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.errorBuilder,
  }) : super(key: key);

  @override
  _FutureMoreLoadingState createState() => _FutureMoreLoadingState();
}

class _FutureMoreLoadingState extends State<FutureMoreLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.wait(widget.future),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget;
        } else if (snapshot.hasError) {
          return widget.errorBuilder?.call(context, snapshot.error) ??
              Center(child: Text('错误：${snapshot.error}'));
        } else if (snapshot.hasData) {
          return widget.builder(context, snapshot.data);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
