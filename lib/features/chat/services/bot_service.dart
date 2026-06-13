import '../models/bot_model.dart';
import '../data/mock_bots.dart';

class BotService {
  final Map<String, BotModel> _bots = { for (final b in mockBots) b.id: b };

  Future<String> getReply(String message) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (message.contains('/help')) return 'الأوامر المتاحة: /help, /info, /news';
    if (message.contains('/info')) return 'SetRise هو تطبيق اجتماعي متكامل.';
    if (message.contains('/news')) return 'آخر الأخبار: تم إطلاق التطبيق بنجاح!';
    return 'آسف، لم أفهم. جرب /help';
  }

  List<BotModel> getAvailableBots() => _bots.values.toList();
}
