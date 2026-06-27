library;

import 'dart:async';

import 'package:livekit_client/livekit_client.dart';

enum LiveConnectionState {
  disconnected,
  connecting,
  connected,
  reconnecting,
  failed,
}

class LiveParticipant {
  final String identity;
  final String? name;
  final String? avatarUrl;
  final bool isHost;
  final bool isMicEnabled;
  final bool isCameraEnabled;
  final bool isSpeaking;
  final int? audioLevel;

  const LiveParticipant({
    required this.identity,
    this.name,
    this.avatarUrl,
    this.isHost = false,
    this.isMicEnabled = false,
    this.isCameraEnabled = false,
    this.isSpeaking = false,
    this.audioLevel,
  });
}

class LiveChatMessage {
  final String id;
  final String senderId;
  final String? senderName;
  final String text;
  final DateTime timestamp;
  final bool isSystem;

  const LiveChatMessage({
    required this.id,
    required this.senderId,
    this.senderName,
    required this.text,
    required this.timestamp,
    this.isSystem = false,
  });
}

class LiveRoomConfig {
  final String url;
  final String token;
  final String roomId;
  final String identity;
  final String? name;
  final bool isHost;

  const LiveRoomConfig({
    required this.url,
    required this.token,
    required this.roomId,
    required this.identity,
    this.name,
    this.isHost = false,
  });
}

class LiveStreamingService {
  LiveStreamingService();

  Room? _room;
  LocalParticipant? _localParticipant;

  final StreamController<LiveConnectionState> _connectionStateController =
      StreamController<LiveConnectionState>.broadcast();
  Stream<LiveConnectionState> get connectionState =>
      _connectionStateController.stream;

  final StreamController<List<LiveParticipant>> _participantsController =
      StreamController<List<LiveParticipant>>.broadcast();
  Stream<List<LiveParticipant>> get participants =>
      _participantsController.stream;

  final StreamController<LiveChatMessage> _chatController =
      StreamController<LiveChatMessage>.broadcast();
  Stream<LiveChatMessage> get chatMessages => _chatController.stream;

  final StreamController<Map<String, int>> _reactionsController =
      StreamController<Map<String, int>>.broadcast();
  Stream<Map<String, int>> get reactions => _reactionsController.stream;

  LiveConnectionState _state = LiveConnectionState.disconnected;
  LiveConnectionState get state => _state;
  Map<String, int>? _lastReactions;

  Future<void> connect(LiveRoomConfig config) async {
    if (_state == LiveConnectionState.connected) {
      throw StateError('Already connected');
    }

    _setState(LiveConnectionState.connecting);

    try {
      _room = await Room.connect(
        config.url,
        config.token,
        roomOptions: RoomOptions(
          adaptiveStream: true,
          dynacast: true,
          defaultVideoPublishOptions: const VideoPublishOptions(
            codec: VideoCodec.h264,
            backupVideoCodec: const BackupVideoCodec(
              codec: VideoCodec.vp8,
              enabled: true,
            ),
          ),
        ),
        connectOptions: const ConnectOptions(
          autoSubscribe: true,
        ),
      );

      _localParticipant = _room!.localParticipant;
      _setupRoomListeners();

      if (config.isHost) {
        await _enableCamera();
        await _enableMicrophone();
      }

      _setState(LiveConnectionState.connected);
    } on Object catch (e) {
      _setState(LiveConnectionState.failed);
      throw StateError('Failed to connect: $e');
    }
  }

  Future<void> disconnect() async {
    await _room?.disconnect();
    _room = null;
    _localParticipant = null;
    _setState(LiveConnectionState.disconnected);
  }

  Future<void> enableCamera() async => _enableCamera();
  Future<void> disableCamera() async =>
      await _localParticipant?.setCameraEnabled(false);
  Future<void> enableMicrophone() async => _enableMicrophone();
  Future<void> disableMicrophone() async =>
      await _localParticipant?.setMicrophoneEnabled(false);

  Future<void> switchCamera() async {
    await _localParticipant?.setCameraEnabled(true);
    await LocalParticipant.trackSwitchCamera();
  }

  Future<void> sendChatMessage(String text) async {
    if (_localParticipant == null) return;
    final payload = {
      'type': 'chat',
      'senderId': _localParticipant!.identity,
      'senderName': _localParticipant!.name,
      'text': text,
      'timestamp': DateTime.now().toIso8601String(),
    };
    await _localParticipant!.publishDataMessage(
      DataMessage(
        topic: 'chat',
        data: payload.toString().codeUnits,
      ),
    );
  }

  Future<void> sendReaction(String emoji) async {
    if (_localParticipant == null) return;
    final payload = {
      'type': 'reaction',
      'senderId': _localParticipant!.identity,
      'emoji': emoji,
      'timestamp': DateTime.now().toIso8601String(),
    };
    await _localParticipant!.publishDataMessage(
      DataMessage(
        topic: 'reaction',
        data: payload.toString().codeUnits,
      ),
    );
  }

  Room? get room => _room;
  LocalParticipant? get localParticipant => _localParticipant;

  Future<void> _enableCamera() async {
    await _localParticipant?.setCameraEnabled(true);
  }

  Future<void> _enableMicrophone() async {
    await _localParticipant?.setMicrophoneEnabled(true);
  }

  void _setupRoomListeners() {
    final room = _room;
    if (room == null) return;

    room.addListener(() {
      if (room.connectionState == ConnectionState.connected) {
        _setState(LiveConnectionState.connected);
      } else if (room.connectionState == ConnectionState.reconnecting) {
        _setState(LiveConnectionState.reconnecting);
      } else if (room.connectionState == ConnectionState.disconnected) {
        _setState(LiveConnectionState.disconnected);
      }
    });

    room.events.listen((event) {
      if (event is ParticipantConnectedEvent) {
        _emitParticipants();
      } else if (event is ParticipantDisconnectedEvent) {
        _emitParticipants();
      } else if (event is DataReceivedEvent) {
        _handleDataMessage(event);
      } else if (event is TrackSubscribedEvent) {
        _emitParticipants();
      } else if (event is TrackUnsubscribedEvent) {
        _emitParticipants();
      } else if (event is ActiveSpeakerChangedEvent) {
        _emitParticipants(speakers: event.speakers);
      }
    });
  }

  void _emitParticipants({List<Participant>? speakers}) {
    final room = _room;
    if (room == null) return;

    final speakerIds =
        (speakers ?? const []).map((p) => p.identity).toSet();

    final participants = <LiveParticipant>[];

    final local = room.localParticipant;
    participants.add(LiveParticipant(
      identity: local.identity,
      name: local.name,
      isHost: true,
      isMicEnabled: local.isMicrophoneEnabled(),
      isCameraEnabled: local.isCameraEnabled(),
      isSpeaking: speakerIds.contains(local.identity),
    ));

    for (final remote in room.remoteParticipants.values) {
      participants.add(LiveParticipant(
        identity: remote.identity,
        name: remote.name,
        isMicEnabled: remote.hasAudio,
        isCameraEnabled: remote.hasVideo,
        isSpeaking: speakerIds.contains(remote.identity),
      ));
    }

    _participantsController.add(participants);
  }

  void _handleDataMessage(DataReceivedEvent event) {
    try {
      final payloadStr = String.fromCharCodes(event.data);
      if (payloadStr.contains('"type":"chat"')) {
        final message = LiveChatMessage(
          id:
              '${event.from?.identity}_${DateTime.now().millisecondsSinceEpoch}',
          senderId: event.from?.identity ?? 'unknown',
          senderName: event.from?.name,
          text: _extractField(payloadStr, 'text'),
          timestamp: DateTime.now(),
        );
        _chatController.add(message);
      } else if (payloadStr.contains('"type":"reaction"')) {
        final emoji = _extractField(payloadStr, 'emoji');
        final current = _lastReactions ?? <String, int>{};
        final updated = Map<String, int>.from(current);
        updated[emoji] = (updated[emoji] ?? 0) + 1;
        _lastReactions = updated;
        _reactionsController.add(updated);
      }
    } on Object {
      // Ignore malformed messages.
    }
  }

  String _extractField(String json, String field) {
    final regex = RegExp('"$field":"([^"]*)"');
    final match = regex.firstMatch(json);
    return match?.group(1) ?? '';
  }

  void _setState(LiveConnectionState newState) {
    _state = newState;
    _connectionStateController.add(newState);
  }

  Future<void> dispose() async {
    await disconnect();
    await _connectionStateController.close();
    await _participantsController.close();
    await _chatController.close();
    await _reactionsController.close();
  }
}
