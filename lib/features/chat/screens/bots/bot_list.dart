import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../models/bot_model.dart';
import '../../data/mock_bots.dart';
import 'bot_chat.dart';

class BotListScreen extends StatelessWidget {
  const BotListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(context),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockBots.length,
                itemBuilder: (_, i) => _BotTile(bot: mockBots[i], onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BotChatScreen(bot: mockBots[i])))),
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
      const Text('الروبوتات', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _BotTile extends StatelessWidget {
  final BotModel bot;
  final VoidCallback onTap;
  const _BotTile({required this.bot, required this.onTap});

  @override
  Widget build(BuildContext context) => ListTile(
    leading: CircleAvatar(backgroundColor: ChatColors.surface, child: Text(bot.avatar)),
    title: Text(bot.name, style: const TextStyle(color: ChatColors.text)),
    subtitle: Text(bot.description, style: const TextStyle(color: ChatColors.text2)),
    onTap: onTap,
  );
}
