import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  late var _progress = Tween(
    begin: 0.005,
    end: 2.0,
  ).animate(_animation);

  void _onAnimationPressed() {
    final newBegin = _progress.value;
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;
    final newTween = Tween(
      begin: newBegin,
      end: newEnd,
    ).animate(_animation);

    setState(() {
      _progress = newTween;
      _animationController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Apple Watch"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _progress,
          builder: (context, child) => CustomPaint(
            painter: AppleWatchPainter(
              progress: _progress.value,
            ),
            size: const Size(400, 400),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAnimationPressed,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  AppleWatchPainter({
    super.repaint,
    required this.progress,
  });

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final redCircleRadius = size.width / 2 * 0.9;
    final redCirclePaint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;
    canvas.drawCircle(center, redCircleRadius, redCirclePaint);

    final greenCircleRadius = size.width / 2 * 0.75;
    final greenCirclePaint = Paint()
      ..color = Colors.green.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;
    canvas.drawCircle(center, greenCircleRadius, greenCirclePaint);

    final blueCircleRadius = size.width / 2 * 0.6;
    final blueCirclePaint = Paint()
      ..color = Colors.blue.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24;
    canvas.drawCircle(center, blueCircleRadius, blueCirclePaint);

    const startingAngle = -0.5 * pi;

    final redArcRect = Rect.fromCircle(
      center: center,
      radius: redCircleRadius,
    );
    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      redArcRect,
      startingAngle,
      progress * pi,
      false,
      redArcPaint,
    );

    final greenArcRect = Rect.fromCircle(
      center: center,
      radius: greenCircleRadius,
    );
    final greenArcPaint = Paint()
      ..color = Colors.green.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      greenArcRect,
      startingAngle,
      progress * pi,
      false,
      greenArcPaint,
    );

    final blueArcRect = Rect.fromCircle(
      center: center,
      radius: blueCircleRadius,
    );
    final blueArcPaint = Paint()
      ..color = Colors.blue.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      blueArcRect,
      startingAngle,
      progress * pi,
      false,
      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(AppleWatchPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
