// lib/features/shop/data/mock_qna.dart
//
// بيانات وهمية للأسئلة والأجوبة — مع ربط كل سؤال بمعرّف المنتج
//
// الإصلاح: إضافة productId لكل سؤال للسماح بفلترته في QnaService

import '../models/qna_model.dart';

final List<QnaModel> mockQna = [
  // أسئلة عامة (تظهر لأي منتج)
  QnaModel(
    productId: 'general',
    question: 'هل يدعم الشحن الدولي؟',
    answer: 'نعم، الشحن متاح لكل الدول.',
  ),
  QnaModel(
    productId: 'general',
    question: 'ما هي مدة الضمان؟',
    answer: 'سنة كاملة ضد عيوب التصنيع.',
  ),

  // أسئلة خاصة بالهاتف الذكي p1
  QnaModel(
    productId: 'p1',
    question: 'هل البطارية تتحمّل يوماً كاملاً؟',
    answer: 'نعم، البطارية 5000mAh تكفي ليوم كامل من الاستخدام المعتاد.',
  ),
  QnaModel(
    productId: 'p1',
    question: 'هل يدعم 5G؟',
    answer: 'نعم، يدعم شبكات 5G في النطاقات المدعومة عالمياً.',
  ),

  // أسئلة خاصة بالحذاء الرياضي p2
  QnaModel(
    productId: 'p2',
    question: 'ما هي المقاسات المتوفرة؟',
    answer: 'متوفرة من 39 إلى 45.',
  ),
];
