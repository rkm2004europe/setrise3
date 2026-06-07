import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../models/draft_model.dart';
import '../data/filters_data.dart';

class PublishScreen extends StatefulWidget {
  final String mediaPath;
  final bool isVideo;
  final PostFilter filter;
  final double filterIntensity;
  final String? musicTrack;
  final String? product;
  final String? location;
  final String? mentionedUser;

  const PublishScreen({
    super.key,
    required this.mediaPath,
    required this.isVideo,
    required this.filter,
    required this.filterIntensity,
    this.musicTrack,
    this.product,
    this.location,
    this.mentionedUser,
  });

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  final _captionCtrl = TextEditingController();
  String _hashtags = '';
  String _privacy = 'Public'; // Public, Friends, Private
  bool _shareToRize = false;
  DateTime? _scheduledTime;

  @override
  void dispose() {
    _captionCtrl.dispose();
    super.dispose();
  }

  void _publish() async {
    // Simulate publishing
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: PostColors.accent)),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pop(context); // close progress
    Navigator.popUntil(context, (route) => route.isFirst); // go back to feed
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post published!'), backgroundColor: PostColors.accent),
    );
  }

  void _schedulePost() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    ).then((date) {
      if (date != null) {
        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
          if (time != null) {
            setState(() {
              _scheduledTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
            });
          }
        });
      }
    });
  }

  void _saveDraft() {
    final draft = DraftModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      mediaPath: widget.mediaPath,
      caption: _captionCtrl.text,
      hashtags: _hashtags,
      savedAt: DateTime.now(),
    );
    // TODO: store in local DB via draft_service
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PostColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios, color: PostColors.textPrimary, size: 22),
                  ),
                  const Spacer(),
                  const Text('New Post', style: TextStyle(color: PostColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _saveDraft,
                    child: const Text('Draft', style: TextStyle(color: PostColors.textSecondary, fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Caption
              TextField(
                controller: _captionCtrl,
                maxLines: 4,
                style: const TextStyle(color: PostColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  hintStyle: TextStyle(color: PostColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: PostColors.surface,
                ),
              ),
              const SizedBox(height: 12),

              // Hashtags
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: PostColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _hashtags.isEmpty ? '#trending #setrise' : _hashtags,
                        style: TextStyle(color: _hashtags.isEmpty ? PostColors.textSecondary : PostColors.textPrimary),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() => _hashtags = '#trending #explore #setrise');
                    },
                    child: const Text('Suggest', style: TextStyle(color: PostColors.accent)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Privacy
              Row(
                children: [
                  const Text('Privacy: ', style: TextStyle(color: PostColors.textPrimary)),
                  DropdownButton<String>(
                    value: _privacy,
                    dropdownColor: PostColors.surface,
                    style: const TextStyle(color: PostColors.textPrimary),
                    onChanged: (v) => setState(() => _privacy = v!),
                    items: const [
                      DropdownMenuItem(value: 'Public', child: Text('Public')),
                      DropdownMenuItem(value: 'Friends', child: Text('Friends')),
                      DropdownMenuItem(value: 'Private', child: Text('Private')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Share to Rize toggle
              Row(
                children: [
                  const Text('Also post to Rize', style: TextStyle(color: PostColors.textPrimary)),
                  const Spacer(),
                  Switch(
                    value: _shareToRize,
                    onChanged: (v) => setState(() => _shareToRize = v),
                    activeColor: PostColors.accent,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Schedule
              GestureDetector(
                onTap: _schedulePost,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: PostColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.schedule, color: PostColors.textPrimary),
                      const SizedBox(width: 10),
                      Text(
                        _scheduledTime == null
                            ? 'Schedule for later'
                            : 'Scheduled: ${_scheduledTime!.toLocal().toString().substring(0, 16)}',
                        style: TextStyle(color: _scheduledTime == null ? PostColors.textSecondary : PostColors.accent),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),

              // Publish button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PostColors.accent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _publish,
                  child: const Text('Publish Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
