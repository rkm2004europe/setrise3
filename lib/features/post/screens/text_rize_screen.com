import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../widgets/hashtag_suggestion.dart';
import '../widgets/privacy_selector.dart';
import '../widgets/publish_button.dart';
import '../services/hashtag_service.dart';

class TextRizeScreen extends StatefulWidget {
  const TextRizeScreen({super.key});

  @override
  State<TextRizeScreen> createState() => _TextRizeScreenState();
}

class _TextRizeScreenState extends State<TextRizeScreen> {
  final _textCtrl = TextEditingController();
  String _hashtags = '';
  String _privacy = 'Public';
  bool _isPublishing = false;

  final _hashtagService = HashtagService();

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    if (_textCtrl.text.trim().isEmpty) return;
    setState(() => _isPublishing = true);
    HapticFeedback.heavyImpact();

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rize published!'),
        backgroundColor: PostColors.accent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PostColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: PostColors.textPrimary, size: 28),
                  ),
                  const Spacer(),
                  const Text(
                    'Text Rize',
                    style: TextStyle(
                      color: PostColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 28),
                ],
              ),
              const SizedBox(height: 20),

              // Text Field
              Expanded(
                child: TextField(
                  controller: _textCtrl,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(
                    color: PostColors.textPrimary,
                    fontSize: 16,
                    height: 1.6,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What\'s on your mind?',
                    hintStyle: TextStyle(
                      color: PostColors.textSecondary.withOpacity(0.5),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Hashtags
              HashtagSuggestion(
                suggestions: _hashtagService.getTrendingHashtags(),
                onHashtagSelected: (tag) {
                  setState(() {
                    _hashtags += ' $tag';
                  });
                },
              ),
              const SizedBox(height: 16),

              // Privacy
              Row(
                children: [
                  const Text('Privacy: ', style: TextStyle(color: PostColors.textPrimary)),
                  const SizedBox(width: 10),
                  PrivacySelector(
                    selectedPrivacy: _privacy,
                    onPrivacyChanged: (p) => setState(() => _privacy = p),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Publish Button
              PublishButton(
                onPressed: _publish,
                isLoading: _isPublishing,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
