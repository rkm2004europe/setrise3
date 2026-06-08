import '../models/rize_quote_model.dart';

List<RizeQuoteModel> mockQuotes = [
  RizeQuoteModel(
    id: 'q1',
    originalPostId: '1',
    quoterUserId: 'u5',
    quoterUserName: 'Nora X.',
    quoterUsername: '@nora_x',
    comment: 'هذا مهم جداً للمبتدئين',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
];
