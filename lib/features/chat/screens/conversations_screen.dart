// lib/features/chat/screens/conversations_screen.dart
// ✅ قائمة المحادثات — يُستدعى من BottomNav

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setrise/features/chat/models/chat_models.dart';
import 'package:setrise/features/chat/screens/chat_screen.dart';
import 'package:setrise/features/chat/screens/widgets/conversation_tile.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  final _convos = Conversation.getMockConversations();

  List<Conversation> get _filtered => _query.isEmpty ? _convos
      : _convos.where((c) => c.name.toLowerCase().contains(_query)).toList();

  void _openChat(Conversation c) {
    Navigator.push(context, CupertinoPageRoute(
      builder: (_) => ChatScreen(conversation: c)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: CustomScrollView(slivers: [
        // ── Header ───────────────────────────────────────
        CupertinoSliverNavigationBar(
          backgroundColor: const Color(0xFFF2F2F7),
          largeTitle: const Text('Messages'),
          trailing: CupertinoButton(padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Icon(CupertinoIcons.pencil_circle_fill,
              color: Color(0xFF007AFF), size: 28))),

        // ── Search ────────────────────────────────────────
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: CupertinoSearchTextField(
            controller: _searchCtrl,
            placeholder: 'Search',
            onChanged: (v) => setState(() => _query = v.toLowerCase())))),

        // ── Pinned & Conversations ────────────────────────
        SliverList(delegate: SliverChildBuilderDelegate(
          (_, i) {
            final c = _filtered[i];
            return Column(children: [
              ConversationTile(conversation: c, onTap: () => _openChat(c)),
              const Divider(height: 0.5, indent: 72, color: Color(0xFFE5E5EA)),
            ]);
          },
          childCount: _filtered.length)),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ]),
    );
  }
}

