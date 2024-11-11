import 'dart:async';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/smart_dialog/smart_dialog_helper.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../utils/crop_editor_helper.dart';
import '../../widget/edit_image/common_widget.dart';
import 'circle_editor_crop_layer_painter.dart';
import 'image_edit_button_controller.dart';
import 'image_edit_controller.dart';
import 'image_edit_type.dart';
import 'dart:typed_data' as ty;

class ImageEditorPage extends StatefulWidget {
  final String filePath;
  final ImageEditType imageEditType;
  final EditorCropLayerPainter editorCropLayerPainter;

  ImageEditorPage(
      {super.key,
      required this.filePath,
      required this.imageEditType,
      required this.editorCropLayerPainter});

  @override
  _ImageEditorPageState createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorPage> {
  late final GlobalKey<ExtendedImageEditorState> editorKey;
  late final GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>
      popupMenuKey;
  AspectRatioItem? _aspectRatio;
  bool _cropping = false;

  late Completer<void> _initializationCompleter;
  final ImageEditController _imageEditController = ImageEditController();

  @override
  void initState() {
    editorKey = GlobalKey<ExtendedImageEditorState>();
    popupMenuKey = GlobalKey<PopupMenuButtonState<EditorCropLayerPainter>>();
    _aspectRatio = _imageEditController.aspectRatios.first;
    super.initState();

    _initializationCompleter = Completer<void>();
    _getImage().then((value) {
      if (!_initializationCompleter.isCompleted) {
        _initializationCompleter.complete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Center(child: Text('编辑')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () async {
              context.pop(await _cropImage(false));
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
          future: _initializationCompleter.future,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(children: <Widget>[
                Expanded(
                    child: ExtendedImage.memory(
                  _memoryImage!,
                  fit: BoxFit.contain,
                  mode: ExtendedImageMode.editor,
                  enableLoadState: true,
                  extendedImageEditorKey: editorKey,
                  initEditorConfigHandler: (ExtendedImageState? state) {
                    return EditorConfig(
                      maxScale: 8.0,
                      cropRectPadding: const EdgeInsets.all(20.0),
                      hitTestSize: 20.0,
                      cropLayerPainter: widget.editorCropLayerPainter,
                      initCropRectType: InitCropRectType.imageRect,
                      cropAspectRatio: _aspectRatio!.value,
                    );
                  },
                  cacheRawData: true,
                )),
              ]);
            }
          }),
      bottomNavigationBar: ImageEditButtonController(
        editorKey: editorKey,
      ),
    );
  }

  Future<String> _cropImage(bool useNative) async {
    if (_cropping) {
      return '';
    }
    String msg = '';
    try {
      _cropping = true;

      dialogLoading(msg: '照片裁切中...请等待');

      late EditImageInfo imageInfo;

      if (useNative) {
        imageInfo = await cropImageDataWithNativeLibrary(
            state: editorKey.currentState!);
      } else {
        imageInfo =
            await cropImageDataWithDartLibrary(state: editorKey.currentState!);
      }
      DateTime now = DateTime.now();
// 输出当前时间的时间戳（毫秒级）
      int currentTimeMillis = now.millisecondsSinceEpoch;
      /* var url = await ImageDao.uploadImage(
          imageInfo.data as ty.Uint8List, '$currentTimeMillis.png');
      _cropping = false;
      EasyLoading.dismiss();*/
      return "";
    } catch (e, stack) {
      msg = 'save failed: $e\n $stack';
      dialogFailure(msg);
      _cropping = false;
      return '';
    } finally {
      SmartDialog.dismiss();
    }
  }

  ty.Uint8List? _memoryImage;

  Future<void> _getImage() async {
    _memoryImage = await fileToUint8List(widget.filePath);
    //when back to current page, may be editorKey.currentState is not ready.
    Future<void>.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        editorKey.currentState!.reset();
      });
    });
  }

  Future<ty.Uint8List> fileToUint8List(String filePath) async {
    File file = File(filePath);
    ty.Uint8List bytes = await file.readAsBytes();
    return bytes;
  }
}

class CustomEditorCropLayerPainter extends EditorCropLayerPainter {
  const CustomEditorCropLayerPainter();

  @override
  void paintCorners(
      Canvas canvas, Size size, ExtendedImageCropLayerPainter painter) {
    final Paint paint = Paint()
      ..color = painter.cornerColor
      ..style = PaintingStyle.fill;
    final Rect cropRect = painter.cropRect;
    const double radius = 6;
    canvas.drawCircle(Offset(cropRect.left, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.top), radius, paint);
    canvas.drawCircle(Offset(cropRect.left, cropRect.bottom), radius, paint);
    canvas.drawCircle(Offset(cropRect.right, cropRect.bottom), radius, paint);
  }
}

// 将Uint8List转换为Image对象
Image imageFromUint8List(ty.Uint8List bytes) {
  return Image.memory(bytes);
}
