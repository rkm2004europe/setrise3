import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/template_model.dart';
import '../data/templates_data.dart';

class TemplatePickerScreen extends StatelessWidget {
  final Function(TemplateModel) onTemplateSelected;
  const TemplatePickerScreen({super.key, required this.onTemplateSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PostColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: PostColors.textPrimary),
                  ),
                  const Spacer(),
                  const Text('Templates', style: TextStyle(color: PostColors.textPrimary, fontSize: 20, fontWeight: FontWeight.w800)),
                  const Spacer(),
                ],
              ),
            ),
            const Divider(color: PostColors.textSecondary),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: availableTemplates.length,
                itemBuilder: (context, index) {
                  final template = availableTemplates[index];
                  return GestureDetector(
                    onTap: () {
                      onTemplateSelected(template);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: template.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: template.color.withOpacity(0.3)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_awesome, color: template.color, size: 32),
                          const SizedBox(height: 10),
                          Text(template.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
