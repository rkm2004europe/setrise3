// lib/features/chat/screens/widgets/message_bubble.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/chat/models/chat_models.dart';

// ── Day Separator ─────────────────────────────────────────

class DaySeparator extends StatelessWidget {
  final DateTime date;
  const DaySeparator({super.key, required this.date});

  String get _label {
    final now  = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff == 0) return 'اليوم';
    if (diff == 1) return 'أمس';
    if (diff < 7) {
      const days = ['الأحد','الاثنين','الثلاثاء','الأربعاء','الخميس','الجمعة','السبت'];
      return days[date.weekday % 7];
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Row(children: [
      const Expanded(child: Divider(color: Color(0xFFE5E5EA))),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E5EA),
          borderRadius: BorderRadius.circular(10)),
        child: Text(_label, style: const TextStyle(
          color: Color(0xFF8E8E93), fontSize: 12,
          fontWeight: FontWeight.w600))),
      const Expanded(child: Divider(color: Color(0xFFE5E5EA))),
    ]));
}

// ── Message Bubble ────────────────────────────────────────

class MessageBubble extends StatefulWidget {
  final ChatMessage message;
  final Function(ChatMessage) onReply;
  final Function(ChatMessage) onLongPress;
  final Function(ChatMessage, String) onReact;

  const MessageBubble({
    super.key, required this.message, required this.onReply,
    required this.onLongPress, required this.onReact,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double>   _scale;
  double _dragOffset = 0;
  bool   _replyTriggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 180));
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final msg  = widget.message;
    final isMe = msg.isMe;

    return ScaleTransition(
      scale: _scale,
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => widget.onLongPress(msg),
        onHorizontalDragUpdate: (d) {
          if (isMe && d.delta.dx < 0) {
            setState(() => _dragOffset = (_dragOffset + d.delta.dx).clamp(-60.0, 0.0));
          } else if (!isMe && d.delta.dx > 0) {
            setState(() => _dragOffset = (_dragOffset + d.delta.dx).clamp(0.0, 60.0));
          }
          if (_dragOffset.abs() >= 55 && !_replyTriggered) {
            _replyTriggered = true;
            HapticFeedback.mediumImpact();
            widget.onReply(msg);
          }
        },
        onHorizontalDragEnd: (_) =>
            setState(() { _dragOffset = 0; _replyTriggered = false; }),
        child: Transform.translate(
          offset: Offset(_dragOffset, 0),
          child: Padding(
            padding: EdgeInsets.only(
              left: isMe ? 60 : 12, right: isMe ? 12 : 60,
              top: 2, bottom: 2),
            child: Column(
              crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (msg.isForwarded)
                  Padding(padding: const EdgeInsets.only(bottom: 3),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(CupertinoIcons.arrowshape_turn_up_right,
                          size: 11, color: Colors.grey.shade500),
                      const SizedBox(width: 3),
                      Text('محوّل', style: TextStyle(fontSize: 11,
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic)),
                    ])),
                _BubbleContent(message: msg,
                  onReact: (e) => widget.onReact(msg, e)),
                if (msg.reactions.isNotEmpty)
                  _ReactionsRow(reactions: msg.reactions, isMe: isMe,
                    onTap: (e) => widget.onReact(msg, e)),
              ]),
          )),
      ));
  }
}

// ── Bubble Content ────────────────────────────────────────

class _BubbleContent extends StatelessWidget {
  final ChatMessage message;
  final Function(String) onReact;
  const _BubbleContent({required this.message, required this.onReact});

  bool get _isMedia =>
      message.type == MessageType.image || message.type == MessageType.video;

  BorderRadius _radius(bool isMe) => BorderRadius.only(
    topLeft: const Radius.circular(18), topRight: const Radius.circular(18),
    bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4),
    bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18));

  @override
  Widget build(BuildContext context) {
    final isMe     = message.isMe;
    final bgColor  = isMe ? const Color(0xFF007AFF) : const Color(0xFFE5E5EA);
    final txtColor = isMe ? Colors.white : Colors.black;

    if (message.isDeleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.5), borderRadius: _radius(isMe),
          border: Border.all(color: isMe ? Colors.white24 : const Color(0xFFD1D1D6))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(CupertinoIcons.minus_circle, size: 14,
              color: isMe ? Colors.white70 : const Color(0xFF8E8E93)),
          const SizedBox(width: 5),
          Text('تم حذف هذه الرسالة', style: TextStyle(
              color: isMe ? Colors.white70 : const Color(0xFF8E8E93),
              fontSize: 14, fontStyle: FontStyle.italic)),
        ]));
    }

    return Container(
      decoration: BoxDecoration(
        color: _isMedia ? Colors.transparent : bgColor,
        borderRadius: _radius(isMe)),
      constraints: const BoxConstraints(maxWidth: 280),
      child: ClipRRect(
        borderRadius: _radius(isMe),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Reply preview
          if (message.replyTo != null)
            Container(
              margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isMe ? Colors.white.withOpacity(0.15) : Colors.black.withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border(left: BorderSide(
                  color: isMe ? Colors.white : const Color(0xFF007AFF), width: 3))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(message.replyTo!.isMe ? 'أنت' : 'المحادثة',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                    color: isMe ? Colors.white : const Color(0xFF007AFF))),
                if (message.replyTo!.text != null)
                  Text(message.replyTo!.text!, maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12,
                      color: isMe ? Colors.white70 : Colors.black54)),
              ])),

          // Body
          Padding(padding: _bodyPadding,
            child: _buildBody(context, isMe, txtColor, bgColor)),

          // Time + status
          if (!_isMedia)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 2, 8, 6),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                if (message.isStarred)
                  Padding(padding: const EdgeInsets.only(right: 4),
                    child: Icon(CupertinoIcons.star_fill, size: 10,
                      color: isMe ? Colors.white70 : const Color(0xFFFFCC00))),
                Text(message.timeText, style: TextStyle(
                  color: isMe ? Colors.white70 : const Color(0xFF8E8E93),
                  fontSize: 10)),
                if (isMe) ...[
                  const SizedBox(width: 3),
                  _StatusTicks(status: message.status),
                ],
              ])),
        ])));
  }

  EdgeInsets get _bodyPadding {
    if (_isMedia) return EdgeInsets.zero;
    return const EdgeInsets.fromLTRB(12, 10, 12, 4);
  }

  Widget _buildBody(BuildContext ctx, bool isMe, Color textColor, Color bgColor) {
    switch (message.type) {
      case MessageType.text:
        return Text(message.text ?? '',
          style: TextStyle(color: textColor, fontSize: 16, height: 1.3));

      case MessageType.image:
      case MessageType.video:
        return Stack(children: [
          Container(width: 220, height: 200,
            color: const Color(0xFFD1D1D6),
            child: Center(child: Text(message.mediaEmoji ?? '🖼️',
              style: const TextStyle(fontSize: 60)))),
          if (message.type == MessageType.video)
            Positioned.fill(child: Center(child: Container(
              width: 50, height: 50,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle),
              child: const Icon(CupertinoIcons.play_fill,
                color: Colors.white, size: 24)))),
          Positioned(bottom: 8, right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(message.timeText,
                  style: const TextStyle(color: Colors.white, fontSize: 10)),
                if (isMe) ...[const SizedBox(width: 3),
                  _StatusTicks(status: message.status, onMedia: true)],
              ]))),
        ]);

      case MessageType.audio:
        return _AudioWidget(message: message, isMe: isMe);

      case MessageType.file:
        return _FileWidget(message: message, isMe: isMe);

      case MessageType.location:
        return _LocationWidget(message: message, isMe: isMe);

      case MessageType.sticker:
        return Text(message.text ?? '😊',
          style: const TextStyle(fontSize: 64));

      default: return const SizedBox.shrink();
    }
  }
}

// ── Audio Widget ──────────────────────────────────────────

class _AudioWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  const _AudioWidget({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final color = isMe ? Colors.white : const Color(0xFF007AFF);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(CupertinoIcons.play_fill, color: color, size: 22),
      const SizedBox(width: 8),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 28,
          child: Row(children: List.generate(25, (i) => Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              height: (i % 5 + 1) * 4.0,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2))))))),
        Text('${message.audioDuration ?? 0}s',
          style: TextStyle(color: color.withOpacity(0.6), fontSize: 10)),
      ])),
    ]);
  }
}

// ── File Widget ───────────────────────────────────────────

class _FileWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  const _FileWidget({required this.message, required this.isMe});

  String _fmtSize(int? bytes) {
    if (bytes == null) return '';
    if (bytes >= 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / 1024).toStringAsFixed(0)} KB';
  }

  @override
  Widget build(BuildContext context) {
    final color = isMe ? Colors.white : const Color(0xFF007AFF);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 44, height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(message.fileExt?.toUpperCase() ?? 'FILE',
          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800)))),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(message.fileName ?? 'File', style: TextStyle(
          color: isMe ? Colors.white : Colors.black,
          fontSize: 14, fontWeight: FontWeight.w600),
          maxLines: 1, overflow: TextOverflow.ellipsis),
        Text(_fmtSize(message.fileSize),
          style: TextStyle(color: color.withOpacity(0.7), fontSize: 12)),
      ])),
    ]);
  }
}

// ── Location Widget ───────────────────────────────────────

class _LocationWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  const _LocationWidget({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 220, height: 120,
        color: const Color(0xFFD1D1D6),
        child: const Center(child: Text('🗺️', style: TextStyle(fontSize: 48)))),
      Padding(padding: const EdgeInsets.fromLTRB(10, 6, 10, 2),
        child: Row(children: [
          Icon(CupertinoIcons.location_fill, size: 13,
            color: isMe ? Colors.white70 : const Color(0xFF007AFF)),
          const SizedBox(width: 4),
          Flexible(child: Text(message.locationName ?? 'Location',
            style: TextStyle(fontSize: 13,
              color: isMe ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600))),
        ])),
    ]);
  }
}

// ── Status Ticks ──────────────────────────────────────────

class _StatusTicks extends StatelessWidget {
  final MessageStatus status;
  final bool onMedia;
  const _StatusTicks({required this.status, this.onMedia = false});

  @override
  Widget build(BuildContext context) {
    final color = onMedia ? Colors.white
        : (status == MessageStatus.read
            ? const Color(0xFF4FC3F7)
            : Colors.white.withOpacity(0.7));
    switch (status) {
      case MessageStatus.sending:
        return Icon(CupertinoIcons.clock, size: 11, color: color);
      case MessageStatus.sent:
        return Icon(CupertinoIcons.checkmark, size: 11, color: color);
      case MessageStatus.delivered:
      case MessageStatus.read:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(CupertinoIcons.checkmark, size: 11, color: color),
          const SizedBox(width: -5),
          Icon(CupertinoIcons.checkmark, size: 11, color: color),
        ]);
    }
  }
}

// ── Reactions Row ─────────────────────────────────────────

class _ReactionsRow extends StatelessWidget {
  final List<MessageReaction> reactions;
  final bool isMe;
  final Function(String) onTap;
  const _ReactionsRow({required this.reactions,
    required this.isMe, required this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: isMe ? 0 : 8, right: isMe ? 8 : 0, top: 3),
    child: Wrap(spacing: 4,
      children: reactions.map((r) => GestureDetector(
        onTap: () { HapticFeedback.lightImpact(); onTap(r.emoji); },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: r.isMyReaction
                ? const Color(0xFF007AFF).withOpacity(0.15) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: r.isMyReaction
                  ? const Color(0xFF007AFF) : const Color(0xFFE5E5EA),
              width: r.isMyReaction ? 1.5 : 1),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),
              blurRadius: 4, offset: const Offset(0, 1))]),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(r.emoji, style: const TextStyle(fontSize: 13)),
            if (r.count > 1) ...[const SizedBox(width: 3),
              Text('${r.count}', style: const TextStyle(fontSize: 11,
                fontWeight: FontWeight.w700, color: Color(0xFF3C3C43)))],
          ])))).toList()));
}

