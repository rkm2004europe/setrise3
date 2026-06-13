class DateUserModel {
  final String id;
  final String name;
  final int age;
  final String bio;
  final List<String> photos; // أول صورة هي الرئيسية
  final List<String> interests;
  final String? distance;
  final bool isVerified;
  final bool isOnline;
  final String? jobTitle;
  final String? education;

  DateUserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.bio,
    required this.photos,
    required this.interests,
    this.distance,
    this.isVerified = false,
    this.isOnline = false,
    this.jobTitle,
    this.education,
  });
}
