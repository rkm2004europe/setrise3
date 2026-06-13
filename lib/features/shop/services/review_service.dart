import '../models/review_model.dart';
import '../data/mock_reviews.dart';

class ReviewService {
  Future<List<ReviewModel>> fetchReviews(String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockReviews.where((r) => r.productId == productId).toList();
  }
}
