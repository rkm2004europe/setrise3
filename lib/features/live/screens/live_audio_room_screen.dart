import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/live_audio_room_model.dart';
import '../models/speaker_model.dart';
import '../widgets/audio_room_controls.dart';
import '../widgets/coin_balance_widget.dart';
import '../widgets/share_live_button.dart';
import '../../user/screens/user_preview_sheet.dart';

class LiveAudioRoomScreen extends StatefulWidget {
  final LiveAudioRoomModel room;
  const LiveAudioRoomScreen({super.key, required this.room});

  @override
  State<LiveAudioRoomScreen> createState() => _LiveAudioRoomScreenState();
}

class _LiveAudioRoomScreenState extends State<LiveAudioRoomScreen> {
  late LiveAudioRoomModel _room;
  bool _isMuted = true;
  bool _handRaised = false;

  @override
  void initState() {
    super.initState();
    _room = widget.room;
  }

  void _toggleMute() => setState(() => _isMuted = !_isMuted);
  
  void _toggleRaiseHand() {
    setState(() {
      _handRaised = !_handRaised;
      if (_handRaised) {
        _room.raisedHands = [..._room.raisedHands, 'me'];
      } else {
        _room.raisedHands = _room.raisedHands.where((id) => id != 'me').toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // خلفية داكنة أنيقة
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [LiveColors.surface, LiveColors.bg],
                ),
              ),
            ),

            Column(
              children: [
                // شريط علوي
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: LiveColors.surface.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, color: LiveColors.text),
                        ),
                      ),
                      const Spacer(),
                      // مشاركة الغرفة
                      ShareLiveButton(room: LiveRoomModel(
                        id: _room.id, hostId: _room.hostId, hostName: _room.hostName,
                        hostAvatar: _room.hostAvatar, title: _room.title, viewerCount: _room.listenerCount,
                      )),
                    ],
                  ),
                ),

                const Spacer(),

                // عنوان الغرفة والمضيف
                GestureDetector(
                  onTap: () => showUserPreviewSheet(
                    context, userId: _room.hostId, userName: _room.hostName,
                    username: '@${_room.hostName}', accent: LiveColors.accent,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: LiveColors.accent.withOpacity(0.1),
                          border: Border.all(color: LiveColors.accent, width: 2),
                        ),
                        child: Center(child: Text(_room.hostAvatar, style: const TextStyle(fontSize: 40))),
                      ),
                      const SizedBox(height: 12),
                      Text(_room.title, style: const TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Text('${_room.listenerCount} مستمع', style: const TextStyle(color: LiveColors.text2)),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // المتحدثون
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _room.speakers.length,
                    itemBuilder: (_, i) {
                      final spk = _room.speakers[i];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () => showUserPreviewSheet(
                            context, userId: spk.userId, userName: spk.userName,
                            username: '@${spk.userName}', accent: LiveColors.accent,
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: LiveColors.accent.withOpacity(0.1),
                                    child: Text(spk.avatar, style: const TextStyle(fontSize: 24)),
                                  ),
                                  if (spk.isSpeaking)
                                    Positioned(
                                      bottom: 0, right: 0,
                                      child: Container(
                                        width: 16, height: 16,
                                        decoration: const BoxDecoration(
                                          color: LiveColors.online,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  if (spk.isMuted)
                                    Positioned(
                                      bottom: 0, right: 0,
                                      child: Container(
                                        width: 16, height: 16,
                                        decoration: BoxDecoration(
                                          color: LiveColors.bg,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: LiveColors.text2),
                                        ),
                                        child: const Icon(Icons.mic_off, size: 10, color: LiveColors.text2),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(spk.userName, style: const TextStyle(color: LiveColors.text, fontSize: 12)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const Spacer(),

                // أدوات التحكم (كتم، رفع اليد، مغادرة)
                AudioRoomControls(
                  isMuted: _isMuted,
                  handRaised: _handRaised,
                  onToggleMute: _toggleMute,
                  onToggleHand: _toggleRaiseHand,
                ),
                const SizedBox(height: 20),
              ],
            ),

            // رصيد العملات
            Positioned(top: 60, right: 10, child: CoinBalanceWidget()),
          ],
        ),
      ),
    );
  }
}
