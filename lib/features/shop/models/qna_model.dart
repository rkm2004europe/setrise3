// lib/features/shop/models/qna_model.dart
//
// نموذج سؤال وجواب (Q&A) لمنتج
//
// الإصلاح: إضافة حقل productId للسماح بفلترة الأسئلة حسب المنتج
// (النموذج القديم لم يكن يدعم الفلترة لأنه لم يربط السؤال بالمنتج)

class QnaModel {
  /// معرّف المنتج الذي يتعلق به السؤال (قد يكون 'general' للأسئلة العامة)
  final String productId;

  /// نص السؤال
  final String question;

  /// نص الإجابة
  final String answer;

  /// اسم المستخدم الذي طرح السؤال (اختياري)
  final String? askerName;

  /// تاريخ السؤال (اختياري)
  final DateTime? createdAt;

  QnaModel({
    required this.productId,
    required this.question,
    required this.answer,
    this.askerName,
    this.createdAt,
  });
}
