import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/gift_model.dart';

class EnhancedGiftPanel extends StatefulWidget {
  final List<GiftModel> gifts;
  final Function(GiftModel, String?) onSend; // gift + message
  final VoidCallback onClose;

  const EnhancedGiftPanel({
    super.key,
    required this.gifts,
    required this.onSend,
    required this.onClose,
  });

  @override
  State<EnhancedGiftPanel> createState() => _EnhancedGiftPanelState();
}

class _EnhancedGiftPanelState extends State<EnhancedGiftPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final _msgCtrl = TextEditingController();
  GiftModel? _selectedGift;

  final List<String> _categories = ['الكل', 'مجانية', 'مدفوعة', 'مميزة'];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  List<GiftModel> _filteredGifts(int tabIndex) {
    if (tabIndex == 0) return widget.gifts;
    final category = _categories[tabIndex];
    switch (category) {
      case 'مجانية':
        return widget.gifts.where((g) => g.category == 'free').toList();
      case 'مدفوعة':
        return widget.gifts.where((g) => g.category == 'paid').toList();
      case 'مميزة':
        return widget.gifts.where((g) => g.category == 'premium').toList();
      default:
        return widget.gifts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: LiveColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // شريط العنوان
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text('الهدايا', style: TextStyle(color: LiveColors.text, fontWeight: FontWeight.w800, fontSize: 18)),
                const Spacer(),
                GestureDetector(onTap: widget.onClose, child: const Icon(Icons.close, color: LiveColors.text2)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // التبويبات
          TabBar(
            controller: _tabCtrl,
            isScrollable: true,
            indicatorColor: LiveColors.accent,
            labelColor: LiveColors.accent,
            unselectedLabelColor: LiveColors.text2,
            tabs: _categories.map((c) => Tab(text: c)).toList(),
          ),
          const SizedBox(height: 10),
          // شبكة الهدايا
          Flexible(
            child: TabBarView(
              controller: _tabCtrl,
              children: List.generate(_categories.length, (index) {
                final filtered = _filteredGifts(index);
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final gift = filtered[i];
                    final isSelected = _selectedGift?.id == gift.id;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedGift = gift),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isSelected ? LiveColors.accent.withOpacity(0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: isSelected ? Border.all(color: LiveColors.accent) : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(gift.animationEmoji, style: const TextStyle(fontSize: 32)),
                            const SizedBox(height: 4),
                            Text(gift.name, style: const TextStyle(color: LiveColors.text, fontSize: 9), textAlign: TextAlign.center),
                            Text('${gift.coinValue} 🪙', style: const TextStyle(color: LiveColors.gold, fontSize: 9)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
          // حقل الرسالة وزر الإرسال
          if (_selectedGift != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgCtrl,
                      style: const TextStyle(color: LiveColors.text),
                      decoration: InputDecoration(
                        hintText: 'أضف رسالة...',
                        hintStyle: TextStyle(color: LiveColors.text2.withOpacity(0.5)),
                        filled: true,
                        fillColor: LiveColors.bg,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      widget.onSend(_selectedGift!, _msgCtrl.text.isNotEmpty ? _msgCtrl.text : null);
                      _msgCtrl.clear();
                      setState(() => _selectedGift = null);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: LiveColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
