import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'camera_screen.dart';
// import 'gallery_screen.dart'; // لاحقًا
// import 'publish_screen.dart'; // عند اختيار منتج أو نص

class CreateHubScreen extends StatelessWidget {
  const CreateHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PostColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: PostColors.textPrimary, size: 28),
                  ),
                  const Spacer(),
                  const Text(
                    'New Post',
                    style: TextStyle(
                      color: PostColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 28), // balance
                ],
              ),
              const SizedBox(height: 32),
              // Grid of options
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    _OptionCard(
                      icon: Icons.camera_alt_rounded,
                      label: 'Camera',
                      color: Colors.redAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const CameraScreen()),
                        );
                      },
                    ),
                    _OptionCard(
                      icon: Icons.photo_library_rounded,
                      label: 'Gallery',
                      color: Colors.blueAccent,
                      onTap: () {
                        // TODO: open gallery
                      },
                    ),
                    _OptionCard(
                      icon: Icons.edit_rounded,
                      label: 'Text Rize',
                      color: Colors.greenAccent,
                      onTap: () {
                        // TODO: go to text editor
                      },
                    ),
                    _OptionCard(
                      icon: Icons.shopping_bag_rounded,
                      label: 'Product',
                      color: Colors.orangeAccent,
                      onTap: () {
                        // TODO: go to product post
                      },
                    ),
                    _OptionCard(
                      icon: Icons.live_tv_rounded,
                      label: 'Go Live',
                      color: Colors.red,
                      onTap: () {
                        // TODO: start live
                      },
                    ),
                    _OptionCard(
                      icon: Icons.music_note_rounded,
                      label: 'Sound',
                      color: Colors.purpleAccent,
                      onTap: () {
                        // TODO: open music picker to start with sound
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _OptionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
