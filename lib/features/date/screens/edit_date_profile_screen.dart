import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../data/date_interests.dart';
import '../models/date_user_model.dart';

class EditDateProfileScreen extends StatefulWidget {
  const EditDateProfileScreen({super.key});

  @override
  State<EditDateProfileScreen> createState() => _EditDateProfileScreenState();
}

class _EditDateProfileScreenState extends State<EditDateProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'أنت');
  final _bioCtrl = TextEditingController(text: 'أكتب نبذة عنك...');
  final _jobCtrl = TextEditingController(text: 'مطور');
  int _age = 25;
  List<String> _selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DateColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // شريط علوي
              Row(
                children: [
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: DateColors.text)),
                  const Spacer(),
                  const Text('تعديل البروفايل', style: TextStyle(color: DateColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              _Field(label: 'الاسم', ctrl: _nameCtrl),
              _Field(label: 'النبذة', ctrl: _bioCtrl, maxLines: 3),
              _Field(label: 'العمر', ctrl: TextEditingController(text: '$_age'), keyboardType: TextInputType.number),
              _Field(label: 'الوظيفة', ctrl: _jobCtrl),
              const SizedBox(height: 16),
              const Align(alignment: Alignment.centerRight, child: Text('الاهتمامات', style: TextStyle(color: DateColors.text2))),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: dateInterests.map((i) {
                  final sel = _selected.contains(i);
                  return GestureDetector(
                    onTap: () => setState(() { sel ? _selected.remove(i) : _selected.add(i); }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: sel ? DateColors.accent : DateColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sel ? DateColors.accent : DateColors.border),
                      ),
                      child: Text(i, style: TextStyle(color: sel ? Colors.white : DateColors.text, fontSize: 12)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final int maxLines;
  final TextInputType? keyboardType;
  const _Field({required this.label, required this.ctrl, this.maxLines = 1, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: DateColors.text2, fontSize: 12)),
          const SizedBox(height: 4),
          TextField(
            controller: ctrl,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: const TextStyle(color: DateColors.text),
            decoration: InputDecoration(
              filled: true,
              fillColor: DateColors.surface,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
