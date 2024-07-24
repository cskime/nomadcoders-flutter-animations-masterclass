import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeThroughScreen extends StatefulWidget {
  const FadeThroughScreen({super.key});

  @override
  State<FadeThroughScreen> createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  int _navigationIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _navigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fade Through"),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: [
          const NavigationPage(
            key: ValueKey(0),
            text: "Profile",
            icon: Icons.person_rounded,
          ),
          const NavigationPage(
            key: ValueKey(1),
            text: "Notifications",
            icon: Icons.notifications_rounded,
          ),
          const NavigationPage(
            key: ValueKey(2),
            text: "Settings",
            icon: Icons.settings_rounded,
          ),
        ][_navigationIndex],
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.amber,
        selectedIndex: _navigationIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_rounded),
            selectedIcon: Icon(Icons.notifications_rounded),
            label: "Notifications",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            selectedIcon: Icon(Icons.settings_rounded),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class NavigationPage extends StatelessWidget {
  const NavigationPage({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            Text(text, style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
