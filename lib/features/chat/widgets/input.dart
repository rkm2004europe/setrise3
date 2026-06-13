import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/models.dart';

class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final Function(String) onSend;
  final Function(MsgType) onMedia;

  const InputBar({super.key, required this.controller, required this.focus, required this.onSend, required this.onMedia});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: ChatColors.surface, border: Border(top: BorderSide(color: ChatColors.border))),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.attach_file, color: ChatColors.text2), onPressed: () => _showMediaPicker(context)),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focus,
              style: const TextStyle(color: ChatColors.text),
              decoration: InputDecoration(
                hintText: 'رسالة...',
                hintStyle: TextStyle(color: ChatColors.text2.withOpacity(0.5)),
                border: InputBorder.none,
              ),
              onSubmitted: onSend,
            ),
          ),
          IconButton(icon: const Icon(Icons.send, color: ChatColors.accent), onPressed: () => onSend(controller.text)),
        ],
      ),
    );
  }

  void _showMediaPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ChatColors.surface,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _mediaBtn(Icons.image, MsgType.image, context),
            _mediaBtn(Icons.videocam, MsgType.video, context),
            _mediaBtn(Icons.mic, MsgType.audio, context),
            _mediaBtn(Icons.description, MsgType.file, context),
            _mediaBtn(Icons.location_on, MsgType.location, context),
          ],
        ),
      ),
    );
  }

  Widget _mediaBtn(IconData icon, MsgType type, BuildContext ctx) {
    return GestureDetector(
      onTap: () { Navigator.pop(ctx); onMedia(type); },
      child: Column(
        children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: ChatColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: ChatColors.accent)),
          const SizedBox(height: 4),
          Text(type.name, style: const TextStyle(color: ChatColors.text2, fontSize: 10)),
        ],
      ),
    );
  }
}
