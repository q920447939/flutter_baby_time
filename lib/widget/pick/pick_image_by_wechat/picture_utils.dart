import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_bean.dart';

class PictureUtils {
  static Future<T?> pushPage<T extends Object>(
      BuildContext context, Widget page) {
    return Navigator.push(
      context,
      CupertinoPageRoute(builder: (ctx) => page),
    );
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Widget getWidget(String url) {
    // 加载网络图片
    if (url.startsWith('http')) {
      //return CachedNetworkImage(imageUrl: url, fit: BoxFit.cover);
      return Image.network(url, fit: BoxFit.cover);
    }
    // 加载资源文件
    if (url.startsWith('assets/images')) {
      return Image.asset(url, fit: BoxFit.cover);
    }
    if (url.startsWith('/storage/emulated')) {
      return Image.file(File(url), fit: BoxFit.cover);
    }
    // 加载失败图片
    return Image.asset('assets/images/image_load_error.png', fit: BoxFit.cover);
  }

  static List<ImageBean> getImageBean(List<File> files) {
    List<ImageBean> list = [];
    for (int i = 0; i < files.length; i++) {
      String url = files[i].path;
      list.add(ImageBean(
        originPath: url,
        middlePath: url,
        thumbPath: url,
        originalWidth: i == 0 ? 264 : null,
        originalHeight: i == 0 ? 258 : null,
      ));
    }
    return list;
  }
}
