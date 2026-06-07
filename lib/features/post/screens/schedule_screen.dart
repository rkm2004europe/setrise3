import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ScheduleScreen extends StatefulWidget {
  final Function(DateTime) onScheduled;
  const ScheduleScreen({super.key, required this.onScheduled});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PostColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: PostColors.textPrimary),
                  ),
                  const Spacer(),
                  const Text('Schedule Post', style: TextStyle(color: PostColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w800)),
                  const Spacer(),
                  const SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.calendar_today, color: PostColors.textPrimary),
                title: Text(
                  _selectedDate == null ? 'Select Date' : _selectedDate.toString().substring(0, 10),
                  style: const TextStyle(color: PostColors.textPrimary),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (date != null) setState(() => _selectedDate = date);
                },
              ),
              ListTile(
                leading: const Icon(Icons.access_time, color: PostColors.textPrimary),
                title: Text(
                  _selectedTime == null ? 'Select Time' : _selectedTime!.format(context),
                  style: const TextStyle(color: PostColors.textPrimary),
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) setState(() => _selectedTime = time);
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: PostColors.accent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    if (_selectedDate != null && _selectedTime != null) {
                      final scheduledDateTime = DateTime(
                        _selectedDate!.year,
                        _selectedDate!.month,
                        _selectedDate!.day,
                        _selectedTime!.hour,
                        _selectedTime!.minute,
                      );
                      widget.onScheduled(scheduledDateTime);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
