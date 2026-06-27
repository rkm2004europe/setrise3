library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'live_streaming_service.dart';

final liveStreamingServiceProvider = Provider<LiveStreamingService>((ref) {
  final service = LiveStreamingService();
  ref.onDispose(service.dispose);
  return service;
});

final liveConnectionStateProvider = StreamProvider<LiveConnectionState>((ref) {
  return ref.watch(liveStreamingServiceProvider).connectionState;
});

final liveParticipantsProvider =
    StreamProvider<List<LiveParticipant>>((ref) {
  return ref.watch(liveStreamingServiceProvider).participants;
});

final liveChatProvider = StreamProvider<LiveChatMessage>((ref) {
  return ref.watch(liveStreamingServiceProvider).chatMessages;
});

final liveReactionsProvider = StreamProvider<Map<String, int>>((ref) {
  return ref.watch(liveStreamingServiceProvider).reactions;
});

final isLiveProvider = Provider<bool>((ref) {
  final state = ref.watch(liveConnectionStateProvider).valueOrNull;
  return state == LiveConnectionState.connected;
});

final liveChatHistoryProvider = Provider<List<LiveChatMessage>>((ref) {
  final messages = <LiveChatMessage>[];
  ref.watch(liveChatProvider).whenData((m) {
    messages.add(m);
    if (messages.length > 50) messages.removeAt(0);
  });
  return messages;
});
