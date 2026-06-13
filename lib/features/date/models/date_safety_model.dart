class DateSafetyContact {
  final String name;
  final String phone;
  final bool isEmergency;

  DateSafetyContact({required this.name, required this.phone, this.isEmergency = false});
}

class DateSafetyModel {
  final List<DateSafetyContact> contacts;
  final bool locationSharing;
  final bool panicButton;

  DateSafetyModel({
    this.contacts = const [],
    this.locationSharing = false,
    this.panicButton = true,
  });
}
