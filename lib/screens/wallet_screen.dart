import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _expanded = false;

  void _onExpand() {
    setState(() {
      _expanded = true;
    });
  }

  void _onShrink() {
    setState(() {
      _expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: _onExpand,
          onVerticalDragEnd: (_) => _onShrink(),
          child: Column(
            children: [
              CreditCard(
                backgroundColor: Colors.purple,
                expanded: _expanded,
              )
                  .animate(
                    target: _expanded ? 0 : 1,
                    delay: 1.5.seconds,
                  )
                  .flipV(end: 0.1),
              CreditCard(
                backgroundColor: Colors.black,
                expanded: _expanded,
              )
                  .animate(
                    target: _expanded ? 0 : 1,
                    delay: 1.5.seconds,
                  )
                  .flipV(end: 0.1)
                  .slideY(end: -0.8),
              CreditCard(
                backgroundColor: Colors.green,
                expanded: _expanded,
              )
                  .animate(
                    target: _expanded ? 0 : 1,
                    delay: 1.5.seconds,
                  )
                  .flipV(end: 0.1)
                  .slideY(end: -1.6),
            ]
                .animate(interval: 500.ms)
                .fadeIn(begin: 0)
                .slideX(begin: -1, end: 0),
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
    required this.backgroundColor,
    required this.expanded,
  });

  final Color backgroundColor;
  final bool expanded;

  void _onTap() {
    print("Tapped");
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !expanded,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: backgroundColor,
          ),
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomad Coders",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "**** **** **75",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
