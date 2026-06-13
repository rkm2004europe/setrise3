import '../models/bot_model.dart';

final List<BotModel> mockBots = [
  BotModel(id: 'bot1', name: 'SetRise Assistant', avatar: '🤖', description: 'مساعد SetRise الذكي', commands: ['/help', '/info', '/news']),
  BotModel(id: 'bot2', name: 'Weather Bot', avatar: '🌤️', description: 'معرفة حالة الطقس', commands: ['/weather']),
  BotModel(id: 'bot3', name: 'Translate Bot', avatar: '🌐', description: 'ترجمة فورية', commands: ['/translate']),
];
