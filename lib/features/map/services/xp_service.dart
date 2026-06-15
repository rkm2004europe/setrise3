import '../models/xp_model.dart';

class XpService {
  XpModel getXp() {
    return XpModel(currentXp: 1250, level: 5, xpToNextLevel: 2500, badges: ['🌟 مستكشف', '🔥 ناشط']);
  }
}
