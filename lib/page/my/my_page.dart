import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baby_time/widget/base_stack/base_stack.dart';
import 'package:flutter_baby_time/widget/container/container_wrapper_card.dart';
import 'package:timelines_plus/timelines_plus.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    List<_TimelineStatus> data = [
      _TimelineStatus.done,
      _TimelineStatus.inProgress,
      _TimelineStatus.inProgress,
      _TimelineStatus.inProgress,
      _TimelineStatus.inProgress,
      _TimelineStatus.inProgress,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
      _TimelineStatus.todo,
    ];

    return GreyBaseScaffoldStack(
        title: '',
        appBarSize: 0,
        child: ContainerWrapperCard(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: FixedTimeline.tileBuilder(
                  builder: TimelineTileBuilder.connectedFromStyle(
                    contentsAlign: ContentsAlign.basic,
                    oppositeContentsBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('opposite\ncontents'),
                    ),
                    contentsBuilder: (context, index) => const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Contents'),
                      ),
                    ),
                    connectorStyleBuilder: (context, index) =>
                        ConnectorStyle.solidLine,
                    indicatorStyleBuilder: (context, index) =>
                        IndicatorStyle.dot,
                    itemCount: 100,
                  ),
                ),
              ),
            )));
  }
}

const kTileHeight = 50.0;

class _EmptyContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: const Color(0xffe6e7e9),
      ),
    );
  }
}

enum _TimelineStatus {
  done,
  sync,
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}
