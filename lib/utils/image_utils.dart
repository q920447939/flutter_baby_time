import 'package:image/image.dart' as img;
import 'dart:math' as math;
import 'dart:typed_data'; // 添加这个导入

class ImageUtils {
  static List<int> compressImage(
    List<int> bytes, {
    int maxSize = 2560,
    int quality = 85,
  }) {
    // 转换为 Uint8List
    final Uint8List uint8List = Uint8List.fromList(bytes);
    img.Image? image = img.decodeImage(uint8List);
    if (image == null) return bytes;

    if (image.width > maxSize || image.height > maxSize) {
      double scale = maxSize / math.max(image.width, image.height);
      image = img.copyResize(
        image,
        width: (image.width * scale).round(),
        height: (image.height * scale).round(),
      );
    }

    return img.encodeJpg(image, quality: quality);
  }
}
