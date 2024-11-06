import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../widget/edit_image/common_widget.dart';

class ImageEditButtonController extends StatefulWidget {
  GlobalKey<ExtendedImageEditorState> editorKey;

  ImageEditButtonController({super.key, required this.editorKey});

  @override
  State<ImageEditButtonController> createState() =>
      _ImageEditButtonControllerState();
}

class _ImageEditButtonControllerState extends State<ImageEditButtonController> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //color: Colors.lightBlue,
      shape: const CircularNotchedRectangle(),
      child: ButtonTheme(
        minWidth: 0.0,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            /*FlatButtonWithIcon(
                icon: const Icon(Icons.crop),
                label: const Text(
                  'Crop',
                  style: TextStyle(fontSize: 10.0),
                ),
                textColor: Colors.white,
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: <Widget>[
                            const Expanded(
                              child: SizedBox(),
                            ),
                            */ /*SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.all(20.0),
                                itemBuilder: (_, int index) {
                                  final AspectRatioItem item =
                                      _aspectRatios[index];
                                  return GestureDetector(
                                    child: AspectRatioWidget(
                                      aspectRatio: item.value,
                                      aspectRatioS: item.text,
                                      isSelected: item == _aspectRatio,
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _aspectRatio = item;
                                      });
                                    },
                                  );
                                },
                                itemCount: _aspectRatios.length,
                              ),
                            ),*/ /*
                          ],
                        );
                      });
                },
              ),*/
            FlatButtonWithIcon(
              icon: const Icon(Icons.flip),
              label: const Text(
                '翻转',
                style: TextStyle(fontSize: 10.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                widget.editorKey.currentState!.flip();
              },
            ),
            FlatButtonWithIcon(
              icon: const Icon(Icons.rotate_left),
              label: const Text(
                '向左旋转',
                style: TextStyle(fontSize: 8.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                widget.editorKey.currentState!.rotate(right: false);
              },
            ),
            FlatButtonWithIcon(
              icon: const Icon(Icons.rotate_right),
              label: const Text(
                '向右旋转',
                style: TextStyle(fontSize: 8.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                widget.editorKey.currentState!.rotate(right: true);
              },
            ),
            FlatButtonWithIcon(
              icon: const Icon(Icons.restore),
              label: const Text(
                '重置',
                style: TextStyle(fontSize: 10.0),
              ),
              textColor: Colors.white,
              onPressed: () {
                widget.editorKey.currentState!.reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
