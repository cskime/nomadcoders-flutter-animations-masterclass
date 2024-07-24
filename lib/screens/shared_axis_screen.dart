import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisScreen extends StatefulWidget {
  const SharedAxisScreen({super.key});

  @override
  State<SharedAxisScreen> createState() => _SharedAxisScreenState();
}

class _SharedAxisScreenState extends State<SharedAxisScreen> {
  int _currentImageIndex = 1;

  void _goToImage(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Axis"),
      ),
      body: Column(
        children: [
          PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            ),
            child: Container(
              key: ValueKey(_currentImageIndex),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.hardEdge,
              child: Image.asset("assets/covers/album-$_currentImageIndex.png"),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final index in [1, 2, 3, 4, 5])
                ElevatedButton(
                  onPressed: () => _goToImage(index),
                  child: Text("$index"),
                ),
            ],
          )
        ],
      ),
    );
  }
}
