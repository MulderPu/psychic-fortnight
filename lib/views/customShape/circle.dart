import 'package:flutter/material.dart';

class CircleOne extends CustomPainter {
  Paint? _paint;

  CircleOne() {
    _paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(-110.0, -70.0), 100.0, _paint!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint? _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(const Offset(100.0, 70.0), 50.0, _paint!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
