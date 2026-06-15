import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CreateEventScreen extends StatefulWidget {
  final double lat;
  final double lng;
  const CreateEventScreen({super.key, required this.lat, required this.lng});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;
  bool _isPublic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 20),
              _buildField('عنوان الحدث', _titleCtrl),
              _buildField('الوصف', _descCtrl, maxLines: 3),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.access_time, color: MapColors.text),
                title: Text(
                  _startTime == null ? 'اختر وقت البداية' : 'البداية: ${_startTime.toString().substring(0, 16)}',
                  style: const TextStyle(color: MapColors.text),
                ),
                onTap: () async {
                  final d = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)));
                  if (d != null) {
                    final t = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (t != null) {
                      setState(() => _startTime =
                          DateTime(d.year, d.month, d.day, t.hour, t.minute));
                    }
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.timer_off, color: MapColors.text),
                title: Text(
                  _endTime == null ? 'اختر وقت النهاية' : 'النهاية: ${_endTime.toString().substring(0, 16)}',
                  style: const TextStyle(color: MapColors.text),
                ),
                onTap: () async {
                  final d = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)));
                  if (d != null) {
                    final t = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (t != null) {
                      setState(() => _endTime =
                          DateTime(d.year, d.month, d.day, t.hour, t.minute));
                    }
                  }
                },
              ),
              SwitchListTile(
                title: const Text('حدث عام', style: TextStyle(color: MapColors.text)),
                value: _isPublic,
                onChanged: (v) => setState(() => _isPublic = v),
                activeColor: MapColors.accent,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'الموقع: ${widget.lat.toStringAsFixed(4)}, ${widget.lng.toStringAsFixed(4)}',
                  style: const TextStyle(color: MapColors.text2),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (_titleCtrl.text.isNotEmpty && _startTime != null && _endTime != null) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إنشاء الحدث!'), backgroundColor: MapColors.accent),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: MapColors.accent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text('إنشاء الحدث', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String hint, TextEditingController ctrl, {int maxLines = 1}) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextField(
          controller: ctrl,
          maxLines: maxLines,
          style: const TextStyle(color: MapColors.text),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: MapColors.text2.withOpacity(0.5)),
            filled: true,
            fillColor: MapColors.surface,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
          ),
        ),
      );

  Widget _buildTopBar(BuildContext context) => Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: MapColors.text),
          ),
          const SizedBox(width: 12),
          const Text('إنشاء حدث',
              style: TextStyle(
                  color: MapColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
        ],
      );
}
