import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../custom_safe_area/CustomSafeArea.dart';

class BaseScaffoldStack extends StatefulWidget {
  String title;
  double? appBarSize;
  List<Color>? gradientColors;
  Widget child;
  String? appBarRightTitle;
  VoidCallback? appBarRightClick;
  TabBar? appBarBottom;
  bool showBackIcon;
  BaseScaffoldStack({
    super.key,
    required this.title,
    required this.child,
    this.appBarRightTitle,
    this.appBarRightClick,
    this.gradientColors,
    this.appBarBottom,
    this.showBackIcon = true,
    this.appBarSize,
  });

  @override
  State<BaseScaffoldStack> createState() => _BaseScaffoldStackState();
}

class _BaseScaffoldStackState extends State<BaseScaffoldStack> {
  @override
  Widget build(BuildContext context) {
    return CustomerSafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: /*[
                  Color(0xFFBBDEFB),
                  Color(0xFF90CAF9),
                ]*/
                    widget.gradientColors ?? [Colors.white, Colors.white],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: null == widget.appBarSize
                  ? _buildAppBar(context)
                  : PreferredSize(
                      preferredSize:
                          Size.fromHeight(widget.appBarSize!), // 设置 AppBar 的高度
                      child: _buildAppBar(context),
                    ),
              body: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.showBackIcon,
      leading: widget.showBackIcon
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            )
          : null,
      title: widget.title == ''
          ? null
          : Center(
              child: Text(widget.title),
            ),
      backgroundColor: Colors.transparent,
      bottom: widget.appBarBottom,
      actions: widget.appBarRightTitle != null
          ? [
              Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      widget.appBarRightClick?.call();
                    },
                    child: Text(widget.appBarRightTitle!,
                        style: TextStyle(fontSize: 14.sp)),
                  )
                ],
              )
            ]
          : [],
    );
  }
}

class GreyBaseScaffoldStack extends StatelessWidget {
  double? appBarSize;
  String title;
  Widget child;
  String? appBarRightTitle;
  VoidCallback? appBarRightClick;
  TabBar? appBarBottom;
  bool? showBackIcon;
  GreyBaseScaffoldStack({
    super.key,
    required this.title,
    required this.child,
    this.appBarRightTitle,
    this.appBarRightClick,
    this.appBarBottom,
    this.showBackIcon,
    this.appBarSize,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldStack(
      title: title,
      appBarSize: appBarSize,
      showBackIcon: showBackIcon ?? true,
      appBarRightTitle: appBarRightTitle,
      appBarRightClick: appBarRightClick,
      gradientColors: [
        Colors.grey.withOpacity(0.1),
        Colors.grey.withOpacity(0.1),
      ],
      appBarBottom: appBarBottom,
      child: child,
    );
  }
}

class WhiteBaseScaffoldStack extends StatelessWidget {
  double? appBarSize;
  String title;
  Widget child;
  String? appBarRightTitle;
  VoidCallback? appBarRightClick;
  TabBar? appBarBottom;
  bool? showBackIcon;
  WhiteBaseScaffoldStack({
    super.key,
    required this.title,
    required this.child,
    this.appBarRightTitle,
    this.appBarRightClick,
    this.appBarBottom,
    this.showBackIcon,
    this.appBarSize,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldStack(
      title: title,
      appBarSize: appBarSize,
      showBackIcon: showBackIcon ?? true,
      appBarRightTitle: appBarRightTitle,
      appBarRightClick: appBarRightClick,
      gradientColors: [
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.1),
      ],
      appBarBottom: appBarBottom,
      child: child,
    );
  }
}
