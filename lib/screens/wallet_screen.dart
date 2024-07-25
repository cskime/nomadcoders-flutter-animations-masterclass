import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

List<Color> _colors = [Colors.black, Colors.purple, Colors.blue];

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
              for (final index in [0, 1, 2])
                Hero(
                  tag: index,
                  child: CreditCard(
                    index: index,
                    expanded: _expanded,
                  )
                      .animate(
                        target: _expanded ? 0 : 1,
                        delay: 1.5.seconds,
                      )
                      .flipV(end: 0.1)
                      .slideY(end: -0.8 * index),
                ),
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
    required this.index,
    required this.expanded,
  });

  final int index;
  final bool expanded;

  void _onTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true, // 아래 -> 위로 나타나게 만들기
        builder: (context) => CardDetailScreen(index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AbsorbPointer(
        absorbing: !expanded,
        child: GestureDetector(
          onTap: () => _onTap(context),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _colors[index],
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
      ),
    );
  }
}

class CardDetailScreen extends StatelessWidget {
  const CardDetailScreen({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: index,
              child: CreditCard(index: index, expanded: false),
            ),
          ],
        ),
      ),
    );
  }
}
