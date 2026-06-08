import '../models/rize_quote_model.dart';
import '../data/mock_rize_quotes.dart';

class RizeQuoteService {
  Future<List<RizeQuoteModel>> fetchQuotes(String postId) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockQuotes.where((q) => q.originalPostId == postId).toList();
  }
}
