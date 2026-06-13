import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../models/bot_model.dart';
import '../../services/bot_service.dart';

class BotChatScreen extends StatefulWidget {
  final BotModel bot;
  const BotChatScreen({super.key, required this.bot});

  @override
  State<BotChatScreen> createState() => _BotChatScreenState();
}

class _BotChatScreenState extends State<BotChatScreen> {
  final BotService _botService = BotService();
  final _ctrl = TextEditingController();
  final List<Map<String, String>> _msgs = [];

  void _send(String text) async {
    setState(() => _msgs.add({'sender': 'me', 'text': text}));
    _ctrl.clear();
    final reply = await _botService.getReply(text);
    setState(() => _msgs.add({'sender': 'bot', 'text': reply}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context, widget.bot.name),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _msgs.length,
                itemBuilder: (_, i) => Align(
                  alignment: _msgs[i]['sender'] == 'me' ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: _msgs[i]['sender'] == 'me' ? ChatColors.outgoing : ChatColors.incoming,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(_msgs[i]['text']!, style: const TextStyle(color: ChatColors.text)),
                  ),
                ),
              ),
            ),
            _InputBar(ctrl: _ctrl, onSend: _send),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  final String name;
  const _TopBar(this.context, this.name);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [
      GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
      const SizedBox(width: 12),
      Text(name, style: const TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _InputBar extends StatelessWidget {
  final TextEditingController ctrl;
  final Function(String) onSend;
  const _InputBar({required this.ctrl, required this.onSend});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: ChatColors.surface, border: Border(top: BorderSide(color: ChatColors.border))),
    child: Row(children: [
      Expanded(child: TextField(controller: ctrl, style: const TextStyle(color: ChatColors.text), decoration: InputDecoration(hintText: 'أكتب رسالة...', hintStyle: TextStyle(color: ChatColors.text2.withOpacity(0.5)), border: InputBorder.none), onSubmitted: onSend)),
      IconButton(icon: const Icon(Icons.send, color: ChatColors.accent), onPressed: () => onSend(ctrl.text)),
    ]),
  );
}
