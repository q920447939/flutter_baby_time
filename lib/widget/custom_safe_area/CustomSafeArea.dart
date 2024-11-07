import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerSafeArea extends StatefulWidget {
  final Widget child;

  const CustomerSafeArea({super.key, required this.child});

  @override
  State<CustomerSafeArea> createState() => _CustomerSafeAreaState();
}

class _CustomerSafeAreaState extends State<CustomerSafeArea> {
  @override
  Widget build(BuildContext context) {
    /*return Platform.isIOS
        ? Padding(padding: EdgeInsets.only(top: 22.h), child: widget.child)
        : SafeArea(child: widget.child);*/
    return SafeArea(child: widget.child);
  }
}
