import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Widget child;
  final Function(String) onImageSelected;

  const ImagePickerWidget({
    Key? key,
    required this.child,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _openModalBottomSheet();
    super.initState();
  }

  Future<void> _openModalBottomSheet() async {
    if (!mounted) return;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 161 + MediaQuery.of(context).padding.bottom,
          color: Color.fromRGBO(245, 245, 245, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildOptionItem('相机', () => _getImage(ImageSource.camera)),
              Padding(
                padding: EdgeInsets.only(top: 1),
                child: _buildOptionItem(
                    '相册', () => _getImage(ImageSource.gallery)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: _buildOptionItem('取消', () => Navigator.pop(context)),
              ),
            ],
          ),
        );
      },
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

  Future<void> _getImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 400,
    );
    if (pickedFile != null && mounted) {
      widget.onImageSelected(pickedFile.path);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openModalBottomSheet();
      },
      child: widget.child,
    );
  }
}
