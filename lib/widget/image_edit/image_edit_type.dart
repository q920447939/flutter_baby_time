import 'package:extended_image/extended_image.dart';

import 'circle_editor_crop_layer_painter.dart';
import 'rectangle_editor_crop_layer_painter.dart';


enum ImageEditType {
  realName('realName', '实名认证'),
  profile('profile', '个人中心头像修改'),
  end('', '');

  final String storagePathPre;
  final String description;

  const ImageEditType(this.storagePathPre, this.description);
}

enum ImageEditCropLayerType {
  circle('circle', '圆形'),
  rectangle('rectangle', '方形'),
  end('', '');

  final String type;
  final String description;

  const ImageEditCropLayerType(this.type, this.description);

  EditorCropLayerPainter getEditorCropLayerPainter() {
    switch (this) {
      case ImageEditCropLayerType.circle:
        return const CircleEditorCropLayerPainter();
      case ImageEditCropLayerType.rectangle:
        return const RectangleEditorCropLayerPainter();
      default:
        return const CircleEditorCropLayerPainter();
    }
  }
}
