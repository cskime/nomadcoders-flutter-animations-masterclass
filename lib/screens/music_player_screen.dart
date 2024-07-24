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

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  late final _progressController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat();

  late final _marqueeController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 30),
  )..repeat(reverse: true);
  late final _marqueeTween = Tween<Offset>(
    begin: const Offset(0.1, 0),
    end: const Offset(-1.0, 0),
  ).animate(_marqueeController);

  late final _playPauseController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void dispose() {
    _progressController.dispose();
    _marqueeController.dispose();
    super.dispose();
  }

  String _timeStringFromDuration(Duration duration) {
    final durationString = duration.toString();
    return durationString
        .split(".")
        .first
        .substring(durationString.indexOf(":") + 1);
  }

  Duration get _fromDuration =>
      Duration.zero +
      Duration(
        seconds: (_progressController.value *
                _progressController.duration!.inSeconds)
            .toInt(),
      );
  Duration get _toDuration => Duration(
        seconds: ((1 - _progressController.value) *
                _progressController.duration!.inSeconds)
            .toInt(),
      );

  void _onPlayPauseTap() {
    if (_playPauseController.isCompleted) {
      _playPauseController.reverse();
    } else {
      _playPauseController.forward();
    }
  }

  bool _dragging = false;

  void _toggleDragging() {
    setState(() {
      _dragging = !_dragging;
    });
  }

  late final screenSize = MediaQuery.sizeOf(context);

  final _volume = ValueNotifier<double>(0);

  void _onVolumeUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx;
    _volume.value = _volume.value.clamp(0, screenSize.width - 80);
  }

  void _onMenuPressed() {
    print("toggleMenu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Taylor Swift"),
        actions: [
          IconButton(
            onPressed: _onMenuPressed,
            icon: const Icon(Icons.menu),
          ),
        ],
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
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomPaint(
                  size: Size(screenSize.width - 80, 5),
                  painter: ProgressBarPainter(
                    progress: _progressController.value,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Text(
                        _timeStringFromDuration(_fromDuration),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "-${_timeStringFromDuration(_toDuration)}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Taylor Swift",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          SlideTransition(
            position: _marqueeTween,
            child: const Text(
              "A Film By Christoher Nolan - Original Motion Picture Soundtrack",
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _onPlayPauseTap,
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              size: 60,
              progress: _playPauseController,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onHorizontalDragStart: (_) => _toggleDragging(),
            onHorizontalDragEnd: (_) => _toggleDragging(),
            onHorizontalDragUpdate: _onVolumeUpdate,
            child: AnimatedScale(
              scale: _dragging ? 1.1 : 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.bounceOut,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ValueListenableBuilder(
                  valueListenable: _volume,
                  builder: (context, value, child) => CustomPaint(
                    size: Size(screenSize.width - 80, 50),
                    painter: VolumePainter(volume: value),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  ProgressBarPainter({
    super.repaint,
    required this.progress,
  });

  final double progress;

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

    final progressValue = size.width * progress;
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
  bool shouldRepaint(covariant ProgressBarPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class VolumePainter extends CustomPainter {
  VolumePainter({
    super.repaint,
    required this.volume,
  });

  final double volume;

  @override
  void paint(Canvas canvas, Size size) {
    final trackPaint = Paint()..color = Colors.grey.shade300;
    final trackRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(trackRect, trackPaint);

    final volumePaint = Paint()..color = Colors.grey.shade500;
    final volumeRect = Rect.fromLTWH(0, 0, volume, size.height);
    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePainter oldDelegate) {
    return volume != oldDelegate.volume;
  }
}
