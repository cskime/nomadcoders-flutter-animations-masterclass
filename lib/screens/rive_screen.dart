import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  late StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController = StateMachineController.fromArtboard(
      artboard,
      "state",
      onStateChange: (stateMachineName, stateName) {
        print(stateMachineName);
        print(stateName);
      },
    )!;
    artboard.addController(_stateMachineController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rive"),
      ),
      body: Stack(
        children: [
          RiveAnimation.asset(
            "assets/animations/custom-button-animation.riv",
            artboard: "main",
            stateMachines: const ["state"],
            onInit: _onInit,
          ),
          const Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
