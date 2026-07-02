// lib/features/shop/services/qna_service.dart

import '../models/qna_model.dart';
import '../data/mock_qna.dart';

class QnaService {
  Future<List<QnaModel>> fetchQna(String productId) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockQna.where((q) => q.productId == productId || q.productId == 'general').toList();
  }

  Future<List<QnaModel>> fetchGeneralQna() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockQna.where((q) => q.productId == 'general').toList();
  }

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
