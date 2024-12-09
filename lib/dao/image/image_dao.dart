import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../http/core/hi_net.dart';
import 'dart:typed_data' as ty;

import '../http/request/base_request.dart';

class ImageDao {
  static Future<List<String>> uploadImageByFiles(List<File> files) async {
    List<String> urls = [];
    for (var file in files) {
      var map = await uploadFile(await file.readAsBytes(), "test.png") as Map;
      urls.add(map['url']);
    }

    return urls;
  }

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
