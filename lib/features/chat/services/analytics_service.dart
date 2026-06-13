class ChatAnalytics {
  int totalMessages = 0;
  int mediaSent = 0;
  int callsMade = 0;

  void logMessage() => totalMessages++;
  void logMedia() => mediaSent++;
  void logCall() => callsMade++;
}
