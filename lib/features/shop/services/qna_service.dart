// lib/features/shop/services/qna_service.dart
//
// خدمة الأسئلة والأجوبة الشائعة
//
// الإصلاحات:
//   - فلترة الأسئلة بـ productId بدل إرجاع كل الأسئلة
//   - إرجاع الأسئلة العامة (productId = 'general') + الخاصة بالمنتج
//   - محاكاة زمن استجابة الشبكة

import '../models/qna_model.dart';
import '../data/mock_qna.dart';

class QnaService {
  /// يجلب الأسئلة الشائعة لمنتج معيّن (الخاصة + العامة)
  Future<List<QnaModel>> fetchQna(String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockQna
        .where((q) => q.productId == productId || q.productId == 'general')
        .toList();
  }

  /// يجلب الأسئلة العامة فقط (لصفحة المساعدة)
  Future<List<QnaModel>> fetchGeneralQna() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockQna.where((q) => q.productId == 'general').toList();
  }

  /// إضافة سؤال جديد (mock — لا يحفظ فعلياً)
  Future<void> submitQuestion({
    required String productId,
    required String question,
    String? askerName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    mockQna.add(QnaModel(
      productId: productId,
      question: question,
      answer: 'سيتم الرد قريباً.',
      askerName: askerName,
      createdAt: DateTime.now(),
    ));
  }
}
