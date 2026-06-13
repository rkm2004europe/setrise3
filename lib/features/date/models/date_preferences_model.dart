class DatePreferencesModel {
  final int minAge;
  final int maxAge;
  final int maxDistance; // كيلومتر
  final String? gender;
  final List<String> interests;

  DatePreferencesModel({
    this.minAge = 18,
    this.maxAge = 45,
    this.maxDistance = 50,
    this.gender,
    this.interests = const [],
  });
}
