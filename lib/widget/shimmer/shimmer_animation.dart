import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget shimmer(Widget widget, Color color) {
  return widget
      .animate(onPlay: (controller) => controller.repeat())
      .shimmer(duration: 3200.ms, color: color)
      .animate() // this wraps the previous Animate in another Animate
      .fadeIn(duration: 3200.ms, curve: Curves.easeOutQuad)
      .slide();
}

Widget shimmer1(Widget widget, Color color) {
  return widget
      .animate(onPlay: (controller) => controller.repeat())
      .shimmer(duration: 3200.ms, color: color)
      .animate() // this wraps the previous Animate in another Animate
      .slide();
}
