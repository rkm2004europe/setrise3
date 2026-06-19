import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';
import '../models/live_comment_model.dart';
import '../models/gift_model.dart';
import '../data/mock_gifts.dart';
import '../data/mock_live_comments.dart';
import '../widgets/enhanced_gift_panel.dart';
import '../widgets/live_chat_bar.dart';
import '../widgets/host_info_bar.dart';
import '../widgets/live_reactions.dart';
import '../widgets/coin_balance_widget.dart';
import '../widgets/share_live_button.dart';
import '../widgets/viewer_list_sheet.dart';
import '../widgets/gift_animation.dart';
import '../widgets/flying_comments_layer.dart';
import '../widgets/floating_hearts.dart';
import '../controllers/gift_controller.dart';
import '../controllers/chat_live_controller.dart';
import '../../comment/screens/comments_screen.dart';
import '../../user/screens/user_preview_sheet.dart';

class LiveRoomScreen extends StatefulWidget {
  final LiveRoomModel room;
  const LiveRoomScreen({super.key, required this.room});

  @override
  State<LiveRoomScreen> createState() => _LiveRoomScreenState();
}

class _LiveRoomScreenState extends State<LiveRoomScreen> {
  final GiftController _giftCtrl = GiftController();
  final ChatLiveController _chatCtrl = ChatLiveController();
  bool _showGiftPanel = false;
  String? _currentGiftEmoji;
  bool _showHearts = false;
  final List<LiveCommentModel> _comments = List.from(mockLiveComments);

  void _sendGift(GiftModel gift) {
    HapticFeedback.mediumImpact();
    setState(() {
      _giftCtrl.sendGift(gift);
      _currentGiftEmoji = gift.animationEmoji;
      _comments.insert(
        0,
        LiveCommentModel(
          id: 'gc_${DateTime.now().millisecondsSinceEpoch}',
          userId: 'me',
          userName: 'You',
          text: 'أرسل ${gift.name}',
          isGift: true,
          giftEmoji: gift.animationEmoji,
          sentAt: DateTime.now(),
        ),
      );
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _currentGiftEmoji = null);
    });
  }

  void _sendComment(String text) {
    setState(() {
      _comments.insert(
        0,
        LiveCommentModel(
          id: 'c_${DateTime.now().millisecondsSinceEpoch}',
          userId: 'me',
          userName: 'You',
          text: text,
          isGift: false,
          sentAt: DateTime.now(),
        ),
      );
    });
  }

  void _triggerHearts() {
    setState(() => _showHearts = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _showHearts = false);
    });
  }

  void _openComments(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentsScreen(
          contextId: widget.room.id,
          contextName: widget.room.hostName,
          accent: LiveColors.accent,
          contextType: CommentContextType.live,
        ),
      ),
    );
  }

  void _openHostProfile(BuildContext context) {
    showUserPreviewSheet(
      context,
      userId: widget.room.hostId,
      userName: widget.room.hostName,
      username: '@${widget.room.hostName}',
      accent: LiveColors.accent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: GestureDetector(
        onDoubleTap: _triggerHearts,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // خلفية البث
            Container(
              color: LiveColors.surface,
              child: Center(
                child: Text(
                  widget.room.thumbnailEmoji ?? '🔴',
                  style: const TextStyle(fontSize: 120),
                ),
              ),
            ),

            // التعليقات الطائرة
            FlyingCommentsLayer(comments: _comments),

            // القلوب المتطايرة
            FloatingHearts(show: _showHearts),

            // أنيميشن الهدية
            if (_currentGiftEmoji != null)
              Positioned.fill(
                child: Center(
                  child: GiftAnimation(
                    emoji: _currentGiftEmoji!,
                    onComplete: () => setState(() => _currentGiftEmoji = null),
                  ),
                ),
              ),

            // شريط المضيف (قابل للنقر لفتح البروفايل)
            SafeArea(
              child: GestureDetector(
                onTap: () => _openHostProfile(context),
                child: HostInfoBar(room: widget.room),
              ),
            ),

            // الدردشة الجانبية (VIP)
            Positioned(
              bottom: 80,
              left: 10,
              right: 80,
              height: 150,
              child: LiveChatBar(comments: _comments),
            ),

            // رصيد العملات
            Positioned(
              top: 60,
              right: 10,
              child: CoinBalanceWidget(),
            ),

            // التفاعلات السريعة
            Positioned(
              bottom: 30,
              right: 10,
              child: LiveReactions(
                onLike: _triggerHearts,
                onComment: () => _sendComment('👍'),
              ),
            ),

            // زر المشاركة
            Positioned(
              top: 60,
              left: 10,
              child: ShareLiveButton(room: widget.room),
            ),

            // زر التعليقات الموحدة
            Positioned(
              top: 100,
              left: 10,
              child: GestureDetector(
                onTap: () => _openComments(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: LiveColors.surface.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chat_bubble, color: LiveColors.text, size: 20),
                ),
              ),
            ),

            // زر قائمة المشاهدين
            Positioned(
              top: 100,
              right: 10,
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const ViewerListSheet(),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: LiveColors.surface.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.people, color: LiveColors.text),
                ),
              ),
            ),

            // لوحة الهدايا المتقدمة
            if (_showGiftPanel)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: EnhancedGiftPanel(
                  gifts: mockGifts,
                  onSend: (gift, message) {
                    _sendGift(gift);
                    if (message != null && message.isNotEmpty) {
                      _sendComment(message);
                    }
                    setState(() => _showGiftPanel = false);
                  },
                  onClose: () => setState(() => _showGiftPanel = false),
                ),
              ),

            // زر فتح الهدايا
            if (!_showGiftPanel)
              Positioned(
                bottom: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () => setState(() => _showGiftPanel = true),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: LiveColors.gold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.card_giftcard, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
 FullHostControlPanel)
أضف هذا المتغير:

dart
bool _showFullControl = false;
واستبدل HostControlPanel بـ FullHostControlPanel

  // في build
if (_showFullControl)
  Positioned(
    bottom: 20, left: 20, right: 20,
    child: FullHostControlPanel(onEnd: () => Navigator.pop(context)),
  ),

// زر فتح اللوحة الكاملة (بجانب زر الهدايا)
Positioned(
  bottom: 80, right: 10,
  child: GestureDetector(
    onTap: () => setState(() => _showFullControl = !_showFullControl),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle),
      child: Icon(_showFullControl ? Icons.close : Icons.tune, color: LiveColors.text),
    ),
  ),
),



live/screens/live_room_screen.dart (دمج UnifiedHostDashboard)
أضف المتغير:

dart
bool _showUnifiedDashboard = false;
واستبدل منطقة التحكم
  // زر فتح اللوحة الموحدة
Positioned(
  bottom: 20, right: 20,
  child: GestureDetector(
    onTap: () => setState(() => _showUnifiedDashboard = !_showUnifiedDashboard),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle),
      child: Icon(_showUnifiedDashboard ? Icons.close : Icons.dashboard, color: LiveColors.text),
    ),
  ),
),

// لوحة التحكم الموحدة
if (_showUnifiedDashboard)
  Positioned(
    bottom: 0, left: 0, right: 0,
    child: UnifiedHostDashboard(onEndStream: () => Navigator.pop(context)),
  ),// زر فتح اللوحة الموحدة
Positioned(
  bottom: 20, right: 20,
  child: GestureDetector(
    onTap: () => setState(() => _showUnifiedDashboard = !_showUnifiedDashboard),
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle),
      child: Icon(_showUnifiedDashboard ? Icons.close : Icons.dashboard, color: LiveColors.text),
    ),
  ),
),

// لوحة التحكم الموحدة
if (_showUnifiedDashboard)
  Positioned(
    bottom: 0, left: 0, right: 0,
    child: UnifiedHostDashboard(onEndStream: () => Navigator.pop(context)),
  ),
// زر VIP Status
Positioned(
  top: 140, left: 10,
  child: GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VipUpgradeScreen())),
    child: VipStatusCard(
      currentLevel: 'VIP',
      currentCoins: 250,
      coinsToNextLevel: 250,
      onUpgrade: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VipUpgradeScreen())),
    ),
  ),
),
إضافة VIP Status وWallet)
أضف في Stack:

dart
  // في _LiveRoomScreenState، أضف:
final CoinController _coinCtrl = CoinController();
final VipController _vipCtrl = VipController();

// استبدل CoinBalanceWidget بـ:
CoinBalanceWidget(controller: _coinCtrl),

// أضف زر VIP Status:
Positioned(
  top: 140, left: 10,
  child: GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VipUpgradeScreen())),
    child: VipStatusCard(
      currentLevel: _vipCtrl.currentLevel.name,
      currentCoins: _coinCtrl.balance,
      coinsToNextLevel: (_vipCtrl.currentLevel.name == 'VIP') ? 150 : 0,
      onUpgrade: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VipUpgradeScreen())),
    ),
  ),
),

// أضف قائمة سريعة أسفل الشاشة:
Positioned(
  bottom: 80, left: 10,
  child: Column(
    children: [
      _quickBtn(Icons.shopping_bag, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveShopIntegrationScreen()))),
      const SizedBox(height: 10),
      _quickBtn(Icons.music_note, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveMusicIntegrationScreen()))),
      const SizedBox(height: 10),
      _quickBtn(Icons.map, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveMapIntegrationScreen()))),
    ],
  ),
),)
الآن سنقوم بتحديث live_room_screen.dart بشكل نهائي ليربط كل  

