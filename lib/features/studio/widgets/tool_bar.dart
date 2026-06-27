library;

import 'package:flutter/material.dart';

import '../theme/studio_colors.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    super.key,
    required this.selectedLayerId,
    required this.onAddText,
    required this.onAddSticker,
    required this.onSplit,
    required this.onDelete,
    required this.onUndo,
    required this.onRedo,
    required this.canUndo,
    required this.canRedo,
  });

  final String? selectedLayerId;
  final VoidCallback onAddText;
  final VoidCallback onAddSticker;
  final VoidCallback onSplit;
  final VoidCallback onDelete;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final bool canUndo;
  final bool canRedo;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedLayerId != null;
    return Container(
      height: 88,
      padding: const EdgeInsets.fromLTRB(StudioSpacing.lg, StudioSpacing.sm,
          StudioSpacing.lg, StudioSpacing.lg),
      decoration: const BoxDecoration(
        color: StudioColors.surface,
        border: Border(
            top: BorderSide(color: StudioColors.separator, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ToolButton(
              icon: Icons.undo,
              label: 'Undo',
              onPressed: canUndo ? onUndo : null),
          _ToolButton(
              icon: Icons.redo,
              label: 'Redo',
              onPressed: canRedo ? onRedo : null),
          _ToolButton(
              icon: Icons.text_fields,
              label: 'Text',
              onPressed: onAddText,
              accent: true),
          _ToolButton(
              icon: Icons.emoji_emotions_outlined,
              label: 'Sticker',
              onPressed: onAddSticker),
          _ToolButton(
              icon: Icons.content_cut,
              label: 'Split',
              onPressed: hasSelection ? onSplit : null),
          _ToolButton(
              icon: Icons.delete_outline,
              label: 'Delete',
              onPressed: hasSelection ? onDelete : null,
              destructive: true),
        ],
      ),
    );
  }
}

class _ToolButton extends StatelessWidget {
  const _ToolButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.accent = false,
    this.destructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool accent;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;
    final color = isDisabled
        ? StudioColors.textTertiary
        : destructive
            ? StudioColors.error
            : accent
                ? StudioColors.accent
                : StudioColors.textPrimary;

    return GestureDetector(
      onTap: onPressed,
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accent && !isDisabled
                    ? StudioColors.accent.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(StudioRadius.md),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
