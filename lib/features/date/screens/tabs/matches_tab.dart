// lib/features/date/screens/tabs/matches_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setrise/features/date/models/dating_profile_model.dart';

class MatchesTab extends StatefulWidget {
  const MatchesTab({super.key});
  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  int _tab = 0;
  final _searchCtrl = TextEditingController();
  String _query = '';
  bool _searching = false;

  final _matches = MatchModel.mockMatches();
  List<MatchModel> get _newMatches => _matches.where((m) => m.isNew).toList();
  List<MatchModel> get _convos     => _matches.where((m) => !m.isNew).toList();

  List<MatchModel> _filter(List<MatchModel> src) => _query.isEmpty
      ? src
      : src.where((m) => m.name.toLowerCase().contains(_query)).toList();

  void _openChat(MatchModel m) {
    HapticFeedback.selectionClick();
    // ✅ يفتح شات التطبيق الرئيسي
    // TODO: Navigator.of(context, rootNavigator: true).pushNamed('/chat/${m.id}');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Opening chat with ${m.name}'),
      backgroundColor: const Color(0xFFFF3B30), duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // ── Header ─────────────────────────────────────────
      Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Row(children: [
          if (!_searching) ...[
            ShaderMask(
              shaderCallback: (b) => const LinearGradient(
                colors: [Color(0xFFFF3B30), Color(0xFFFF6584)]).createShader(b),
              child: const Text('Matches', style: TextStyle(color: Colors.white,
                fontSize: 26, fontWeight: FontWeight.w900, fontFamily: 'Inter'))),
            const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30).withOpacity(0.12),
                borderRadius: BorderRadius.circular(10)),
              child: Text('${_matches.length}', style: const TextStyle(
                color: Color(0xFFFF3B30), fontSize: 13,
                fontWeight: FontWeight.w800, fontFamily: 'Inter'))),
            const Spacer(),
            GestureDetector(onTap: () => setState(() => _searching = true),
              child: Container(width: 36, height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08), shape: BoxShape.circle),
                child: const Icon(Icons.search_rounded, color: Colors.white, size: 18))),
          ] else ...[
            Expanded(child: TextField(
              controller: _searchCtrl, autofocus: true,
              style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
              onChanged: (v) => setState(() => _query = v.toLowerCase()),
              decoration: const InputDecoration(
                hintText: 'Search matches...', border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white38)))),
            TextButton(onPressed: () => setState(() {
              _searching = false; _searchCtrl.clear(); _query = '';
            }), child: const Text('Cancel',
              style: TextStyle(color: Color(0xFFFF3B30), fontFamily: 'Inter'))),
          ],
        ])),

      const SizedBox(height: 12),

      // ── Tabs ────────────────────────────────────────────
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: ['All', 'New', 'Messages'].asMap().entries.map((e) {
          final active = _tab == e.key;
          return GestureDetector(
            onTap: () { HapticFeedback.selectionClick(); setState(() => _tab = e.key); },
            child: Container(margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                color: active ? const Color(0xFFFF3B30) : Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(20)),
              child: Text(e.value, style: TextStyle(
                color: Colors.white,
                fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                fontSize: 13, fontFamily: 'Inter'))));
        }).toList())),

      const SizedBox(height: 16),

      // ── Content ─────────────────────────────────────────
      Expanded(child: _tab == 2
        // Messages List
        ? ListView(children: _filter(_convos).map((m) =>
            _ConvoTile(match: m, onTap: () => _openChat(m))).toList())
        : ListView(children: [
            // New Matches Grid
            if (_tab != 1 && _filter(_newMatches).isNotEmpty) ...[
              const Padding(padding: EdgeInsets.fromLTRB(16, 0, 0, 10),
                child: Text('New Matches', style: TextStyle(color: Colors.white54,
                  fontSize: 12, fontWeight: FontWeight.w700,
                  fontFamily: 'Inter', letterSpacing: 0.5))),
              SizedBox(height: 160,
                child: ListView(scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: _filter(_newMatches).map((m) => Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _NewMatchCard(match: m, onTap: () => _openChat(m)))).toList())),
              const SizedBox(height: 20),
            ],
            // Conversations
            if (_filter(_tab == 1 ? _newMatches : _convos).isNotEmpty) ...[
              if (_tab != 1)
                const Padding(padding: EdgeInsets.fromLTRB(16, 0, 0, 10),
                  child: Text('Messages', style: TextStyle(color: Colors.white54,
                    fontSize: 12, fontWeight: FontWeight.w700,
                    fontFamily: 'Inter', letterSpacing: 0.5))),
              ..._filter(_tab == 1 ? _newMatches : _convos).map((m) =>
                  _ConvoTile(match: m, onTap: () => _openChat(m))),
            ],
          ])),
    ]);
  }
}

class _NewMatchCard extends StatelessWidget {
  final MatchModel match;
  final VoidCallback onTap;
  const _NewMatchCard({required this.match, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: SizedBox(width: 110,
      child: Column(children: [
        Stack(children: [
          ClipRRect(borderRadius: BorderRadius.circular(16),
            child: Image.network(match.imageUrl, width: 100, height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(width: 100, height: 120,
                color: Colors.white12,
                child: Center(child: Text(match.name[0],
                  style: const TextStyle(color: Colors.white,
                    fontSize: 32, fontWeight: FontWeight.w900)))))),
          if (match.isNew)
            Positioned(top: 8, left: 8,
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF3B30), Color(0xFFFF6584)]),
                  borderRadius: BorderRadius.circular(6)),
                child: const Text('NEW', style: TextStyle(color: Colors.white,
                  fontSize: 9, fontWeight: FontWeight.w900)))),
          if (match.isOnline)
            Positioned(bottom: 6, right: 6,
              child: Container(width: 12, height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759), shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2)))),
        ]),
        const SizedBox(height: 6),
        Text(match.name, style: const TextStyle(color: Colors.white, fontSize: 13,
          fontWeight: FontWeight.w700, fontFamily: 'Inter'),
          overflow: TextOverflow.ellipsis),
      ])));
}

class _ConvoTile extends StatelessWidget {
  final MatchModel match;
  final VoidCallback onTap;
  const _ConvoTile({required this.match, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasUnread = match.unreadCount > 0;
    return GestureDetector(onTap: onTap,
      child: Container(margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: hasUnread ? const Color(0xFFFF3B30).withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: hasUnread
            ? const Color(0xFFFF3B30).withOpacity(0.15)
            : Colors.white.withOpacity(0.05))),
        child: Row(children: [
          Stack(children: [
            CircleAvatar(radius: 28,
              backgroundColor: Colors.white12,
              backgroundImage: NetworkImage(match.imageUrl)),
            if (match.isOnline)
              Positioned(bottom: 0, right: 0,
                child: Container(width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759), shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2)))),
          ]),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(match.name, style: TextStyle(color: Colors.white, fontSize: 15,
                fontWeight: hasUnread ? FontWeight.w800 : FontWeight.w600,
                fontFamily: 'Inter')),
              const Spacer(),
              Text(match.timeAgo, style: TextStyle(
                color: hasUnread ? const Color(0xFFFF3B30) : Colors.white38,
                fontSize: 11, fontFamily: 'Inter')),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              Expanded(child: Text(match.lastMessage ?? 'Say hello! 👋',
                style: TextStyle(color: hasUnread ? Colors.white70 : Colors.white38,
                  fontSize: 13, fontFamily: 'Inter'),
                maxLines: 1, overflow: TextOverflow.ellipsis)),
              if (hasUnread) ...[
                const SizedBox(width: 8),
                Container(width: 20, height: 20,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF3B30), shape: BoxShape.circle),
                  child: Center(child: Text('${match.unreadCount}',
                    style: const TextStyle(color: Colors.white, fontSize: 11,
                      fontWeight: FontWeight.w800)))),
              ],
            ]),
          ])),
        ])));
  }
}

