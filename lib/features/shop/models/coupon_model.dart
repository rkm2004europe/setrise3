class CouponModel {
  final String code;
  final double discountPercent;
  final bool isActive;

  CouponModel({required this.code, required this.discountPercent, this.isActive = true});
}
