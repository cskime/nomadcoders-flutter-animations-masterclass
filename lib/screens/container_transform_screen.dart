import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ContainerTransformScreen extends StatefulWidget {
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGrid = false;

  void _toggleGrid() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Container Transform"),
        actions: [
          IconButton(
            onPressed: _toggleGrid,
            icon: const Icon(Icons.grid_4x4_rounded),
          ),
        ],
      ),
      body: _isGrid
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: 20,
              itemBuilder: (context, index) {
                final imageIndex = (index % 5) + 1;
                return OpenContainer(
                  transitionDuration: const Duration(milliseconds: 500),
                  openBuilder: (context, action) =>
                      DetailScreen(imageIndex: imageIndex),
                  closedBuilder: (context, action) => Column(
                    children: [
                      Image.asset("assets/covers/album-$imageIndex.png"),
                      const Text("Dune Soundtrack"),
                      const Text(
                        "Hans Zimmer",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final imageIndex = (index % 5) + 1;
                return OpenContainer(
                  transitionDuration: const Duration(seconds: 1),
                  openBuilder: (context, action) =>
                      DetailScreen(imageIndex: imageIndex),
                  closedBuilder: (context, action) => ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/covers/album-$imageIndex.png",
                          ),
                        ),
                      ),
                    ),
                    title: const Text("Dune Soundtrack"),
                    subtitle: const Text("Hans Zimmer"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: 20,
            ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.imageIndex,
  });

  final int imageIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail screen"),
      ),
      body: Column(
        children: [
          Image.asset("assets/covers/album-$imageIndex.png"),
          const Text(
            "Detail Screen",
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
