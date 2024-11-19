import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'height_weight_manager_parent.dart';

class HeightRecord extends HeightWeightManagerParent {
  const HeightRecord({super.key});

  @override
  State<HeightRecord> createState() => _HeightRecordState();
}

class _HeightRecordState extends State<HeightRecord> {
  int selectedHeight = 160;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Text(
          "选择的身高: $selectedHeight cm",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Container(
          height: 200,
          child: CupertinoPicker(
            scrollController:
                FixedExtentScrollController(initialItem: selectedHeight - 100),
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              setState(() {
                selectedHeight = index + 100;
              });
            },
            children: List<Widget>.generate(121, (index) {
              return Center(
                child: Text("${index + 100} cm"),
              );
            }),
          ),
        ),
      ],
    );
  }
}
