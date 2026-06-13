import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/chat_service.dart';

class ChatController extends ChangeNotifier {
  final ChatService _service = ChatService();
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  Future<void> fetchMessages(String convId) async {
    _messages = await _service.fetchMessages(convId);
    notifyListeners();
  }

  Future<void> send(Message msg) async {
    _messages.add(msg);
    notifyListeners();
    await _service.sendMessage(msg);
  }
}
