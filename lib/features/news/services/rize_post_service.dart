import '../models/rize_post_model.dart';

class RizeRepostService {
  Future<void> repost(RizePostModel originalPost, String comment) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Send to API
  }
}
