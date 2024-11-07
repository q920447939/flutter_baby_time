import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_baby_time/app/modules/home_page_module/home_page_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomePagePage extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
