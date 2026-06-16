import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/live_room_model.dart';
import '../models/live_comment_model.dart';
import '../data/mock_gifts.dart';
import '../data/mock_live_comments.dart';
import '../widgets/gift_panel.dart';
import '../widgets/live_chat_bar.dart';
import '../widgets/host_info_bar.dart';
import '../widgets/live_reactions.dart';
import '../widgets/coin_balance_widget.dart';
import '../widgets/share_live_button.dart';
import '../widgets/viewer_list_sheet.dart';
import '../controllers/gift_controller.dart';
import '../controllers/chat_live_controller.dart';

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
  final List<LiveCommentModel> _comments = List.from(mockLiveComments);

  void _sendGift(GiftModel gift) {
    HapticFeedback.mediumImpact();
    setState(() {
      _giftCtrl.sendGift(gift);
      _comments.insert(0, LiveCommentModel(
        id: 'gc_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'me', userName: 'You', text: 'أرسل ${gift.name}',
        isGift: true, giftEmoji: gift.animationEmoji, sentAt: DateTime.now(),
      ));
    });
  }

  void _sendComment(String text) {
    setState(() {
      _comments.insert(0, LiveCommentModel(
        id: 'c_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'me', userName: 'You', text: text,
        isGift: false, sentAt: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // خلفية البث
          Container(color: LiveColors.surface, child: Center(child: Text(widget.room.thumbnailEmoji ?? '🔴', style: const TextStyle(fontSize: 120)))),

          // شريط المضيف
          SafeArea(child: HostInfoBar(room: widget.room)),

          // الدردشة
          Positioned(bottom: 80, left: 10, right: 80, height: 150, child: LiveChatBar(comments: _comments)),

          // رصيد العملات
          Positioned(top: 60, right: 10, child: CoinBalanceWidget()),

          // التفاعلات
          Positioned(bottom: 30, right: 10, child: LiveReactions(onLike: () {}, onComment: () => _sendComment('👍'))),

          // مشاركة
          Positioned(top: 60, left: 10, child: ShareLiveButton(room: widget.room)),

          // زر قائمة المشاهدين
          Positioned(top: 100, right: 10, child: GestureDetector(
            onTap: () => showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) => const ViewerListSheet()),
            child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: LiveColors.surface.withOpacity(0.8), shape: BoxShape.circle), child: const Icon(Icons.people, color: LiveColors.text)),
          )),

          // لوحة الهدايا
          if (_showGiftPanel)
            Positioned(bottom: 0, left: 0, right: 0, child: GiftPanel(gifts: mockGifts, onSend: (gift) { _sendGift(gift); setState(() => _showGiftPanel = false); }, onClose: () => setState(() => _showGiftPanel = false))),

          // زر فتح الهدايا
          if (!_showGiftPanel)
            Positioned(bottom: 20, left: 20, child: GestureDetector(
              onTap: () => setState(() => _showGiftPanel = true),
              child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: LiveColors.gold, shape: BoxShape.circle), child: const Icon(Icons.card_giftcard, color: Colors.white)),
            )),
        ],
      ),
    );
  }
}
