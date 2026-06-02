// lib/features/live/screens/go_live_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({super.key});

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl  = TextEditingController();
  String _privacy  = 'public';
  bool _isLoading  = false;

  @override
  void dispose() { _titleCtrl.dispose(); _descCtrl.dispose(); super.dispose(); }

  Future<void> _goLive() async {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a title'), backgroundColor: Colors.red));
      return;
    }
    setState(() => _isLoading = true);
    HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        surfaceTintColor: Colors.transparent,
        title: const Text('Go Live', style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          // Camera Preview
          Container(height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.1))),
            child: Stack(alignment: Alignment.center, children: [
              const Icon(Icons.videocam_rounded, size: 64, color: Colors.white24),
              Positioned(bottom: 12, right: 12,
                child: Container(padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(6)),
                  child: const Row(children: [
                    Icon(Icons.circle, color: Colors.white, size: 6),
                    SizedBox(width: 4),
                    Text('LIVE', style: TextStyle(color: Colors.white,
                      fontSize: 10, fontWeight: FontWeight.w900, fontFamily: 'Inter')),
                  ]))),
            ])),

          const SizedBox(height: 24),

          // Title
          const Text('Stream Title', style: TextStyle(color: Colors.white,
            fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          const SizedBox(height: 8),
          _Field(ctrl: _titleCtrl, hint: 'Enter stream title...', maxLength: 100),

          const SizedBox(height: 20),

          // Description
          const Text('Description', style: TextStyle(color: Colors.white,
            fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          const SizedBox(height: 8),
          _Field(ctrl: _descCtrl, hint: 'Describe your stream...', maxLines: 3, maxLength: 300),

          const SizedBox(height: 20),

          // Privacy
          const Text('Privacy', style: TextStyle(color: Colors.white,
            fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          const SizedBox(height: 8),
          _PrivacyOption(value: 'public', selected: _privacy,
            label: 'Public', sub: 'Anyone can watch',
            icon: Icons.public_rounded,
            onTap: () => setState(() => _privacy = 'public')),
          const SizedBox(height: 8),
          _PrivacyOption(value: 'followers', selected: _privacy,
            label: 'Followers Only', sub: 'Only your followers',
            icon: Icons.people_rounded,
            onTap: () => setState(() => _privacy = 'followers')),

          const SizedBox(height: 32),

          // Go Live Button
          GestureDetector(
            onTap: _isLoading ? null : _goLive,
            child: Container(width: double.infinity, height: 56,
              decoration: BoxDecoration(
                color: _isLoading ? Colors.red.withOpacity(0.6) : Colors.red,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.35),
                  blurRadius: 20, offset: const Offset(0, 8))]),
              child: Center(child: _isLoading
                ? const SizedBox(width: 22, height: 22,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                : const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.videocam_rounded, color: Colors.white, size: 22),
                    SizedBox(width: 8),
                    Text('Go Live Now', style: TextStyle(color: Colors.white,
                      fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'Inter')),
                  ])))),
        ]),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController ctrl;
  final String hint;
  final int? maxLines, maxLength;
  const _Field({required this.ctrl, required this.hint, this.maxLines = 1, this.maxLength});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.06),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.white.withOpacity(0.1))),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    child: TextField(controller: ctrl, maxLines: maxLines, maxLength: maxLength,
      style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
      decoration: InputDecoration(hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38, fontFamily: 'Inter'),
        border: InputBorder.none, counterStyle: const TextStyle(color: Colors.white38))));
}

class _PrivacyOption extends StatelessWidget {
  final String value, selected, label, sub;
  final IconData icon;
  final VoidCallback onTap;
  const _PrivacyOption({required this.value, required this.selected,
    required this.label, required this.sub, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final active = value == selected;
    return GestureDetector(onTap: onTap,
      child: AnimatedContainer(duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: active ? Colors.red.withOpacity(0.1) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: active ? Colors.red.withOpacity(0.5) : Colors.white.withOpacity(0.1))),
        child: Row(children: [
          Icon(icon, color: active ? Colors.red : Colors.white54, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: TextStyle(color: active ? Colors.white : Colors.white70,
              fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
            Text(sub, style: const TextStyle(color: Colors.white38,
              fontSize: 12, fontFamily: 'Inter')),
          ])),
          if (active) const Icon(Icons.check_circle_rounded, color: Colors.red, size: 20),
        ])));
  }
}

