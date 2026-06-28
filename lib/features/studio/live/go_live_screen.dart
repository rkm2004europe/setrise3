library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../theme/studio_colors.dart';
import '../widgets/studio_button.dart';
import 'live_host_screen.dart';
import 'live_streaming_service.dart';
import 'live_viewer_screen.dart';

class GoLiveScreen extends ConsumerStatefulWidget {
  const GoLiveScreen({super.key});

  @override
  ConsumerState<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends ConsumerState<GoLiveScreen> {
  final _roomCodeController = TextEditingController();
  bool _isHostMode = true;

  // TODO: replace with your LiveKit server URL + token endpoint.
  static const String _livekitUrl =
      'wss://your-livekit-server.example.com';
  static const String _placeholderToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';

  @override
  void dispose() {
    _roomCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StudioColors.canvas,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(StudioSpacing.xl),
                children: [
                  _buildModeSelector(),
                  const SizedBox(height: StudioSpacing.xxl),
                  if (_isHostMode)
                    _buildHostPreview()
                  else
                    _buildViewerJoin(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(StudioSpacing.md),
      child: Row(
        children: [
          StudioButton(
            icon: Icons.arrow_back_ios,
            label: '',
            variant: StudioButtonVariant.secondary,
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          const Text('Go Live',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: StudioColors.textPrimary)),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildModeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: StudioColors.surfaceRaised,
        borderRadius: BorderRadius.circular(StudioRadius.pill),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isHostMode = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isHostMode
                      ? StudioColors.accent
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(StudioRadius.pill),
                ),
                child: Center(
                  child: Text('Host',
                      style: TextStyle(
                          color: _isHostMode
                              ? Colors.white
                              : StudioColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isHostMode = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isHostMode
                      ? StudioColors.accent
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(StudioRadius.pill),
                ),
                child: Center(
                  child: Text('Join',
                      style: TextStyle(
                          color: !_isHostMode
                              ? Colors.white
                              : StudioColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostPreview() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: StudioColors.surfaceRaised,
            borderRadius: BorderRadius.circular(StudioRadius.xl),
            border: Border.all(
                color: StudioColors.separator, width: 0.5),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.videocam,
                    color: StudioColors.textTertiary, size: 64),
                SizedBox(height: StudioSpacing.md),
                Text('Camera preview will appear here',
                    style: TextStyle(
                        color: StudioColors.textTertiary,
                        fontSize: 13)),
              ],
            ),
          ),
        ),
        const SizedBox(height: StudioSpacing.xl),
        const _LiveTipsCard(),
        const SizedBox(height: StudioSpacing.xl),
        StudioButton(
          label: 'Go Live Now',
          icon: Icons.bolt,
          size: StudioButtonSize.large,
          fullWidth: true,
          onPressed: _startHostLive,
        ),
      ],
    );
  }

  Widget _buildViewerJoin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter Room Code',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: StudioColors.textSecondary)),
        const SizedBox(height: StudioSpacing.md),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: StudioSpacing.lg),
          decoration: BoxDecoration(
            color: StudioColors.surfaceRaised,
            borderRadius: BorderRadius.circular(StudioRadius.md),
          ),
          child: TextField(
            controller: _roomCodeController,
            style: const TextStyle(
                color: StudioColors.textPrimary,
                fontSize: 16,
                letterSpacing: 2),
            decoration: const InputDecoration(
              hintText: 'ABCD-1234',
              hintStyle: TextStyle(
                  color: StudioColors.textTertiary, letterSpacing: 2),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: StudioSpacing.xl),
        StudioButton(
          label: 'Join Stream',
          icon: Icons.login,
          size: StudioButtonSize.large,
          fullWidth: true,
          onPressed: _joinStream,
        ),
      ],
    );
  }

  Future<void> _startHostLive() async {
    final config = LiveRoomConfig(
      url: _livekitUrl,
      token: _placeholderToken,
      roomId: 'host_${DateTime.now().millisecondsSinceEpoch}',
      identity: 'host',
      name: 'Host',
      isHost: true,
    );
    if (mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => LiveHostScreen(config: config),
      ));
    }
  }

  Future<void> _joinStream() async {
    final roomCode = _roomCodeController.text.trim();
    if (roomCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a room code')),
      );
      return;
    }
    final config = LiveRoomConfig(
      url: _livekitUrl,
      token: _placeholderToken,
      roomId: roomCode,
      identity: 'viewer_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Viewer',
      isHost: false,
    );
    if (mounted) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => LiveViewerScreen(config: config),
      ));
    }
  }
}

class _LiveTipsCard extends StatelessWidget {
  const _LiveTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(StudioSpacing.lg),
      decoration: BoxDecoration(
        color: StudioColors.surfaceRaised.withOpacity(0.5),
        borderRadius: BorderRadius.circular(StudioRadius.lg),
        border: Border.all(
            color: StudioColors.separator, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline,
                  color: StudioColors.warning, size: 18),
              const SizedBox(width: StudioSpacing.sm),
              const Text('Before you go live',
                  style: TextStyle(
                      color: StudioColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 14)),
            ],
          ),
          const SizedBox(height: StudioSpacing.md),
          const _Tip(text: 'Find a quiet, well-lit place'),
          const _Tip(text: 'Connect to Wi-Fi to avoid data charges'),
          const _Tip(
              text:
                  'Your camera and mic will be active immediately'),
          const _Tip(text: 'Tap End to stop broadcasting'),
        ],
      ),
    );
  }
}

class _Tip extends StatelessWidget {
  const _Tip({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.check_circle,
                color: StudioColors.accentTertiary, size: 14),
          ),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    color: StudioColors.textSecondary,
                    fontSize: 13,
                    height: 1.4)),
          ),
        ],
      ),
    );
  }
}
