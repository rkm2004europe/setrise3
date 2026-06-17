class SubscriptionModel {
  final String id;
  final String hostId;
  final String subscriberId;
  final double monthlyPrice;
  final DateTime startDate;
  final bool isActive;
  SubscriptionModel({required this.id, required this.hostId, required this.subscriberId, this.monthlyPrice = 5.0, required this.startDate, this.isActive = true});
}
