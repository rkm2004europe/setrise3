import '../models/models.dart';

class ChatService {
  Future<List<Conversation>> fetchInbox() async {
    await Future.delayed(const Duration(seconds: 1));
    return []; // TODO: API
  }

  Future<List<Message>> fetchMessages(String conversationId) async {
    await Future.delayed(const Duration(seconds: 1));
    return []; // TODO: API
  }

  Future<void> sendMessage(Message msg) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: API
  }
}
