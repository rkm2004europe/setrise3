import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class CallScreen extends StatefulWidget {
  final User user;
  final bool isVideo;
  const CallScreen({super.key, required this.user, required this.isVideo});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with TickerProviderStateMixin {
  late AnimationController _pulseCtrl;
  bool _isMuted = false, _isSpeaker = false, _isConnected = false;
  Duration _duration = Duration.zero;
  String _status = 'جارٍ الاتصال...';

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat();
    _simConnect();
  }

  @override
  void dispose() { _pulseCtrl.dispose(); super.dispose(); }

  void _simConnect() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _status = 'رنين...');
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    setState(() { _isConnected = true; _status = 'متصل'; });
    _pulseCtrl.stop();
    _startTimer();
  }

  void _startTimer() async {
    while (mounted && _isConnected) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && _isConnected) setState(() => _duration += const Duration(seconds: 1));
    }
  }

  String get _durText => '${_duration.inMinutes.toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // صورة + تأثير نبض
            AnimatedBuilder(
              animation: _pulseCtrl,
              builder: (_, child) => Stack(
                alignment: Alignment.center,
                children: [
                  if (!_isConnected) ...[
                    Transform.scale(scale: 1.0 + _pulseCtrl.value * 0.8, child: Container(width: 110, height: 110, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.08)))),
                    Transform.scale(scale: 1.0 + _pulseCtrl.value * 0.5, child: Container(width: 110, height: 110, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.12)))),
                  ],
                  Container(width: 110, height: 110, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.1), border: Border.all(color: Colors.white.withOpacity(0.2), width: 2)), child: Center(child: Text(widget.user.avatar, style: const TextStyle(fontSize: 56)))),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(widget.user.name, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
            Text(_status, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16)),
            if (_isConnected) Text(_durText, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const Spacer(),
            // أزرار تحكم
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Btn(icon: _isMuted ? Icons.mic_off : Icons.mic, label: 'كتم', active: _isMuted, onTap: () => setState(() => _isMuted = !_isMuted)),
                  _Btn(icon: _isSpeaker ? Icons.volume_up : Icons.volume_down, label: 'صوت', active: _isSpeaker, onTap: () => setState(() => _isSpeaker = !_isSpeaker)),
                  _Btn(icon: Icons.call_end, label: '', isEnd: true, onTap: () => Navigator.pop(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap; final bool active, isEnd;
  const _Btn({required this.icon, required this.label, required this.onTap, this.active = false, this.isEnd = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58, height: 58,
            decoration: BoxDecoration(
              color: isEnd ? const Color(0xFFFF3B30) : (active ? Colors.white : Colors.white.withOpacity(0.15)),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isEnd ? Colors.white : (active ? Colors.black : Colors.white), size: 24),
          ),
          if (label.isNotEmpty) ...[const SizedBox(height: 6), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11))],
        ],
      ),
    );
  }
}
