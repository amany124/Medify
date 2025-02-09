import 'package:flutter/material.dart';

class InnerShadow extends StatelessWidget {
  final Widget child;
  final double offsetX;
  final double offsetY;
  final double blurRadius;
  final Color color;

  const InnerShadow({
    super.key,
    required this.child,
    this.offsetX = 0.0,
    this.offsetY = 0.0,
    this.blurRadius = 10.0,
    this.color = Colors.black26,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [color.withValues(alpha: .25), Colors.transparent],
                stops: [0.0, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff577CEF),
                boxShadow: [
                  BoxShadow(
                    color: color,
                    offset: Offset(offsetX, offsetY),
                    blurRadius: blurRadius,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
