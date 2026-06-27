library;

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';

import '../theme/studio_colors.dart';
import '../widgets/studio_button.dart';

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({super.key});

  @override
  ConsumerState<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends ConsumerState<AudioScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final AudioRecorder _recorder = AudioRecorder();
  late final RecorderController _recorderWaveController;
  late final PlayerController _playerWaveController;
  final AudioPlayer _musicPlayer = AudioPlayer();
  bool _isRecording = false;
  bool _isMusicPlaying = false;
  double _musicVolume = 0.8;
  double _voiceVolume = 1.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _recorderWaveController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..sampleRate = 44100
      ..bitRate = 128000;
    _playerWaveController = PlayerController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _recorderWaveController.dispose();
    _playerWaveController.dispose();
    _recorder.dispose();
    _musicPlayer.dispose();
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
            TabBar(
              controller: _tabController,
              indicatorColor: StudioColors.accent,
              labelColor: StudioColors.textPrimary,
              unselectedLabelColor: StudioColors.textTertiary,
              tabs: const [
                Tab(icon: Icon(Icons.music_note), text: 'Music'),
                Tab(icon: Icon(Icons.mic), text: 'Voice'),
                Tab(icon: Icon(Icons.equalizer), text: 'Mix'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMusicTab(),
                  _buildVoiceTab(),
                  _buildMixTab(),
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
            icon: Icons.close,
            label: '',
            variant: StudioButtonVariant.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Spacer(),
          const Text('Audio Studio',
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

  Widget _buildMusicTab() {
    return ListView(
      padding: const EdgeInsets.all(StudioSpacing.xl),
      children: [
        Container(
          padding: const EdgeInsets.all(StudioSpacing.lg),
          decoration: BoxDecoration(
            color: StudioColors.surfaceRaised,
            borderRadius: BorderRadius.circular(StudioRadius.lg),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: StudioColors.accent.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(StudioRadius.md),
                    ),
                    child: const Icon(Icons.music_note,
                        color: StudioColors.accent),
                  ),
                  const SizedBox(width: StudioSpacing.md),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No track selected',
                            style: TextStyle(
                                color: StudioColors.textPrimary,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Text('Tap below to pick a song',
                            style: TextStyle(
                                color: StudioColors.textTertiary,
                                fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: StudioSpacing.lg),
              AudioFileWaveforms(
                playerController: _playerWaveController,
                size: const Size(double.infinity, 70),
                waveformType: WaveformType.fitWidth,
                playerWaveStyle: const PlayerWaveStyle(
                  fixedWaveColor: Colors.white30,
                  liveWaveColor: StudioColors.accent,
                  spacing: 6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: StudioSpacing.xl),
        StudioButton(
          label: 'Pick from library',
          icon: Icons.library_music,
          variant: StudioButtonVariant.secondary,
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: StudioSpacing.md),
        Container(
          padding: const EdgeInsets.all(StudioSpacing.md),
          decoration: BoxDecoration(
            color: StudioColors.surfaceRaised,
            borderRadius: BorderRadius.circular(StudioRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Music Volume',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: StudioColors.textSecondary)),
              Slider(
                value: _musicVolume,
                onChanged: (v) => setState(() {
                  _musicVolume = v;
                  _musicPlayer.setVolume(v);
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Voice Over',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: StudioColors.textSecondary)),
          const SizedBox(height: StudioSpacing.xxl),
          if (_isRecording)
            AudioWaveforms(
              recorderController: _recorderWaveController,
              size: const Size(280, 80),
              waveStyle: const WaveStyle(
                waveColor: StudioColors.accent,
                extendWaveform: true,
                showMiddleLine: false,
              ),
            )
          else
            Container(
              width: 280,
              height: 80,
              decoration: BoxDecoration(
                color: StudioColors.surfaceRaised,
                borderRadius: BorderRadius.circular(StudioRadius.md),
              ),
              child: const Center(
                child: Text('Press the mic to record',
                    style: TextStyle(
                        color: StudioColors.textTertiary, fontSize: 13)),
              ),
            ),
          const SizedBox(height: StudioSpacing.xxl),
          GestureDetector(
            onTap: _toggleRecording,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _isRecording
                    ? StudioColors.error
                    : StudioColors.accent,
                shape: _isRecording
                    ? BoxShape.rectangle
                    : BoxShape.circle,
                borderRadius: _isRecording
                    ? BorderRadius.circular(20)
                    : null,
              ),
              child: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMixTab() {
    return ListView(
      padding: const EdgeInsets.all(StudioSpacing.xl),
      children: [
        const Text('Mix Levels',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: StudioColors.textSecondary)),
        const SizedBox(height: StudioSpacing.xl),
        _volumeSlider(
            label: 'Music',
            icon: Icons.music_note,
            value: _musicVolume,
            color: StudioColors.trackAudio,
            onChanged: (v) => setState(() {
                  _musicVolume = v;
                  _musicPlayer.setVolume(v);
                })),
        const SizedBox(height: StudioSpacing.md),
        _volumeSlider(
            label: 'Voice Over',
            icon: Icons.mic,
            value: _voiceVolume,
            color: StudioColors.accent,
            onChanged: (v) => setState(() => _voiceVolume = v)),
      ],
    );
  }

  Widget _volumeSlider({
    required String label,
    required IconData icon,
    required double value,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: StudioSpacing.lg, vertical: StudioSpacing.md),
      decoration: BoxDecoration(
        color: StudioColors.surfaceRaised,
        borderRadius: BorderRadius.circular(StudioRadius.md),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: StudioSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: StudioColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
                Slider(value: value, activeColor: color, onChanged: onChanged),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Text('${(value * 100).round()}%',
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 11),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _recorderWaveController.stop();
      setState(() => _isRecording = false);
    } else {
      if (!await _recorder.hasPermission()) return;
      final path =
          '/tmp/studio_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorderWaveController.record(path: path);
      setState(() => _isRecording = true);
    }
  }
}
