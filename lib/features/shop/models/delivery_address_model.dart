class DeliveryAddressModel {
  final String id;
  final String address;
  final String city;
  final String postalCode;
  final bool isDefault;

  DeliveryAddressModel({
    required this.id,
    required this.address,
    required this.city,
    required this.postalCode,
    this.isDefault = false,
  });
}
