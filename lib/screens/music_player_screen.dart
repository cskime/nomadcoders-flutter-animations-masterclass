import 'dart:ui';

import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final _pageController = PageController(viewportFraction: 0.8);

  int _currentPage = 0;

  final _scrollOffset = ValueNotifier<double>(0);

  void _onPageChanged(int value) {
    setState(() {
      _currentPage = value;
    });
  }

  void _onAlbumTap(int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: MusicPlayerDetailScreen(index: index),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(
      () {
        if (_pageController.page == null) {
          return;
        }
        _scrollOffset.value = _pageController.page!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // switcher 동작 시 흰색 없애기
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Container(
                key: ValueKey(_currentPage),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/covers/album-${_currentPage + 1}.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                  valueListenable: _scrollOffset,
                  builder: (context, value, child) {
                    final difference = (value - index).abs() * 0.1;
                    final scale = 1 - difference;
                    return GestureDetector(
                      onTap: () => _onAlbumTap(index),
                      child: Hero(
                        tag: index,
                        child: Transform.scale(
                          scale: scale,
                          child: Container(
                            height: 350,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/covers/album-${index + 1}.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 8),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                const Text(
                  "Taylor Swift",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Taylor Swift",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MusicPlayerDetailScreen extends StatefulWidget {
  const MusicPlayerDetailScreen({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taylor Swift"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: widget.index,
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/covers/album-${widget.index + 1}.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          CustomPaint(
            size: Size(screenSize.width - 80, 5),
            painter: ProgressBarPainter(progressValue: 180),
          )
        ],
      ),
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  ProgressBarPainter({
    super.repaint,
    required this.progressValue,
  });

  final double progressValue;

  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()..color = Colors.grey.shade300;
    final trackRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(10),
    );
    canvas.drawRRect(trackRect, trackPaint);

    final progressPaint = Paint()..color = Colors.grey.shade500;
    final progressRect = RRect.fromLTRBR(
      0,
      0,
      progressValue,
      size.height,
      const Radius.circular(10),
    );
    canvas.drawRRect(progressRect, progressPaint);

    canvas.drawCircle(
      Offset(progressValue, size.height / 2),
      10,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
