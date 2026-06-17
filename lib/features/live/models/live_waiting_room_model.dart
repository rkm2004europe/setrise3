class WaitingRoomModel {
  final String roomId;
  final List<String> participants;
  final String? miniGame;
  final DateTime startTime;
  bool isActive;
  WaitingRoomModel({required this.roomId, this.participants = const [], this.miniGame, required this.startTime, this.isActive = true});
}
