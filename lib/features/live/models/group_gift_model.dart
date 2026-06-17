class GroupGiftModel {
  final String id;
  final String giftName;
  final int totalCost;
  final int currentContributors;
  final int requiredContributors;
  final List<String> contributors;
  bool isCompleted;
  GroupGiftModel({required this.id, required this.giftName, required this.totalCost, this.currentContributors = 0, this.requiredContributors = 10, this.contributors = const [], this.isCompleted = false});
}
