import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowImage extends StatefulWidget {
  final Image image;
  double? width;
  double? height;
  final fit;

  double? radius;

  ShowImage(this.image,
      {super.key,
      this.fit = BoxFit.cover,
      this.width,
      this.height,
      this.radius});

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  @override
  Widget build(BuildContext context) {
    var width = widget.width ?? 50.w;
    var height = widget.height ?? 50.h;
//设置一个圆形的图片
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          // Radius.circular(50) 生成圆形的比例 ，越大越像圆
          borderRadius: BorderRadius.all(Radius.circular(40)),
          //给圆设置一个边界 ，这样会在外层套上一个白色的边框
          border: Border.all(
            color: Color(0xfffefefe),
            width: 3,
          ),
          image: DecorationImage(
            image: widget.image.image, // 直接使用widget.image
            fit: BoxFit.cover,
          )),
    );
  }
}
