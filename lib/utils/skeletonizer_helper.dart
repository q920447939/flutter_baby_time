import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonizerWidget extends StatefulWidget {
  const SkeletonizerWidget({super.key});

  @override
  State<SkeletonizerWidget> createState() => _SkeletonizerState();
}

class _SkeletonizerState extends State<SkeletonizerWidget> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
