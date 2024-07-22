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
    duration: const Duration(milliseconds: 500),
    value: 0,
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
  );

  late final _rotation = Tween<double>(begin: -15, end: 15);
  late final _cardScale = Tween<double>(begin: 0.8, end: 1);
  late final _buttonScale = Tween<double>(begin: 1, end: 1.2);
  late final _closeButtonColor = ColorTween(
    begin: Colors.red,
    end: Colors.white,
  );
  late final _checkButtonColor = ColorTween(
    begin: Colors.green,
    end: Colors.white,
  );

  var _animating = false;

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

    _animateTo(target);
  }

  void _closeButtonPressed() {
    if (_animating) {
      return;
    }

    _animateTo(-(size.width + 100));
  }

  void _checkButtonPressed() {
    if (_animating) {
      return;
    }

    _animateTo(size.width + 100);
  }

  void _animateTo(double target) {
    _animating = true;
    _animationController
        .animateTo(target, curve: Curves.easeOut)
        .whenComplete(() {
      _animating = false;
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

          final animationValue = _animationController.value.abs() / size.width;
          final cardScale = min(
            1.0,
            _cardScale.transform(animationValue),
          );
          final buttonScale = min(
            1.2,
            _buttonScale.transform(animationValue),
          );
          final checkIconColor = _checkButtonColor.transform(animationValue);
          final checkBackgroundColor =
              _checkButtonColor.transform(1 - animationValue);
          final closeIconColor = _closeButtonColor.transform(animationValue);
          final closeBackgroundColor =
              _closeButtonColor.transform(1 - animationValue);

          final isLeft = _animationController.value < 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              SizedBox(
                height: size.height * 0.5,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      child: Transform.scale(
                        scale: min(cardScale, 1.0),
                        child: Card(
                          index: _index == 5 ? 1 : _index + 1,
                        ),
                      ),
                    ),
                    Positioned(
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
                ),
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.scale(
                    scale: isLeft ? buttonScale : 1,
                    child: _Button(
                      iconData: Icons.close,
                      iconColor: isLeft ? closeIconColor : Colors.red,
                      backgroundColor:
                          isLeft ? closeBackgroundColor : Colors.white,
                      onPressed: _closeButtonPressed,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Transform.scale(
                    scale: isLeft ? 1 : buttonScale,
                    child: _Button(
                      iconData: Icons.check,
                      iconColor: isLeft ? Colors.green : checkIconColor,
                      backgroundColor:
                          isLeft ? Colors.white : checkBackgroundColor,
                      onPressed: _checkButtonPressed,
                    ),
                  ),
                ],
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

class _Button extends StatelessWidget {
  const _Button({
    required this.iconData,
    this.iconColor,
    this.backgroundColor,
    this.onPressed,
  });

  final IconData iconData;
  final Color? iconColor;
  final Color? backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 4),
              shape: BoxShape.circle),
          child: Icon(
            iconData,
            color: iconColor,
            size: 40,
          ),
        ),
      ),
    );
  }
}
