import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ScheduleMessageScreen extends StatefulWidget {
  final Function(DateTime, String) onScheduled;
  const ScheduleMessageScreen({super.key, required this.onScheduled});

  @override
  State<ScheduleMessageScreen> createState() => _ScheduleMessageScreenState();
}

class _ScheduleMessageScreenState extends State<ScheduleMessageScreen> {
  DateTime? _date;
  TimeOfDay? _time;
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _TopBar(context),
              const SizedBox(height: 20),
              TextField(controller: _ctrl, style: const TextStyle(color: ChatColors.text), decoration: InputDecoration(hintText: 'الرسالة...', hintStyle: TextStyle(color: ChatColors.text2.withOpacity(0.5)), border: InputBorder.none, filled: true, fillColor: ChatColors.surface)),
              const SizedBox(height: 16),
              ListTile(leading: const Icon(Icons.calendar_today, color: ChatColors.text), title: Text(_date == null ? 'اختر التاريخ' : _date.toString().substring(0, 10), style: const TextStyle(color: ChatColors.text)), onTap: () async { final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 30))); if (d != null) setState(() => _date = d); }),
              ListTile(leading: const Icon(Icons.access_time, color: ChatColors.text), title: Text(_time == null ? 'اختر الوقت' : _time!.format(context), style: const TextStyle(color: ChatColors.text)), onTap: () async { final t = await showTimePicker(context: context, initialTime: TimeOfDay.now()); if (t != null) setState(() => _time = t); }),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: ChatColors.accent, minimumSize: const Size(double.infinity, 52)),
                onPressed: () {
                  if (_date != null && _time != null && _ctrl.text.isNotEmpty) {
                    final dt = DateTime(_date!.year, _date!.month, _date!.day, _time!.hour, _time!.minute);
                    widget.onScheduled(dt, _ctrl.text);
                    Navigator.pop(context);
                  }
                },
                child: const Text('جدولة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final BuildContext context;
  const _TopBar(this.context);
  @override
  Widget build(BuildContext context) => Row(children: [
    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: ChatColors.text)),
    const SizedBox(width: 12),
    const Text('جدولة رسالة', style: TextStyle(color: ChatColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
  ]);
}
