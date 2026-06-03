// lib/features/chat/screens/widgets/message_input_bar.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/chat/models/chat_models.dart';

class MessageInputBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSendText;
  final Function(MessageType) onSendMedia;
  final bool hasText;

  const MessageInputBar({
    super.key, required this.controller, required this.focusNode,
    required this.onSendText, required this.onSendMedia, required this.hasText,
  });

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  bool _showAttach = false;

  void _send() {
    final text = widget.controller.text.trim();
    if (text.isEmpty) return;
    widget.onSendText(text);
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      // Attach options
      if (_showAttach)
        Container(
          color: const Color(0xFFF2F2F7),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _AttachBtn(icon: '🖼️', label: 'Photo',
                onTap: () { setState(() => _showAttach = false); widget.onSendMedia(MessageType.image); }),
              _AttachBtn(icon: '🎥', label: 'Video',
                onTap: () { setState(() => _showAttach = false); widget.onSendMedia(MessageType.video); }),
              _AttachBtn(icon: '📄', label: 'File',
                onTap: () { setState(() => _showAttach = false); widget.onSendMedia(MessageType.file); }),
              _AttachBtn(icon: '📍', label: 'Location',
                onTap: () { setState(() => _showAttach = false); widget.onSendMedia(MessageType.location); }),
              _AttachBtn(icon: '😊', label: 'Sticker',
                onTap: () { setState(() => _showAttach = false); widget.onSendMedia(MessageType.sticker); }),
            ])),

      // Input row
      Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: SafeArea(top: false,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            // Attach
            GestureDetector(
              onTap: () { HapticFeedback.lightImpact(); setState(() => _showAttach = !_showAttach); },
              child: Container(width: 36, height: 36,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Icon(
                  _showAttach ? CupertinoIcons.xmark_circle_fill : CupertinoIcons.paperclip,
                  color: const Color(0xFF8E8E93), size: 24))),
            const SizedBox(width: 6),

            // Text field
            Expanded(child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 36, maxHeight: 120),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5E5EA))),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  maxLines: null, textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Message...', border: InputBorder.none,
                    isDense: true, contentPadding: EdgeInsets.zero,
                    hintStyle: TextStyle(color: Color(0xFF8E8E93))))))),
            const SizedBox(width: 6),

            // Send / Mic
            GestureDetector(
              onTap: widget.hasText ? _send : () => widget.onSendMedia(MessageType.audio),
              child: Container(width: 36, height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF007AFF), shape: BoxShape.circle),
                child: Icon(
                  widget.hasText ? CupertinoIcons.arrow_up : CupertinoIcons.mic_fill,
                  color: Colors.white, size: 18))),
          ])),
      ),
    ]);
  }
}

class _AttachBtn extends StatelessWidget {
  final String icon, label;
  final VoidCallback onTap;
  const _AttachBtn({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 50, height: 50,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)]),
        child: Center(child: Text(icon, style: const TextStyle(fontSize: 24)))),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93))),
    ]));
}

