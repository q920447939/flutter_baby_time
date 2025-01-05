import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../dao/image/image_dao.dart';

enum ImagePickerType { camera, gallery, both }

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<List<String>> pickAndUploadImages({
    ImagePickerType type = ImagePickerType.both,
    int maxImages = 1,
    int maxSize = 10,
    List<String> allowedExtensions = const ['jpg', 'jpeg', 'png'],
  }) async {
    List<XFile>? images;

    if (type == ImagePickerType.camera) {
      // 相机模式只能选择一张
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      images = image != null ? [image] : null;
    } else if (type == ImagePickerType.gallery) {
      if (maxImages == 1) {
        var xFile = await _picker.pickImage(source: ImageSource.gallery);
        if (null != xFile) {
          images = [xFile];
        }
      } else {
        // 相册模式，直接限制最大选择数量
        //TODO
        images = await _picker.pickMultiImage();
      }
    } else {
      // 弹出选择方式的对话框
      final ImageSource? source = await _showImageSourceDialog();
      if (source == null) return [];

      if (source == ImageSource.camera) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        images = image != null ? [image] : null;
      } else {
        //TODO 限制数量
        images = await _picker.pickMultiImage();
      }
    }

    if (images == null || images.isEmpty) {
      return [];
    }

    List<XFile> validFiles = [];
    for (var image in images) {
      // 检查文件格式
/*      String extension = image.name.split('.').last.toLowerCase();
      if (!allowedExtensions.contains(extension)) {
        continue;
      }*/

      // 检查文件大小
      if (await checkFileSize(image, maxSize)) {
        validFiles.add(image);
      } else {
        dialogFailure('选择的图片不能超过${maxSize}M!');
        return [];
      }
      validFiles.add(image);
    }

    if (validFiles.isEmpty) {
      return [];
    }

    // 上传图片
    return await uploadImages(validFiles);
  }

  static Future<ImageSource?> _showImageSourceDialog() async {
    return await SmartDialog.show(
      builder: (_) {
        return AlertDialog(
          title: Text('选择图片来源'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('相机'),
                onTap: () {
                  SmartDialog.dismiss(result: ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('相册'),
                onTap: () {
                  SmartDialog.dismiss(result: ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> checkFileSize(XFile image, int maxSize) async {
    if (kIsWeb) {
      // Web 环境下使用 XFile 的 length() 方法
      final bytes = await image.length();
      return bytes / (1024 * 1024) <= maxSize;
    } else {
      await dialogSuccess('获取到的文件路径:${image.path}');

      // 移动端环境
      File file = File(image.path);
      int sizeInBytes = await file.length();
      return sizeInBytes / (1024 * 1024) <= maxSize;
    }
  }

  // 处理文件上传
  static Future<List<String>> uploadImages(List<XFile> files) async {
    List<String> urls = [];
    for (var file in files) {
      String fileName = file.name;
      List<int> bytes;

      if (kIsWeb) {
        // Web 环境下读取文件内容
        bytes = await file.readAsBytes();
      } else {
        // 移动端环境
        bytes = await File(file.path).readAsBytes();
      }

      var map = await ImageDao.uploadFile(bytes, fileName) as Map;
      urls.add(map['url']);
    }
    return urls;
  }
}
