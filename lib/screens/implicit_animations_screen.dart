import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: ColorTween(
                begin: _visible ? Colors.red : Colors.black,
                end: _visible ? Colors.black : Colors.red,
              ),
              duration: const Duration(seconds: 5),
              curve: Curves.bounceInOut,
              builder: (context, value, child) {
                return Icon(
                  Icons.apple,
                  size: 60,
                  color: value,
                );
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text("Go"),
            ),
          ],
        ),
      ),
    );
  }
}
