import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CreatePlaylistScreen extends StatelessWidget {
  const CreatePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _nameCtrl = TextEditingController();

    return Scaffold(
      backgroundColor: MusicColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(children: [
                GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: MusicColors.text)),
                const SizedBox(width: 12),
                const Text('قائمة تشغيل جديدة', style: TextStyle(color: MusicColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
              const SizedBox(height: 20),
              TextField(controller: _nameCtrl, style: const TextStyle(color: MusicColors.text), decoration: InputDecoration(hintText: 'اسم القائمة', hintStyle: TextStyle(color: MusicColors.text2.withOpacity(0.5)), filled: true, fillColor: MusicColors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: double.infinity, height: 52, decoration: BoxDecoration(color: MusicColors.accent, borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('إنشاء', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
