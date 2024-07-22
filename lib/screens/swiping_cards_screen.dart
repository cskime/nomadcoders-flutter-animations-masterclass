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
    final shouldDismissed = _animationController.value.abs() >= bound;

    if (!shouldDismissed) {
      _animationController.animateTo(0, curve: Curves.easeOut);
      return;
    }

    final goLeft = _animationController.value.isNegative;
    double target = (size.width + 100) * (goLeft ? -1 : 1);

    _animationController
        .animateTo(target, curve: Curves.easeOut)
        .whenComplete(() {
      _animationController.value = 0;
      setState(() {
        _index = (_index == 5 ? 1 : _index + 1);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  var _index = 1;

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
                  scale: min(scale, 1.0),
                  child: Card(
                    index: _index == 5 ? 1 : _index + 1,
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
                      child: Card(index: _index),
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

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Image.asset(
          "assets/covers/album-$index.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
