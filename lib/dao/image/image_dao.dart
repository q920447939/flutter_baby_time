import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../http/core/hi_net.dart';
import 'dart:typed_data' as ty;

import '../http/request/base_request.dart';

class ImageDao {
/*  static Future<String> uploadImage(ty.Uint8List data, String fileName) async {
    var list = await uploadImages([data], [fileName]);
    return list[0];
  }*/

  static Future<String> uploadImageByFiles(List<File> files) async {
    for (var file in files) {
      print(file.path);
      var list = await uploadFile(await file.readAsBytes(), "test.png");
    }

    return "";
  }

/*
  static Future<List<String>> uploadImages(
      List<ty.Uint8List> images, List<String> fileNames) async {
    List<String> imagePath = [];
    for (int i = 0; i < images.length; i++) {
      var data = await uploadFile(images, i, fileNames);
      imagePath.add(data['url']);
    }
    return imagePath;
  }
*/

  static Future<dynamic> uploadFile(List<int> bytes, String fileName) async {
    var data = await HiNet.getInstance().fire(
        AnonymousRequest(
                method: HttpMethod.POST,
                path: "/api/upload/uploadFile",
                needLogin: true,
                needToken: true)
            .setBody(
                FormData.fromMap({
                  "file": MultipartFile.fromBytes(
                    bytes,
                    filename: fileName,
                    contentType: MediaType.parse("multipart/form-data"),
                  ),
                }),
                serialize: false)
            .addHead("Content-Type", "multipart/form-data"),
        showLoading: false);
    return data;
  }
}
