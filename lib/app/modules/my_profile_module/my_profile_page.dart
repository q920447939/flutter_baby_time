import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_baby_time/app/modules/my_profile_module/my_profile_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MyProfilePage extends GetView<MyProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyProfile Page')),
      body: Container(
        child: Obx(()=>Container(child: Text(controller.obj),)),
      ),
    );
  }
}
