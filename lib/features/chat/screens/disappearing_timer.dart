import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DisappearingTimerScreen extends StatefulWidget {
  final Function(Duration?) onSet;
  const DisappearingTimerScreen({super.key, required this.onSet});

  @override
  State<DisappearingTimerScreen> createState() => _DisappearingTimerScreenState();
}

class _DisappearingTimerScreenState extends State<DisappearingTimerScreen> {
  Duration? _selected;

  @override
  Widget build(BuildContext context) {
    final options = <Duration?>[null, const Duration(hours: 1), const Duration(hours: 24), const Duration(days: 7), const Duration(days: 30)];
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: options.map((d) => ListTile(
                  title: Text(d == null ? 'إيقاف' : _format(d), style: const TextStyle(color: ChatColors.text)),
                  trailing: _selected == d ? const Icon(Icons.check, color: ChatColors.accent) : null,
                  onTap: () { setState(() => _selected = d); widget.onSet(d); Navigator.pop(context); },
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _format(Duration d) {
    if (d.inDays > 0) return '${d.inDays} أيام';
    if (d.inHours > 0) return '${d.inHours} ساعة';
    return '${d.inMinutes} دقيقة';
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
      const SizedBox(width: 12),
      const Text('اختفاء الرسائل', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
