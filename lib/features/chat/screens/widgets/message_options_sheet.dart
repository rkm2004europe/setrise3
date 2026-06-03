// lib/features/chat/screens/widgets/message_options_sheet.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/chat/models/chat_models.dart';

class MessageOptionsSheet {
  static void show(
    BuildContext context, {
    required ChatMessage message,
    required Function(String) onReact,
    required VoidCallback onReply,
    required VoidCallback onForward,
    required VoidCallback onCopy,
    required VoidCallback onStar,
    required VoidCallback onDelete,
    required VoidCallback onInfo,
  }) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _OptionsSheet(
        message: message,
        onReact: onReact, onReply: onReply,
        onForward: onForward, onCopy: onCopy,
        onStar: onStar, onDelete: onDelete, onInfo: onInfo,
      ));
  }
}

class _OptionsSheet extends StatelessWidget {
  final ChatMessage message;
  final Function(String) onReact;
  final VoidCallback onReply, onForward, onCopy, onStar, onDelete, onInfo;

  const _OptionsSheet({
    required this.message, required this.onReact, required this.onReply,
    required this.onForward, required this.onCopy, required this.onStar,
    required this.onDelete, required this.onInfo,
  });

  static const _reactions = ['❤️', '😂', '😮', '😢', '😡', '👍'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF2F2F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.fromLTRB(16, 16, 16,
        16 + MediaQuery.of(context).padding.bottom),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        // Reactions
        Container(padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(14)),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _reactions.map((e) => GestureDetector(
              onTap: () { Navigator.pop(context); onReact(e); },
              child: Text(e, style: const TextStyle(fontSize: 30)))).toList())),

        const SizedBox(height: 10),

        // Actions
        Container(decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(14)),
          child: Column(children: [
            _Tile(icon: CupertinoIcons.arrowshape_turn_up_left,
              label: 'Reply', onTap: () { Navigator.pop(context); onReply(); }),
            _divider(),
            _Tile(icon: CupertinoIcons.arrowshape_turn_up_right,
              label: 'Forward', onTap: () { Navigator.pop(context); onForward(); }),
            _divider(),
            if (message.text != null) ...[
              _Tile(icon: CupertinoIcons.doc_on_doc,
                label: 'Copy', onTap: () { Navigator.pop(context); onCopy(); }),
              _divider(),
            ],
            _Tile(icon: message.isStarred
                ? CupertinoIcons.star_slash : CupertinoIcons.star,
              label: message.isStarred ? 'Unstar' : 'Star',
              onTap: () { Navigator.pop(context); onStar(); }),
            _divider(),
            _Tile(icon: CupertinoIcons.info_circle,
              label: 'Info', onTap: () { Navigator.pop(context); onInfo(); }),
            if (message.isMe) ...[
              _divider(),
              _Tile(icon: CupertinoIcons.trash, label: 'Delete',
                color: CupertinoColors.destructiveRed,
                onTap: () { Navigator.pop(context); onDelete(); }),
            ],
          ])),

        const SizedBox(height: 10),

        // Cancel
        GestureDetector(onTap: () => Navigator.pop(context),
          child: Container(width: double.infinity, height: 52,
            decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(14)),
            child: const Center(child: Text('Cancel', style: TextStyle(
              color: Color(0xFF007AFF), fontSize: 16,
              fontWeight: FontWeight.w600))))),
      ]));
  }

  Widget _divider() => const Divider(height: 0.5, indent: 52, color: Color(0xFFE5E5EA));
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.label,
    required this.onTap, this.color = Colors.black});

  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: EdgeInsets.zero, onPressed: onTap,
    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 14),
        Text(label, style: TextStyle(color: color, fontSize: 16)),
      ])));
}

