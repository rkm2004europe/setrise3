import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScheduleVoiceRoomScreen extends StatefulWidget {
  const ScheduleVoiceRoomScreen({super.key});

  @override
  State<ScheduleVoiceRoomScreen> createState() => _ScheduleVoiceRoomScreenState();
}

class _ScheduleVoiceRoomScreenState extends State<ScheduleVoiceRoomScreen> {
  final _titleCtrl = TextEditingController();
  DateTime? _date;
  TimeOfDay? _time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              _buildField('عنوان الغرفة الصوتية', _titleCtrl),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.calendar_today, color: LiveColors.text),
                title: Text(_date == null ? 'اختر التاريخ' : _date.toString().substring(0, 10), style: const TextStyle(color: LiveColors.text)),
                onTap: () async {
                  final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 30)));
                  if (d != null) setState(() => _date = d);
                },
              ),
              ListTile(
                leading: const Icon(Icons.access_time, color: LiveColors.text),
                title: Text(_time == null ? 'اختر الوقت' : _time!.format(context), style: const TextStyle(color: LiveColors.text)),
                onTap: () async {
                  final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (t != null) setState(() => _time = t);
                },
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (_date != null && _time != null && _titleCtrl.text.isNotEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تمت الجدولة!'), backgroundColor: LiveColors.accent));
                  }
                },
                child: Container(
                  width: double.infinity, height: 52,
                  decoration: BoxDecoration(color: LiveColors.accent, borderRadius: BorderRadius.circular(14)),
                  child: const Center(child: Text('جدولة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, TextEditingController ctrl) => TextField(
    controller: ctrl, style: const TextStyle(color: LiveColors.text),
    decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: LiveColors.text2.withOpacity(0.5)), filled: true, fillColor: LiveColors.surface, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)),
  );

  Widget _buildTopBar(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
    const SizedBox(width: 12),
    const Text('جدولة غرفة صوتية', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
