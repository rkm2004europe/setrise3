import '../models/review_model.dart';

final List<ReviewModel> mockReviews = [
  ReviewModel(id: 'r1', productId: 'p1', userId: 'u1', userName: 'Ahmed', rating: 4.5, comment: 'منتج رائع وسريع', createdAt: DateTime.now().subtract(const Duration(days: 1))),
  ReviewModel(id: 'r2', productId: 'p1', userId: 'u2', userName: 'Sara', rating: 5.0, comment: 'أفضل هاتف', createdAt: DateTime.now().subtract(const Duration(days: 3))),
];
