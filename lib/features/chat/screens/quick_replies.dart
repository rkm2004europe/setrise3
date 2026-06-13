import 'package:flutter/material.dart';
import '../theme/colors.dart';

class QuickRepliesScreen extends StatefulWidget {
  const QuickRepliesScreen({super.key});

  @override
  State<QuickRepliesScreen> createState() => _QuickRepliesScreenState();
}

class _QuickRepliesScreenState extends State<QuickRepliesScreen> {
  final List<String> _replies = ['شكراً', 'سأعود إليك لاحقاً', 'موافق', 'غير متاح الآن'];
  final _ctrl = TextEditingController();

  void _add() {
    if (_ctrl.text.isNotEmpty) {
      setState(() => _replies.add(_ctrl.text));
      _ctrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: _ctrl, style: const TextStyle(color: ChatColors.text), decoration: const InputDecoration(hintText: 'أضف رداً سريعاً', border: InputBorder.none))),
                  IconButton(onPressed: _add, icon: const Icon(Icons.add, color: ChatColors.accent)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _replies.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(_replies[i], style: const TextStyle(color: ChatColors.text)),
                  trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => setState(() => _replies.removeAt(i))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
      const Text('الردود السريعة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}
