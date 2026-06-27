library;

import 'package:flutter/material.dart';

import '../theme/studio_colors.dart';

enum StudioButtonSize { small, medium, large }
enum StudioButtonVariant { primary, secondary, ghost }

class StudioButton extends StatefulWidget {
  const StudioButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.size = StudioButtonSize.medium,
    this.variant = StudioButtonVariant.primary,
    this.gradient,
    this.isLoading = false,
    this.fullWidth = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final StudioButtonSize size;
  final StudioButtonVariant variant;
  final Gradient? gradient;
  final bool isLoading;
  final bool fullWidth;

  @override
  State<StudioButton> createState() => _StudioButtonState();
}

class _StudioButtonState extends State<StudioButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Size get _dimensions => switch (widget.size) {
        StudioButtonSize.small => const Size(36, 32),
        StudioButtonSize.medium => const Size(48, 44),
        StudioButtonSize.large => const Size(double.infinity, 56),
      };

  double get _fontSize => switch (widget.size) {
        StudioButtonSize.small => 13,
        StudioButtonSize.medium => 15,
        StudioButtonSize.large => 17,
      };

  double get _iconSize => switch (widget.size) {
        StudioButtonSize.small => 16,
        StudioButtonSize.medium => 20,
        StudioButtonSize.large => 22,
      };

  double get _radius => switch (widget.size) {
        StudioButtonSize.small => StudioRadius.sm,
        StudioButtonSize.medium => StudioRadius.md,
        StudioButtonSize.large => StudioRadius.lg,
      };

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null || widget.isLoading;
    final size = _dimensions;

    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) =>
          Transform.scale(scale: _scale.value, child: child),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          if (!isDisabled) widget.onPressed?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: widget.fullWidth ? double.infinity : size.width,
          height: size.height,
          decoration: _buildDecoration(isDisabled),
          child: _buildContent(isDisabled),
        ),
      ),
    );
  }

  Decoration _buildDecoration(bool disabled) {
    final base = BoxDecoration(
      borderRadius: BorderRadius.circular(_radius),
      border: widget.variant == StudioButtonVariant.secondary
          ? Border.all(color: StudioColors.separator, width: 0.5)
          : null,
    );

    if (disabled) {
      return base.copyWith(
        color: StudioColors.surfaceRaised.withOpacity(0.4),
      );
    }

    switch (widget.variant) {
      case StudioButtonVariant.primary:
        if (widget.gradient != null) {
          return base.copyWith(gradient: widget.gradient);
        }
        return base.copyWith(color: StudioColors.accent);
      case StudioButtonVariant.secondary:
        return base.copyWith(color: StudioColors.surfaceRaised);
      case StudioButtonVariant.ghost:
        return base.copyWith(color: Colors.transparent);
    }
  }

  Widget _buildContent(bool disabled) {
    final color = disabled
        ? StudioColors.textTertiary
        : widget.variant == StudioButtonVariant.primary
            ? Colors.white
            : StudioColors.textPrimary;

    if (widget.isLoading) {
      return SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      );
    }

    final children = <Widget>[];
    if (widget.icon != null) {
      children.add(Icon(widget.icon, color: color, size: _iconSize));
      if (widget.label.isNotEmpty) {
        children.add(const SizedBox(width: StudioSpacing.sm));
      }
    }
    if (widget.label.isNotEmpty) {
      children.add(
        Text(
          widget.label,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: FontWeight.w700,
            color: color,
            letterSpacing: -0.2,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
