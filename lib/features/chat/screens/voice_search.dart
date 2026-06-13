import 'package:flutter/material.dart';
import '../theme/colors.dart';

class VoiceSearchScreen extends StatefulWidget {
  const VoiceSearchScreen({super.key});

  @override
  State<VoiceSearchScreen> createState() => _VoiceSearchScreenState();
}

class _VoiceSearchScreenState extends State<VoiceSearchScreen> with SingleTickerProviderStateMixin {
  bool _listening = false;
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
  }

  @override
  void dispose() { _pulse.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => setState(() => _listening = !_listening),
                child: AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, child) => Transform.scale(
                    scale: _listening ? 1.0 + _pulse.value * 0.3 : 1.0,
                    child: Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(color: _listening ? Colors.redAccent : ChatColors.accent, shape: BoxShape.circle),
                      child: const Icon(Icons.mic, color: Colors.white, size: 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(_listening ? 'استمع...' : 'اضغط للتحدث', style: const TextStyle(color: ChatColors.text, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
