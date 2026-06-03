// lib/features/chat/screens/chat_screen.dart
// ✅ شاشة الشات الكاملة — iOS Style

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/chat/models/chat_models.dart';
import 'package:setrise/features/chat/screens/widgets/chat_app_bar.dart';
import 'package:setrise/features/chat/screens/widgets/message_bubble.dart';
import 'package:setrise/features/chat/screens/widgets/message_input_bar.dart';
import 'package:setrise/features/chat/screens/widgets/message_options_sheet.dart';
import 'package:setrise/features/chat/screens/widgets/reply_preview.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;
  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollCtrl  = ScrollController();
  final _textCtrl    = TextEditingController();
  final _focusNode   = FocusNode();
  final _searchCtrl  = TextEditingController();

  late final List<ChatMessage> _messages;
  ChatMessage? _replyTo;
  bool _showSearch = false;
  String _searchQuery = '';
  bool _isTyping = false;
  bool _showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    _messages = ChatMockData.getMockMessages();
    _textCtrl.addListener(() =>
        setState(() => _isTyping = _textCtrl.text.trim().isNotEmpty));
    _scrollCtrl.addListener(() {
      final atBottom = _scrollCtrl.position.pixels < 200;
      if (atBottom != !_showScrollToBottom)
        setState(() => _showScrollToBottom = !atBottom);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose(); _textCtrl.dispose();
    _focusNode.dispose(); _searchCtrl.dispose();
    super.dispose();
  }

  // ── Send ─────────────────────────────────────────────────
  void _sendText(String text) {
    if (text.trim().isEmpty) return;
    final msg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me', type: MessageType.text,
      text: text.trim(), replyTo: _replyTo,
      status: MessageStatus.sending, createdAt: DateTime.now());
    setState(() { _messages.add(msg); _textCtrl.clear(); _replyTo = null; });
    HapticFeedback.lightImpact();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      final idx = _messages.indexWhere((m) => m.id == msg.id);
      if (idx != -1) setState(() =>
          _messages[idx] = _messages[idx].copyWith(status: MessageStatus.delivered));
    });
  }

  void _sendMedia(MessageType type) {
    final emojis = {
      MessageType.image: '🖼️', MessageType.video: '🎥',
      MessageType.sticker: '😊',
    };
    final msg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      senderId: 'me', type: type,
      mediaEmoji: emojis[type],
      fileName: type == MessageType.file ? 'document.pdf' : null,
      fileExt: type == MessageType.file ? 'pdf' : null,
      fileSize: type == MessageType.file ? 1024000 : null,
      audioDuration: type == MessageType.audio ? 8 : null,
      locationName: type == MessageType.location ? 'Current Location' : null,
      status: MessageStatus.sending, createdAt: DateTime.now());
    setState(() { _messages.add(msg); _replyTo = null; });
    HapticFeedback.lightImpact();
    _scrollToBottom();
  }

  void _react(ChatMessage msg, String emoji) {
    final idx = _messages.indexWhere((m) => m.id == msg.id);
    if (idx == -1) return;
    final existing  = _messages[idx].reactions;
    final emojiIdx  = existing.indexWhere((r) => r.emoji == emoji);
    List<MessageReaction> updated;
    if (emojiIdx != -1) {
      final r = existing[emojiIdx];
      if (r.isMyReaction) {
        updated = List.from(existing)..removeAt(emojiIdx);
      } else {
        updated = List.from(existing);
        updated[emojiIdx] = MessageReaction(
            emoji: emoji, count: r.count + 1, isMyReaction: true);
      }
    } else {
      updated = [...existing,
        MessageReaction(emoji: emoji, count: 1, isMyReaction: true)];
    }
    setState(() => _messages[idx] = _messages[idx].copyWith(reactions: updated));
  }

  void _deleteMessage(ChatMessage msg) {
    final idx = _messages.indexWhere((m) => m.id == msg.id);
    if (idx == -1) return;
    showCupertinoModalPopup<void>(context: context,
      builder: (_) => CupertinoActionSheet(
        title: const Text('Delete Message'),
        actions: [
          if (msg.isMe)
            CupertinoActionSheetAction(isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                setState(() => _messages[idx] =
                    _messages[idx].copyWith(isDeleted: true));
              },
              child: const Text('Delete for Everyone')),
          CupertinoActionSheetAction(isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              setState(() => _messages.removeAt(idx));
            },
            child: const Text('Delete for Me')),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'))));
  }

  void _scrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollCtrl.hasClients) return;
      if (animated) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      } else {
        _scrollCtrl.jumpTo(_scrollCtrl.position.maxScrollExtent);
      }
    });
  }

  List<dynamic> _groupByDate(List<ChatMessage> messages) {
    final result = <dynamic>[];
    DateTime? lastDate;
    for (final msg in messages) {
      final d = DateTime(msg.createdAt.year, msg.createdAt.month, msg.createdAt.day);
      if (lastDate == null || d != lastDate) { result.add(d); lastDate = d; }
      result.add(msg);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByDate(_messages);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _showSearch ? _searchBar() : ChatAppBar(
        conversation: widget.conversation,
        onSearchTap: () => setState(() => _showSearch = true)),
      body: Column(children: [
        if (_showSearch && _searchQuery.isNotEmpty)
          Container(color: const Color(0xFFF2F2F7),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text('${_searchResults.length} results for "$_searchQuery"',
              style: const TextStyle(fontSize: 13, color: Color(0xFF8E8E93)))),
        Expanded(child: Stack(children: [
          ListView.builder(
            controller: _scrollCtrl,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: grouped.length,
            itemBuilder: (ctx, i) {
              final item = grouped[i];
              if (item is DateTime) return DaySeparator(date: item);
              final msg = item as ChatMessage;
              return MessageBubble(
                key: ValueKey(msg.id), message: msg,
                onReply: (m) => setState(() => _replyTo = m),
                onLongPress: (m) => MessageOptionsSheet.show(context,
                  message: m,
                  onReact: (e) => _react(m, e),
                  onReply: () => setState(() => _replyTo = m),
                  onForward: () {},
                  onCopy: () {
                    if (m.text != null) Clipboard.setData(ClipboardData(text: m.text!));
                  },
                  onStar: () {
                    final idx = _messages.indexWhere((x) => x.id == m.id);
                    if (idx != -1) setState(() =>
                        _messages[idx] = _messages[idx].copyWith(isStarred: !m.isStarred));
                  },
                  onDelete: () => _deleteMessage(m),
                  onInfo: () {}),
                onReact: _react);
            }),
          if (_showScrollToBottom)
            Positioned(bottom: 12, right: 12,
              child: GestureDetector(onTap: _scrollToBottom,
                child: Container(width: 36, height: 36,
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8)]),
                  child: const Icon(CupertinoIcons.chevron_down,
                    color: Color(0xFF007AFF), size: 18)))),
        ])),
        if (_replyTo != null)
          ReplyPreviewBar(replyTo: _replyTo!,
            onCancel: () => setState(() => _replyTo = null)),
        if (!_showSearch)
          MessageInputBar(controller: _textCtrl, focusNode: _focusNode,
            onSendText: _sendText, onSendMedia: _sendMedia, hasText: _isTyping),
      ]),
    );
  }

  List<int> get _searchResults {
    if (_searchQuery.isEmpty) return [];
    return _messages.asMap().entries
        .where((e) => e.value.text?.toLowerCase().contains(_searchQuery.toLowerCase()) == true)
        .map((e) => e.key).toList();
  }

  PreferredSizeWidget _searchBar() => AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: CupertinoSearchTextField(
      controller: _searchCtrl, placeholder: 'Search in chat',
      autofocus: true,
      onChanged: (v) => setState(() => _searchQuery = v)),
    actions: [
      CupertinoButton(padding: const EdgeInsets.only(right: 12),
        onPressed: () => setState(() {
          _showSearch = false; _searchQuery = ''; _searchCtrl.clear(); }),
        child: const Text('Cancel',
          style: TextStyle(color: Color(0xFF007AFF)))),
    ],
    bottom: PreferredSize(preferredSize: const Size.fromHeight(0.5),
      child: Divider(height: 0.5, color: Colors.black.withOpacity(0.1))));
}

