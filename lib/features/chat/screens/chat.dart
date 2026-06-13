import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/colors.dart';
import '../models/models.dart';
import '../widgets/bubble.dart';
import '../widgets/input.dart';
import '../widgets/reply_bar.dart';
import '../widgets/day_separator.dart';
import '../widgets/options_sheet.dart';
import '../widgets/app_bar.dart';
import 'call.dart';
import 'profile.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;
  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scroll = ScrollController();
  final _textCtrl = TextEditingController();
  final _focus = FocusNode();
  late List<Message> _msgs;
  Message? _replyTo;
  bool _showScrollBtn = false;

  @override
  void initState() {
    super.initState();
    _msgs = _mockMessages();
    _scroll.addListener(() {
      if (_scroll.hasClients) {
        setState(() => _showScrollBtn = _scroll.position.pixels < _scroll.position.maxScrollExtent - 400);
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    _textCtrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<Message> _mockMessages() {
    final now = DateTime.now();
    return [
      Message(id: '1', senderId: widget.conversation.user.id, type: MsgType.text, text: 'مرحباً! كيف حالك؟', status: MsgStatus.read, createdAt: now.subtract(const Duration(hours: 2))),
      Message(id: '2', senderId: 'me', type: MsgType.text, text: 'أهلاً! بخير، وأنت؟', status: MsgStatus.read, createdAt: now.subtract(const Duration(hours: 1))),
      Message(id: '3', senderId: widget.conversation.user.id, type: MsgType.text, text: 'الحمد لله. متى نلتقي؟', status: MsgStatus.read, createdAt: now.subtract(const Duration(minutes: 30))),
      Message(id: '4', senderId: 'me', type: MsgType.image, mediaEmoji: '🖼️', status: MsgStatus.delivered, createdAt: now.subtract(const Duration(minutes: 25))),
    ];
  }

  void _send(String text) {
    if (text.trim().isEmpty) return;
    final msg = Message(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me',
      type: MsgType.text,
      text: text.trim(),
      replyTo: _replyTo,
      status: MsgStatus.sending,
      createdAt: DateTime.now(),
    );
    setState(() {
      _msgs.add(msg);
      _textCtrl.clear();
      _replyTo = null;
    });
    HapticFeedback.lightImpact();
    _scrollToBottom();
  }

  void _sendMedia(MsgType type) {
    final emojis = {MsgType.image: '🖼️', MsgType.video: '🎥', MsgType.audio: '🎵', MsgType.file: '📄', MsgType.location: '📍', MsgType.sticker: '😊'};
    final msg = Message(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me',
      type: type,
      mediaEmoji: emojis[type],
      status: MsgStatus.sending,
      createdAt: DateTime.now(),
    );
    setState(() { _msgs.add(msg); _replyTo = null; });
    HapticFeedback.lightImpact();
    _scrollToBottom();
  }

  void _react(Message msg, String emoji) {
    final idx = _msgs.indexWhere((m) => m.id == msg.id);
    if (idx == -1) return;
    final existing = _msgs[idx].reactions;
    final emojiIdx = existing.indexWhere((r) => r.emoji == emoji);
    List<Reaction> updated;
    if (emojiIdx != -1) {
      final r = existing[emojiIdx];
      updated = r.mine ? List.from(existing)..removeAt(emojiIdx) : List.from(existing)..[emojiIdx] = Reaction(emoji: emoji, count: r.count + 1, mine: true);
    } else {
      updated = [...existing, Reaction(emoji: emoji, count: 1, mine: true)];
    }
    setState(() => _msgs[idx] = _msgs[idx].copyWith(reactions: updated));
  }

  void _delete(Message msg) {
    final idx = _msgs.indexWhere((m) => m.id == msg.id);
    if (idx != -1) setState(() => _msgs.removeAt(idx));
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) _scroll.animateTo(_scroll.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(user: widget.conversation.user))),
              child: ChatAppBar(
                title: widget.conversation.displayName,
                subtitle: widget.conversation.user.lastSeenText,
                leading: IconButton(icon: const Icon(Icons.arrow_back, color: ChatColors.text), onPressed: () => Navigator.pop(context)),
                actions: [
                  IconButton(icon: const Icon(Icons.call, color: ChatColors.accent), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(user: widget.conversation.user, isVideo: false)))),
                  IconButton(icon: const Icon(Icons.videocam, color: ChatColors.accent), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CallScreen(user: widget.conversation.user, isVideo: true)))),
                ],
              ),
            ),
            // رسائل
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _msgs.length,
                    itemBuilder: (ctx, i) => MessageBubble(
                      message: _msgs[i],
                      onLongPress: (m) => OptionsSheet.show(context, message: m, onReact: (e) => _react(m, e), onReply: () => setState(() => _replyTo = m), onDelete: () => _delete(m)),
                      onReact: _react,
                    ),
                  ),
                  if (_showScrollBtn)
                    Positioned(
                      bottom: 10, right: 10,
                      child: GestureDetector(
                        onTap: _scrollToBottom,
                        child: Container(width: 36, height: 36, decoration: BoxDecoration(color: ChatColors.surface, shape: BoxShape.circle), child: const Icon(Icons.keyboard_arrow_down, color: ChatColors.accent)),
                      ),
                    ),
                ],
              ),
            ),
            // رد
            if (_replyTo != null) ReplyBar(replyTo: _replyTo!, onCancel: () => setState(() => _replyTo = null)),
            // إدخال
            InputBar(controller: _textCtrl, focus: _focus, onSend: _send, onMedia: _sendMedia),
          ],
        ),
      ),
    );
  }
}
