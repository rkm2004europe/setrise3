import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/map_story_model.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<MapStoryModel> stories;
  final int initialIndex;
  const StoryViewerScreen({super.key, required this.stories, required this.initialIndex});

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> with SingleTickerProviderStateMixin {
  late PageController _pageCtrl;
  late int _currentIndex;
  late AnimationController _progressCtrl;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageCtrl = PageController(initialPage: _currentIndex);
    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() => _progress = _progressCtrl.value);
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _next();
      });
    _progressCtrl.forward();
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentIndex < widget.stories.length - 1) {
      _pageCtrl.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pop(context);
    }
  }

  void _previous() {
    if (_currentIndex > 0) {
      _pageCtrl.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < width / 2) {
            _previous();
          } else {
            _next();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageCtrl,
              itemCount: widget.stories.length,
              onPageChanged: (i) {
                setState(() => _currentIndex = i);
                _progressCtrl.reset();
                _progressCtrl.forward();
              },
              itemBuilder: (_, i) {
                final s = widget.stories[i];
                return Container(
                  color: MapColors.surface,
                  child: Center(
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(s.avatar, style: const TextStyle(fontSize: 80)),
                      const SizedBox(height: 16),
                      Text(s.userName, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text(s.locationName, style: const TextStyle(color: Colors.white70)),
                    ]),
                  ),
                );
              },
            ),
            // شريط التقدم
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Row(
                  children: List.generate(widget.stories.length, (i) {
                    return Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: i < _currentIndex
                            ? Container(color: Colors.white)
                            : i == _currentIndex
                                ? FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: _progress,
                                    child: Container(color: Colors.white),
                                  )
                                : null,
                      ),
                    );
                  }),
                ),
              ),
            ),
            // زر الإغلاق
            Positioned(
              top: 50,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                  child: const Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
