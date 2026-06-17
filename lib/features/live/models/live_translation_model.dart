class LiveTranslationModel {
  final String messageId;
  final String originalText;
  final String translatedText;
  final String fromLang;
  final String toLang;
  LiveTranslationModel({required this.messageId, required this.originalText, required this.translatedText, this.fromLang = 'ar', this.toLang = 'en'});
}
