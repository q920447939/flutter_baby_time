import 'package:flutter/material.dart';

import 'height_weight_manager_parent.dart';

class WeightRecord extends HeightWeightManagerParent {
  const WeightRecord({Key? key}) : super(key: key);

  @override
  _WeightRecordState createState() => _WeightRecordState();
}

class _WeightRecordState extends State<WeightRecord> {
  @override
  Widget build(BuildContext context) {
    return Text('体重记录');
  }
}
