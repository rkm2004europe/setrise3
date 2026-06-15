import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MapFilterScreen extends StatefulWidget {
  final Map<String, bool> initialFilters;
  const MapFilterScreen({super.key, required this.initialFilters});

  @override
  State<MapFilterScreen> createState() => _MapFilterScreenState();
}

class _MapFilterScreenState extends State<MapFilterScreen> {
  late Map<String, bool> _filters;

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.initialFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildSection('المحتوى', [
                    _buildSwitch('الستوريز', _filters['stories'] ?? true, (v) => setState(() => _filters['stories'] = v)),
                    _buildSwitch('البث المباشر', _filters['live'] ?? true, (v) => setState(() => _filters['live'] = v)),
                    _buildSwitch('الفيديوهات', _filters['videos'] ?? true, (v) => setState(() => _filters['videos'] = v)),
                  ]),
                  const SizedBox(height: 16),
                  _buildSection('الأماكن', [
                    _buildSwitch('المطاعم', _filters['restaurants'] ?? true, (v) => setState(() => _filters['restaurants'] = v)),
                    _buildSwitch('المتاجر', _filters['shops'] ?? true, (v) => setState(() => _filters['shops'] = v)),
                  ]),
                  const SizedBox(height: 16),
                  _buildSection('النشاطات', [
                    _buildSwitch('التحديات', _filters['challenges'] ?? true, (v) => setState(() => _filters['challenges'] = v)),
                    _buildSwitch('الأحداث', _filters['events'] ?? true, (v) => setState(() => _filters['events'] = v)),
                    _buildSwitch('المناطق الساخنة', _filters['hotspots'] ?? true, (v) => setState(() => _filters['hotspots'] = v)),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context, _filters),
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: MapColors.accent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text('تطبيق', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: MapColors.text2, fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ...children,
        ],
      );

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) => SwitchListTile(
        title: Text(title, style: const TextStyle(color: MapColors.text)),
        value: value,
        onChanged: onChanged,
        activeColor: MapColors.accent,
      );

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: MapColors.text),
            ),
            const SizedBox(width: 12),
            const Text('فلترة الخريطة',
                style: TextStyle(
                    color: MapColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
