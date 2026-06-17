class InteractiveCountdownModel {
  final String id;
  final String eventName;
  final DateTime targetTime;
  final List<String> viewersReady;
  InteractiveCountdownModel({required this.id, required this.eventName, required this.targetTime, this.viewersReady = const []});
}
