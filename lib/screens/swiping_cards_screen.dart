import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.sizeOf(context);
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
    value: 0,
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
  );

  late final _rotation = Tween<double>(begin: -15, end: 15);
  late final _scale = Tween<double>(begin: 0.8, end: 1);

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _animationController.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    double target =
        _animationController.value.abs() >= bound ? size.width + 100 : 0;
    final goLeft = _animationController.value.isNegative;
    _animationController.animateTo(
      target * (goLeft ? -1 : 1),
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swiping Cards"),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          // Animation value를 0 ~ 1 사이 값으로 정규화
          final angle = _rotation.transform(
            (_animationController.value / 2 + size.width / 2) / size.width,
          );
          final scale = _scale.transform(
            _animationController.value.abs() / size.width,
          );
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  scale: scale,
                  child: Material(
                    elevation: 10,
                    color: Colors.blue.shade100,
                    child: SizedBox(
                      width: size.width * 0.8,
                      height: size.height * 0.5,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Transform.translate(
                    offset: Offset(_animationController.value, 0),
                    child: Transform.rotate(
                      angle: angle * pi / 180,
                      child: Material(
                        elevation: 10,
                        color: Colors.red.shade100,
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
