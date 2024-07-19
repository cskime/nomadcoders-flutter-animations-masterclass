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
    duration: const Duration(seconds: 1),
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  Tween<double> nextRandomTween({double begin = 0.005}) => Tween(
        begin: begin,
        end: Random().nextDouble() * 2,
      );

  late var _redProgress = nextRandomTween().animate(_animation);
  late var _greenProgress = nextRandomTween().animate(_animation);
  late var _blueProgress = nextRandomTween().animate(_animation);

  void _onAnimationPressed() {
    setState(() {
      _redProgress = nextRandomTween(
        begin: _redProgress.value,
      ).animate(_animation);
      _greenProgress = nextRandomTween(
        begin: _greenProgress.value,
      ).animate(_animation);
      _blueProgress = nextRandomTween(
        begin: _blueProgress.value,
      ).animate(_animation);
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
          animation: _redProgress,
          builder: (context, child) => AnimatedBuilder(
            animation: _greenProgress,
            builder: (context, child) => AnimatedBuilder(
              animation: _blueProgress,
              builder: (context, child) => CustomPaint(
                painter: AppleWatchPainter(
                  redProgress: _redProgress.value,
                  greenProgress: _greenProgress.value,
                  blueProgress: _blueProgress.value,
                ),
                size: const Size(400, 400),
              ),
            ),
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
    required this.redProgress,
    required this.greenProgress,
    required this.blueProgress,
  });

  final double redProgress;
  final double greenProgress;
  final double blueProgress;

  final _strokeWidth = 24.0;

  void _drawCircle({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required Color color,
  }) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    canvas.drawCircle(center, radius, paint);
  }

  void _drawArc({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required Color color,
    required double progress,
  }) {
    const startingAngle = -0.5 * pi;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      rect,
      startingAngle,
      progress * pi,
      false,
      paint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final colors = [
      Colors.red.shade400,
      Colors.green.shade400,
      Colors.blue.shade400,
    ];
    final radiuses =
        [0.9, 0.75, 0.6].map((ratio) => size.width / 2 * ratio).toList();
    final progresses = [
      redProgress,
      greenProgress,
      blueProgress,
    ];

    for (int index = 0; index < colors.length; index++) {
      _drawCircle(
        canvas: canvas,
        center: center,
        radius: radiuses[index],
        color: colors[index].withOpacity(0.3),
      );

      _drawArc(
        canvas: canvas,
        center: center,
        radius: radiuses[index],
        color: colors[index],
        progress: progresses[index],
      );
    }
  }

  @override
  bool shouldRepaint(AppleWatchPainter oldDelegate) {
    return redProgress != oldDelegate.redProgress ||
        greenProgress != oldDelegate.greenProgress ||
        blueProgress != oldDelegate.blueProgress;
  }
}
