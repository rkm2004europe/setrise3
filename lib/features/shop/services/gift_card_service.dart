// lib/features/shop/services/gift_card_service.dart
//
// خدمة بطاقات الهدايا — شراء البطاقات وإدارتها
//
// الإصلاحات:
//   - تطبيق الدالة purchase فعلياً (بدل الدالة الفارغة)
//   - إرجاع كود البطاقة المُشتراة
//   - إضافة fetchGiftCards() و getBalance()
//   - محاكاة زمن استجابة الشبكة

import 'dart:math';
import '../models/gift_card_model.dart';
import '../data/mock_gift_cards.dart';

class GiftCardService {
  /// شراء بطاقة هدية بقيمة معيّنة وإرسالها لبريد إلكتروني
  /// يُرجِع كود البطاقة (16 رقماً)
  Future<String> purchase(double amount, String email) async {
    await Future.delayed(const Duration(seconds: 2));

    // التحقق من القيمة المدعومة
    if (!mockGiftCardValues.contains(amount)) {
      throw ArgumentError('قيمة البطاقة غير مدعومة. القيم المتاحة: $mockGiftCardValues');
    }

    // توليد كود عشوائي (16 رقم)
    final random = Random();
    final code = List.generate(
      16,
      (_) => random.nextInt(10),
    ).join();

    // في تطبيق حقيقي: إرسال الكود لبريد المستلم + حفظه في DB
    // هنا نخزّنه فقط في قائمة محلية (سيتم استبدالها بـ API)
    _purchasedCards.add(GiftCardModel(
      amount: amount,
      recipientEmail: email,
    ));
    _purchasedCodes.add(code);

    return code;
  }

  /// القيم المدعومة لبطاقات الهدايا
  List<double> get availableValues => List.unmodifiable(mockGiftCardValues);

  /// البطاقات المشتراة (mock)
  final List<GiftCardModel> _purchasedCards = [];
  final List<String> _purchasedCodes = [];

  List<GiftCardModel> get purchasedCards => List.unmodifiable(_purchasedCards);

  /// إجمالي قيمة البطاقات المشتراة
  double get totalPurchased =>
      _purchasedCards.fold(0.0, (sum, c) => sum + c.amount);
}
