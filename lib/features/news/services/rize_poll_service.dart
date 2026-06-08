class RizePollService {
  Future<void> vote(String pollId, int optionIndex) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
