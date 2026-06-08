class RizeBookmarkService {
  final List<String> _bookmarkedIds = [];

  Future<void> toggleBookmark(String postId) async {
    if (_bookmarkedIds.contains(postId)) {
      _bookmarkedIds.remove(postId);
    } else {
      _bookmarkedIds.add(postId);
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  bool isBookmarked(String postId) => _bookmarkedIds.contains(postId);
}
