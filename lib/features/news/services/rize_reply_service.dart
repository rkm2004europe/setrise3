import '../models/rize_reply_model.dart';
import '../data/mock_rize_replies.dart';

class RizeReplyService {
  Future<List<RizeReplyModel>> fetchReplies(String postId) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockReplies;
  }
}
