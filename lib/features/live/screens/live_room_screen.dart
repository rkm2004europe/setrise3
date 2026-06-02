// lib/features/live/screens/live_room_screen.dart
//
// ✅ مربوط بـ UserPreviewSheet عند الضغط على اسم المستخدم في الشات

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/live/models/live_stream_model.dart';
import 'package:setrise/features/user/screens/widgets/user_preview_sheet.dart';

class LiveRoomScreen extends StatefulWidget {
  final LiveStreamModel stream;
  const LiveRoomScreen({super.key, required this.stream});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  final _chatCtrl = TextEditingController();
  late bool   _isLiked;
  late int    _likes;
  bool _showViewers = false;

  final List<_ChatMsg> _chat = [
    _ChatMsg(user: 'ahmed_99',  msg: 'This is 🔥🔥🔥',              color: Color(0xFFFF3B30)),
    _ChatMsg(user: 'sara_x',    msg: 'Love this content!',          color: Color(0xFF6C63FF)),
    _ChatMsg(user: 'nora_m',    msg: '❤️❤️',                        color: Color(0xFFFF6584)),
    _ChatMsg(user: 'user1234',  msg: 'Been watching for 2 hours 😭', color: Color(0xFF34C759)),
    _ChatMsg(user: 'karim_dz',  msg: 'من الجزائر 🇩🇿',              color: Color(0xFFFF9500)),
  ];

  @override
  void initState() {
    super.initState();
    _isLiked = widget.stream.isLiked;
    _likes   = widget.stream.likes;
  }

  @override
  void dispose() { _chatCtrl.dispose(); super.dispose(); }

  void _sendMsg() {
    if (_chatCtrl.text.trim().isEmpty) return;
    HapticFeedback.lightImpact();
    setState(() {
      _chat.add(_ChatMsg(user: 'me', msg: _chatCtrl.text.trim(),
        color: Colors.white, isOwn: true));
      _chatCtrl.clear();
    });
  }

  void _toggleLike() {
    HapticFeedback.selectionClick();
    setState(() {
      _isLiked = !_isLiked;
      _likes += _isLiked ? 1 : -1;
    });
  }

  // ✅ فتح بروفيل مستخدم من الشات
  void _openUserFromChat(_ChatMsg msg) {
    if (msg.isOwn) return;
    showUserPreviewSheet(context,
      userId: msg.user,
      userName: msg.user,
      username: '@${msg.user}',
      accent: const Color(0xFFFF3B30),
    );
  }

  // ✅ فتح بروفيل الهوست
  void _openHostProfile() {
    showUserPreviewSheet(context,
      userId: widget.stream.id,
      userName: widget.stream.host,
      username: widget.stream.hostUsername,
      followers: widget.stream.viewers * 3,
      accent: const Color(0xFFFF3B30),
    );
  }

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }

  @override
  Widget build(BuildContext context) {
    final safe = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: widget.stream.color,
      body: Stack(children: [

        // ── Background gradient ─────────────────────────
        Container(decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
            colors: [widget.stream.color, Colors.black]))),

        // ── Video/Voice area ────────────────────────────
        if (widget.stream.type == LiveType.voice)
          Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 100, height: 100,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2), shape: BoxShape.circle,
                border: Border.all(color: Colors.red.withOpacity(0.5), width: 2)),
              child: const Icon(Icons.mic_rounded, color: Colors.white, size: 48)),
            const SizedBox(height: 16),
            Text('Voice Room', style: const TextStyle(color: Colors.white,
              fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Inter')),
          ]))
        else
          Positioned(top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(color: Colors.black.withOpacity(0.3),
              child: Center(child: Icon(Icons.live_tv_rounded,
                color: Colors.white.withOpacity(0.2), size: 80)))),

        SafeArea(child: Column(children: [

          // ── Top Bar ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(children: [
              // 🔴 LIVE
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.circular(6)),
                child: const Row(children: [
                  Icon(Icons.circle, color: Colors.white, size: 6),
                  SizedBox(width: 4),
                  Text('LIVE', style: TextStyle(color: Colors.white,
                    fontSize: 10, fontWeight: FontWeight.w900, fontFamily: 'Inter')),
                ])),
              const SizedBox(width: 8),
              Icon(Icons.person_rounded, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(_fmt(widget.stream.viewers),
                style: const TextStyle(color: Colors.white, fontSize: 12,
                  fontFamily: 'Inter')),
              const SizedBox(width: 8),
              Text(widget.stream.duration,
                style: const TextStyle(color: Colors.white54, fontSize: 12,
                  fontFamily: 'Inter')),
              const Spacer(),
              // Close
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Container(width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4), shape: BoxShape.circle),
                  child: const Icon(Icons.close_rounded, color: Colors.white, size: 18))),
            ])),

          // ── ✅ Host Info — قابل للضغط ────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GestureDetector(
              onTap: _openHostProfile,
              child: Row(children: [
                CircleAvatar(radius: 20,
                  backgroundColor: Colors.white.withOpacity(0.15),
                  child: Text(widget.stream.host[0],
                    style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w800, fontSize: 16))),
                const SizedBox(width: 10),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(widget.stream.host, style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700,
                    fontSize: 14, fontFamily: 'Inter')),
                  Text(widget.stream.title, style: const TextStyle(
                    color: Colors.white60, fontSize: 11, fontFamily: 'Inter'),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                ])),
                Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(20)),
                  child: const Text('Follow', style: TextStyle(
                    color: Colors.white, fontSize: 12,
                    fontWeight: FontWeight.w700, fontFamily: 'Inter'))),
              ])),
          ),

          const Spacer(),

          // ── Chat / Viewers toggle ─────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(children: [
              _TabBtn(label: 'Chat',    active: !_showViewers, onTap: () => setState(() => _showViewers = false)),
              const SizedBox(width: 20),
              _TabBtn(label: 'Viewers', active: _showViewers,  onTap: () => setState(() => _showViewers = true)),
            ])),

          // ── Chat List ────────────────────────────────
          if (!_showViewers)
            SizedBox(height: 180,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                itemCount: _chat.length,
                itemBuilder: (_, i) {
                  final msg = _chat[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    // ✅ الضغط على اسم المستخدم في الشات
                    child: GestureDetector(
                      onTap: () => _openUserFromChat(msg),
                      child: Row(children: [
                        Text('@${msg.user} ',
                          style: TextStyle(color: msg.color, fontSize: 12,
                            fontWeight: FontWeight.w700, fontFamily: 'Inter')),
                        Flexible(child: Text(msg.msg,
                          style: const TextStyle(color: Colors.white,
                            fontSize: 12, fontFamily: 'Inter'))),
                      ]),
                    ));
                }))
          else
            SizedBox(height: 180,
              child: Center(child: Text('${_fmt(widget.stream.viewers)} watching',
                style: const TextStyle(color: Colors.white54, fontFamily: 'Inter')))),

          // ── Input Bar ────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Row(children: [
              Expanded(child: Container(height: 42,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(color: Colors.white.withOpacity(0.2))),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(controller: _chatCtrl,
                  style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
                  decoration: const InputDecoration(
                    hintText: 'Say something...',
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none),
                  onSubmitted: (_) => _sendMsg()))),
              const SizedBox(width: 10),
              // ❤️ Like
              GestureDetector(onTap: _toggleLike,
                child: Column(children: [
                  Icon(Icons.favorite_rounded,
                    color: _isLiked ? Colors.red : Colors.white, size: 28),
                  Text(_fmt(_likes), style: const TextStyle(
                    color: Colors.white, fontSize: 10, fontFamily: 'Inter')),
                ])),
              const SizedBox(width: 10),
              // Send
              GestureDetector(onTap: _sendMsg,
                child: Container(width: 40, height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                  child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 18))),
            ])),

          SizedBox(height: safe.bottom),
        ])),
      ]),
    );
  }
}

class _ChatMsg {
  final String user, msg;
  final Color color;
  final bool isOwn;
  const _ChatMsg({required this.user, required this.msg,
    required this.color, this.isOwn = false});
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _TabBtn({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: TextStyle(
        color: active ? Colors.white : Colors.white38,
        fontSize: 14, fontWeight: active ? FontWeight.w700 : FontWeight.w400,
        fontFamily: 'Inter')),
      const SizedBox(height: 4),
      AnimatedContainer(duration: const Duration(milliseconds: 200),
        height: 2, width: active ? 24 : 0,
        decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(1))),
    ]));
}

