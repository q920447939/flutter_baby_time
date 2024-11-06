import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget textShimmer(Widget text) {
  return text
      .animate(onPlay: (controller) => controller.repeat())
      .shimmer(duration: 3200.ms, color: const Color(0xFF80DDFF))
      .animate() // this wraps the previous Animate in another Animate
      .fadeIn(duration: 3200.ms, curve: Curves.easeOutQuad)
      .slide();
}
