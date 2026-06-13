import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class GroupCallScreen extends StatefulWidget {
  final String groupName;
  final List<String> participants;
  const GroupCallScreen({super.key, required this.groupName, required this.participants});

  @override
  State<GroupCallScreen> createState() => _GroupCallScreenState();
}

class _GroupCallScreenState extends State<GroupCallScreen> {
  bool _isMuted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Text(widget.groupName, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('${widget.participants.length} مشارك', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: widget.participants.map((p) => Column(
                children: [
                  CircleAvatar(radius: 30, backgroundColor: ChatColors.surface, child: const Icon(Icons.person, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(p, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              )).toList(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Btn(icon: _isMuted ? Icons.mic_off : Icons.mic, label: 'كتم', active: _isMuted, onTap: () => setState(() => _isMuted = !_isMuted)),
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
  final IconData icon; final String label; final VoidCallback onTap; final bool active; final bool isEnd;
  const _Btn({required this.icon, required this.label, required this.onTap, this.active = false, this.isEnd = false});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Column(children: [
      Container(width: 58, height: 58, decoration: BoxDecoration(color: isEnd ? Colors.red : (active ? Colors.white : Colors.white.withOpacity(0.15)), shape: BoxShape.circle), child: Icon(icon, color: isEnd ? Colors.white : (active ? Colors.black : Colors.white))),
      if (label.isNotEmpty) ...[const SizedBox(height: 6), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11))],
    ]),
  );
}
