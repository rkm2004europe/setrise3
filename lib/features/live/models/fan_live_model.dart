class FanLiveModel {
  final String id;
  final String hostId;
  final int maxViewers;
  final int currentViewers;
  final bool isExclusive;
  FanLiveModel({required this.id, required this.hostId, this.maxViewers = 50, this.currentViewers = 0, this.isExclusive = true});
}
