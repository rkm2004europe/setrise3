import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/date_user_model.dart';
import '../../chat/screens/chat.dart';
import '../../chat/models/models.dart';

class MatchScreen extends StatefulWidget {
  final DateUserModel matchedUser;

  const MatchScreen({super.key, required this.matchedUser});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _scale = CurvedAnimation(parent: _anim, curve: Curves.elasticOut);
    _anim.forward();
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _openChat() {
    final conv = Conversation(
      id: 'match_${widget.matchedUser.id}',
      user: User(
        id: widget.matchedUser.id,
        name: widget.matchedUser.name,
        username: '@${widget.matchedUser.name}',
        avatar: widget.matchedUser.photos[0],
        isOnline: widget.matchedUser.isOnline,
      ),
      type: ConvType.friend,
      lastMessage: null,
      unread: 0,
      isArchived: false,
      isMuted: false,
      updatedAt: DateTime.now(),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(conversation: conv)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: Center(
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('✨', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                const Text(
                  'إنه تطابق!',
                  style: TextStyle(
                    color: DateColors.accent,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'أنت و ${widget.matchedUser.name} أعجبتما ببعضكما',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: DateColors.text2, fontSize: 16),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: _openChat,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    decoration: BoxDecoration(
                      color: DateColors.accent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'أرسل رسالة الآن',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'متابعة التصفح',
                    style: TextStyle(color: DateColors.text2, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
