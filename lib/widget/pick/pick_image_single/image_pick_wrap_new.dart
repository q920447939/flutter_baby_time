import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../router/has_bottom_navigator/shell_default_router.dart';
import '../../image_edit/image_edit_type.dart';

class ImagePickerWrapperNew {
  final ImagePicker _picker = ImagePicker();
  final BuildContext context;
  ImagePickerWrapperNew({required this.context});

  selectImage() {
    Navigator.of(context).push(
      TDSlidePopupRoute(
          modalBarrierColor: TDTheme.of(context).fontGyColor2,
          slideTransitionFrom: SlideTransitionFrom.bottom,
          builder: (context) {
            return TDPopupBottomDisplayPanel(
              title: '请选择上传类型',
              hideClose: false,
              closeClick: () {
                Navigator.maybePop(context);
              },
              child: Container(
                height: 150.w,
                margin: EdgeInsets.only(top: 20.h),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildOptionItem(
                        '相册',
                        () async {
                          var imagePath = await _getImage(ImageSource.gallery);
                          SmartDialog.showToast("imagePath is  $imagePath");
                          print("imagePath is  $imagePath");
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1),
                        child: _buildOptionItem(
                          '相机',
                          () => _getImage(ImageSource.camera),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildOptionItem(String title, VoidCallback onTap) {
    return GestureDetector(
      child: _itemCreate(title),
      onTap: onTap,
    );
  }

  Widget _itemCreate(String title) {
    return Container(
      color: Colors.white,
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<String> _getImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 400,
    );
    if (pickedFile != null && context.mounted) {
      Navigator.pop(context);
      return pickedFile.path;
    }
    return '';
  }

  imageEdit(String imagePath) async {
    // 这里可以添加您的图片处理逻辑
    var url = await ImageEditorPageRouter(
      filePath: imagePath,
      imageEditType: ImageEditType.default_,
      imageEditCropLayerType: ImageEditCropLayerType.rectangle,
    ).push(context);
    return url;
  }
}
