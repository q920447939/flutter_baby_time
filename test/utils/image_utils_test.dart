import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_baby_time/utils/image_utils.dart';
import 'dart:io';

void main() {
  group('ImageUtils', () {
    test('compressImage should compress image successfully', () async {
      // 读取测试图片文件
      final File imageFile = File(
          'C:/Users/Administrator/AppData/Local/Pub/Cache/hosted/pub.flutter-io.cn/file_picker-8.1.7/test/test_files/franz-michael-schneeberger-unsplash.jpg');
      final List<int> imageBytes = await imageFile.readAsBytes();

      // 压缩图片
      final List<int> compressedBytes = ImageUtils.compressImage(
        imageBytes,
        maxSize: 1024,
        quality: 80,
      );

      // 验证压缩后的图片大小小于原图
      expect(compressedBytes.length, lessThan(imageBytes.length));

      // 可以将压缩后的图片保存到文件系统进行目视检查
      // await File('test/assets/compressed_test_image.jpg').writeAsBytes(compressedBytes);
    });

    test('compressImage should handle invalid image data', () {
      // 测试无效的图片数据
      final List<int> invalidImageData = [1, 2, 3, 4, 5];

      final List<int> result = ImageUtils.compressImage(invalidImageData);

      // 当输入无效时应该返回原始数据
      expect(result, equals(invalidImageData));
    });
  });
}
