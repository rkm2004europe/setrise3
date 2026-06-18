import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MultiLanguageTranslationScreen extends StatefulWidget {
  const MultiLanguageTranslationScreen({super.key});

  @override
  State<MultiLanguageTranslationScreen> createState() => _MultiLanguageTranslationScreenState();
}

class _MultiLanguageTranslationScreenState extends State<MultiLanguageTranslationScreen> {
  String _selectedLang = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LiveColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _langOption('en', 'English'),
                  _langOption('fr', 'Français'),
                  _langOption('es', 'Español'),
                  _langOption('ar', 'العربية'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _langOption(String code, String name) => GestureDetector(
        onTap: () => setState(() => _selectedLang = code),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _selectedLang == code ? LiveColors.accent.withOpacity(0.1) : LiveColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _selectedLang == code ? LiveColors.accent : LiveColors.border),
          ),
          child: Text(name, style: TextStyle(color: _selectedLang == code ? LiveColors.accent : LiveColors.text)),
        ),
      );

  Widget _buildTopBar(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back, color: LiveColors.text)),
            const SizedBox(width: 12),
            const Text('الترجمة', style: TextStyle(color: LiveColors.text, fontSize: 20, fontWeight: FontWeight.w800)),
          ],
        ),
      );
}
