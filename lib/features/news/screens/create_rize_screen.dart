import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../../post/screens/gallery_screen.dart';
import '../../post/screens/camera_screen.dart';

class CreateRizeScreen extends StatefulWidget {
  const CreateRizeScreen({super.key});

  @override
  State<CreateRizeScreen> createState() => _CreateRizeScreenState();
}

class _CreateRizeScreenState extends State<CreateRizeScreen> {
  final _textCtrl = TextEditingController();
  String? _mediaPath;
  bool _isVideo = false;
  bool _isPublishing = false;

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
        backgroundColor: NewsColors.accent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canPublish = _textCtrl.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: NewsColors.background,
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
                    child: const Icon(Icons.close,
                        color: NewsColors.textPrimary, size: 28),
                  ),
                  const Spacer(),
                  const Text(
                    'New Rize',
                    style: TextStyle(
                      color: NewsColors.textPrimary,
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
                  maxLength: 250,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(
                    color: NewsColors.textPrimary,
                    fontSize: 16,
                    height: 1.6,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What\'s happening?',
                    hintStyle: TextStyle(
                      color: NewsColors.textSecondary.withOpacity(0.5),
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    counterStyle:
                        const TextStyle(color: NewsColors.textSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Add media button
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Open gallery
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GalleryScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: NewsColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.image,
                          color: NewsColors.accent, size: 22),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // Open camera
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CameraScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: NewsColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: NewsColors.accent, size: 22),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Publish button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canPublish ? NewsColors.accent : NewsColors.surface,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: canPublish ? _publish : null,
                  child: _isPublishing
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text(
                          'Publish',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                canPublish ? Colors.white : NewsColors.textHint,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
