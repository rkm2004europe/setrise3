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
import '../widgets/live_room_header.dart';
import '../widgets/live_reactions.dart';
import '../widgets/coin_balance_widget.dart';
import '../widgets/share_live_button.dart';
import '../widgets/viewer_list_sheet.dart';
import '../widgets/gift_animation.dart';
import '../widgets/flying_comments_layer.dart';
import '../widgets/floating_hearts.dart';
import '../widgets/unified_host_dashboard.dart';
import '../widgets/guest_grid.dart';
import '../widgets/vip_status_card.dart';
import '../controllers/gift_controller.dart';
import '../controllers/chat_live_controller.dart';
import '../controllers/coin_controller.dart';
import '../controllers/vip_controller.dart';
import '../controllers/follow_controller.dart';
import '../models/speaker_model.dart';
import 'live_guest_invite_screen.dart';
import 'vip_upgrade_screen.dart';
import 'live_shop_integration_screen.dart';
import 'live_music_integration_screen.dart';
import 'live_map_integration_screen.dart';
import 'live_challenge_detail_screen.dart';
import 'group_gift_detail_screen.dart';
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
  final CoinController _coinCtrl = CoinController();
  final VipController _vipCtrl = VipController();
  final FollowController _followCtrl = FollowController();
  
  bool _showGiftPanel = false;
  String? _currentGiftEmoji;
  bool _showHearts = false;
  bool _showUnifiedDashboard = false;
  SpeakerModel? _selectedGuest;
  final List<SpeakerModel> _guests = [];
  final List<LiveCommentModel> _comments = List.from(mockLiveComments);

  void _sendGift(GiftModel gift) {
    HapticFeedback.mediumImpact();
    setState(() {
      _giftCtrl.sendGift(gift);
      _currentGiftEmoji = gift.animationEmoji;
      _coinCtrl.spendCoins(gift.coinValue);
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
  
  Widget _quickBtn(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle),
      child: Icon(icon, color: LiveColors.text, size: 22),
    ),
  );

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

            // شريط المضيف المحسن
            SafeArea(
              child: GestureDetector(
                onTap: () => _openHostProfile(context),
                child: LiveRoomHeader(room: widget.room),
              ),
            ),

            // شبكة الضيوف
            if (_guests.isNotEmpty)
              Positioned(
                top: 80, left: 10, right: 10,
                child: GuestGrid(guests: _guests, onGuestTap: (guest) => setState(() => _selectedGuest = guest)),
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
              child: CoinBalanceWidget(controller: _coinCtrl),
            ),

            // زر VIP Status
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

            // أزرار الوصول السريع
            Positioned(
              top: 180, left: 10,
              child: Column(children: [
                _quickBtn(Icons.emoji_events, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveChallengeDetailScreen()))),
                const SizedBox(height: 8),
                _quickBtn(Icons.card_giftcard, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GroupGiftDetailScreen()))),
                const SizedBox(height: 8),
                _quickBtn(Icons.shopping_bag, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveShopIntegrationScreen()))),
                const SizedBox(height: 8),
                _quickBtn(Icons.music_note, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveMusicIntegrationScreen()))),
                const SizedBox(height: 8),
                _quickBtn(Icons.map, () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LiveMapIntegrationScreen()))),
              ]),
            ),

            // زر دعوة ضيوف
            Positioned(
              top: 120, right: 10,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LiveGuestInviteScreen(followCtrl: _followCtrl))),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle),
                  child: const Icon(Icons.person_add, color: LiveColors.text),
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
              ),
          ],
        ),
      ),
    );
  }
}
