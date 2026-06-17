class MultiAngleLiveModel {
  final String roomId;
  final List<String> cameraAngles; // 'front', 'back', 'guest1', 'screen'
  String currentAngle;
  MultiAngleLiveModel({required this.roomId, this.cameraAngles = const ['front', 'back'], this.currentAngle = 'front'});
}
