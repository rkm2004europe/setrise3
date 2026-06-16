import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/voice_room_model.dart';
import '../data/mock_voice_participants.dart';
import '../widgets/voice_participant_tile.dart';
import '../widgets/voice_room_controls.dart';
import '../../user/screens/user_preview_sheet.dart';

class VoiceRoomScreen extends StatefulWidget {
  final VoiceRoomModel room;
  const VoiceRoomScreen({super.key, required this.room});

  @override
  State<VoiceRoomScreen> createState() => _VoiceRoomScreenState();
}

class _VoiceRoomScreenState extends State<VoiceRoomScreen> {
  late List<VoiceRoomParticipant> _participants;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _participants = List.from(mockVoiceParticipants);
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
  }

  void _raiseHand() {
    final me = _participants.firstWhere((p) => p.userId == 'u3', orElse: () => _participants[0]);
    setState(() => me.hasRaisedHand = !me.hasRaisedHand);
  }

  void _leave() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final host = _participants.firstWhere((p) => p.role == VoiceRoomRole.host);
    final speakers = _participants.where((p) => p.role == VoiceRoomRole.speaker).toList();
    final listeners = _participants.where((p) => p.role == VoiceRoomRole.listener).toList();

    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // شريط علوي مع معلومات الغرفة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: LiveColors.border))),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _leave,
                    child: const Icon(Icons.arrow_back, color: LiveColors.text, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(color: LiveColors.accent.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                    child: Center(child: Text(widget.room.topicEmoji ?? '🎙️', style: const TextStyle(fontSize: 24))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(widget.room.title, style: const TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800, fontSize: 16)),
                      Text('${widget.room.listenerCount} مستمع • ${widget.room.speakerCount} متحدث', style: const TextStyle(color: LiveColors.text2, fontSize: 12)),
                    ]),
                  ),
                ],
              ),
            ),

            // المتحدثون (Speakers)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  // المضيف
                  _buildSectionTitle('المضيف'),
                  VoiceParticipantTile(
                    participant: host,
                    onTap: () => showUserPreviewSheet(context, userId: host.userId, userName: host.userName, username: '@${host.userName}', accent: LiveColors.accent),
                    onToggleMute: host.userId == 'me' ? _toggleMute : null,
                  ),

                  // المتحدثون
                  if (speakers.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildSectionTitle('المتحدثون'),
                    ...speakers.map((speaker) => VoiceParticipantTile(
                      participant: speaker,
                      onTap: () => showUserPreviewSheet(context, userId: speaker.userId, userName: speaker.userName, username: '@${speaker.userName}', accent: LiveColors.accent),
                    )),
                  ],

                  // المستمعون
                  if (listeners.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildSectionTitle('المستمعون'),
                    ...listeners.map((listener) => VoiceParticipantTile(
                      participant: listener,
                      onTap: () => showUserPreviewSheet(context, userId: listener.userId, userName: listener.userName, username: '@${listener.userName}', accent: LiveColors.accent),
                    )),
                  ],
                ],
              ),
            ),

            // أزرار التحكم (Controls)
            VoiceRoomControls(
              isMuted: _isMuted,
              hasRaisedHand: _participants.firstWhere((p) => p.userId == 'u3', orElse: () => _participants[0]).hasRaisedHand,
              onToggleMute: _toggleMute,
              onRaiseHand: _raiseHand,
              onLeave: _leave,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(title, style: const TextStyle(color: LiveColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
  );
}
