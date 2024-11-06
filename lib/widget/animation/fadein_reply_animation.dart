import 'package:flutter/cupertino.dart';

class RepeatingAnimationWidget extends StatefulWidget {
  final Widget child;
  final double startY;
  final double endY;
  final Duration duration;

  const RepeatingAnimationWidget({
    Key? key,
    required this.child,
    required this.startY,
    required this.endY,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _RepeatingAnimationWidgetState createState() =>
      _RepeatingAnimationWidgetState();
}

class _RepeatingAnimationWidgetState extends State<RepeatingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: widget.startY,
      end: widget.endY,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          bottom: _animation.value,
          child: Opacity(
            opacity: 1 -
                (_animation.value - widget.endY) /
                    (widget.startY - widget.endY),
            child: widget.child,
          ),
        );
      },
    );
  }
}
