import 'package:flutter/material.dart';

import 'app_theme.dart';

// ---------------------------------------------------------------------------
// Buttons
// ---------------------------------------------------------------------------

enum ArcoButtonVariant { primary, secondary, ghost, danger }

enum ArcoButtonSize { sm, md, lg }

class ArcoButton extends StatelessWidget {
  const ArcoButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ArcoButtonVariant.primary,
    this.size = ArcoButtonSize.md,
    this.icon,
    this.loading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final ArcoButtonVariant variant;
  final ArcoButtonSize size;
  final IconData? icon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final height = switch (size) {
      ArcoButtonSize.sm => 36.0,
      ArcoButtonSize.md => 44.0,
      ArcoButtonSize.lg => 48.0,
    };
    final textStyle = switch (size) {
      ArcoButtonSize.sm => AppText.smallFor(
        context,
      ).copyWith(fontWeight: FontWeight.w600),
      ArcoButtonSize.md => AppText.button,
      ArcoButtonSize.lg => AppText.bodyFor(
        context,
      ).copyWith(fontWeight: FontWeight.w600),
    };
    final hPad = switch (size) {
      ArcoButtonSize.sm => AppSpacing.s3,
      ArcoButtonSize.md => AppSpacing.s5,
      ArcoButtonSize.lg => AppSpacing.s6,
    };

    final fg = _foregroundColor(context, variant);
    final labelStyle = textStyle.copyWith(color: fg);

    final content = loading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _spinnerColor(context, variant),
            ),
          )
        : (icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16, color: fg),
                    const SizedBox(width: AppSpacing.s2),
                    Text(label, style: labelStyle),
                  ],
                )
              : Text(label, style: labelStyle));

    final Widget button;
    switch (variant) {
      case ArcoButtonVariant.primary:
        button = ElevatedButton(
          onPressed: loading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorsResolver.accent(context),
            foregroundColor: AppColorsResolver.accentContrast(context),
            minimumSize: Size(expand ? double.infinity : 0, height),
            padding: EdgeInsets.symmetric(horizontal: hPad),
            textStyle: textStyle,
            shape: const RoundedRectangleBorder(borderRadius: AppRadius.rLg),
          ),
          child: content,
        );
      case ArcoButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: loading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColorsResolver.surface2(context),
            foregroundColor: AppColorsResolver.text1(context),
            minimumSize: Size(expand ? double.infinity : 0, height),
            padding: EdgeInsets.symmetric(horizontal: hPad),
            side: BorderSide(color: AppColorsResolver.border(context)),
            textStyle: textStyle,
            shape: const RoundedRectangleBorder(borderRadius: AppRadius.rLg),
          ),
          child: content,
        );
      case ArcoButtonVariant.ghost:
        button = TextButton(
          onPressed: loading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColorsResolver.text2(context),
            minimumSize: Size(expand ? double.infinity : 0, height),
            padding: EdgeInsets.symmetric(horizontal: hPad),
            textStyle: textStyle,
          ),
          child: content,
        );
      case ArcoButtonVariant.danger:
        button = OutlinedButton(
          onPressed: loading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColorsResolver.dangerSoft(context),
            foregroundColor: AppColorsResolver.danger(context),
            minimumSize: Size(expand ? double.infinity : 0, height),
            padding: EdgeInsets.symmetric(horizontal: hPad),
            side: BorderSide(
              color: AppColorsResolver.danger(context).withOpacity(0.35),
            ),
            textStyle: textStyle,
            shape: const RoundedRectangleBorder(borderRadius: AppRadius.rLg),
          ),
          child: content,
        );
    }

    return button;
  }

  Color _foregroundColor(BuildContext context, ArcoButtonVariant v) =>
      switch (v) {
        ArcoButtonVariant.primary => AppColorsResolver.accentContrast(context),
        ArcoButtonVariant.secondary => AppColorsResolver.text1(context),
        ArcoButtonVariant.ghost => AppColorsResolver.text2(context),
        ArcoButtonVariant.danger => AppColorsResolver.danger(context),
      };

  Color _spinnerColor(BuildContext context, ArcoButtonVariant v) => switch (v) {
    ArcoButtonVariant.primary => AppColorsResolver.accentContrast(context),
    _ => AppColorsResolver.link(context),
  };
}

class ArcoIconButton extends StatelessWidget {
  const ArcoIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final btn = Material(
      color: AppColorsResolver.accent(context),
      borderRadius: AppRadius.rMd,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadius.rMd,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            size: 18,
            color: AppColorsResolver.accentContrast(context),
          ),
        ),
      ),
    );
    if (tooltip == null) return btn;
    return Tooltip(message: tooltip!, child: btn);
  }
}

// ---------------------------------------------------------------------------
// Chips & badges
// ---------------------------------------------------------------------------

class ArcoChip extends StatelessWidget {
  const ArcoChip({
    super.key,
    required this.label,
    this.onTap,
    this.selected = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? AppColorsResolver.accent(context)
        : AppColorsResolver.surface2(context);
    final border = selected
        ? AppColorsResolver.accent(context)
        : AppColorsResolver.border(context);
    final color = selected
        ? AppColorsResolver.accentContrast(context)
        : AppColorsResolver.text1(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.rPill,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: AppSpacing.s2,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: AppRadius.rPill,
            border: Border.all(color: border),
          ),
          child: Text(
            label,
            style: AppText.smallFor(context).copyWith(
              color: color,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

enum ArcoBadgeVariant { neutral, accent, success, warning, danger }

class ArcoBadge extends StatelessWidget {
  const ArcoBadge({
    super.key,
    required this.label,
    this.variant = ArcoBadgeVariant.neutral,
    this.showDot = false,
  });

  final String label;
  final ArcoBadgeVariant variant;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, dot) = switch (variant) {
      ArcoBadgeVariant.neutral => (
        AppColorsResolver.surface2(context),
        AppColorsResolver.text2(context),
        AppColorsResolver.text3(context),
      ),
      ArcoBadgeVariant.accent => (
        AppColorsResolver.accentSoft(context),
        AppColorsResolver.link(context),
        AppColorsResolver.link(context),
      ),
      ArcoBadgeVariant.success => (
        AppColorsResolver.successSoft(context),
        AppColorsResolver.success(context),
        AppColorsResolver.success(context),
      ),
      ArcoBadgeVariant.warning => (
        AppColorsResolver.warningSoft(context),
        AppColorsResolver.warning(context),
        AppColorsResolver.warning(context),
      ),
      ArcoBadgeVariant.danger => (
        AppColorsResolver.dangerSoft(context),
        AppColorsResolver.danger(context),
        AppColorsResolver.danger(context),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.rPill,
        border: Border.all(color: fg.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Text(label, style: AppText.chip.copyWith(color: fg)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Alerts
// ---------------------------------------------------------------------------

enum ArcoAlertVariant { info, success, warning, danger }

class ArcoAlert extends StatelessWidget {
  const ArcoAlert({
    super.key,
    required this.message,
    this.variant = ArcoAlertVariant.info,
    this.icon,
  });

  final String message;
  final ArcoAlertVariant variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border, defaultIcon) = switch (variant) {
      ArcoAlertVariant.info => (
        AppColorsResolver.accentSoft(context),
        AppColorsResolver.text1(context),
        AppColorsResolver.accentBorder(context),
        Icons.info_outline,
      ),
      ArcoAlertVariant.success => (
        AppColorsResolver.successSoft(context),
        AppColorsResolver.success(context),
        AppColorsResolver.success(context).withOpacity(0.3),
        Icons.check_circle_outline,
      ),
      ArcoAlertVariant.warning => (
        AppColorsResolver.warningSoft(context),
        AppColorsResolver.warning(context),
        AppColorsResolver.warning(context).withOpacity(0.3),
        Icons.warning_amber_rounded,
      ),
      ArcoAlertVariant.danger => (
        AppColorsResolver.dangerSoft(context),
        AppColorsResolver.danger(context),
        AppColorsResolver.danger(context).withOpacity(0.3),
        Icons.error_outline,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s3,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.rMd,
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? defaultIcon, size: 18, color: fg),
          const SizedBox(width: AppSpacing.s3),
          Expanded(
            child: Text(
              message,
              style: AppText.smallFor(context).copyWith(color: fg),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cards & layout chrome
// ---------------------------------------------------------------------------

class ArcoCard extends StatelessWidget {
  const ArcoCard({super.key, required this.child, this.padding, this.onTap});

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: AppDecorations.card(context),
      padding: padding ?? const EdgeInsets.all(AppSpacing.s4),
      child: child,
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, borderRadius: AppRadius.rLg, child: card),
    );
  }
}

class ArcoPanel extends StatelessWidget {
  const ArcoPanel({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.panel(context),
      padding: padding ?? const EdgeInsets.all(AppSpacing.s6),
      child: child,
    );
  }
}

class ArcoDivider extends StatelessWidget {
  const ArcoDivider({super.key, this.indent, this.endIndent});

  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColorsResolver.borderSubtle(context),
      indent: indent,
      endIndent: endIndent,
    );
  }
}

class ArcoSectionHead extends StatelessWidget {
  const ArcoSectionHead({
    super.key,
    this.eyebrow,
    required this.title,
    this.subtitle,
  });

  final String? eyebrow;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (eyebrow != null) ...[
          Text(eyebrow!, style: AppText.eyebrowFor(context)),
          const SizedBox(height: AppSpacing.s2),
        ],
        Text(title, style: AppText.h1For(context)),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.s2),
          Text(
            subtitle!,
            style: AppText.bodyFor(
              context,
            ).copyWith(color: AppColorsResolver.text2(context)),
          ),
        ],
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Top bar & segmented navigation
// ---------------------------------------------------------------------------

class ArcoBrandMark extends StatelessWidget {
  const ArcoBrandMark({super.key, this.size = 30});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColorsResolver.accent(context),
        borderRadius: AppRadius.rMd,
      ),
      alignment: Alignment.center,
      child: Text(
        'i',
        style: AppText.body.copyWith(
          fontWeight: FontWeight.w800,
          color: AppColorsResolver.accentContrast(context),
          fontSize: size * 0.5,
        ),
      ),
    );
  }
}

class ArcoTopBar extends StatelessWidget implements PreferredSizeWidget {
  const ArcoTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.showBrand = true,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final bool showBrand;

  @override
  Size get preferredSize => Size.fromHeight(subtitle != null ? 72 : 60);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColorsResolver.canvas(context).withOpacity(0.92),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColorsResolver.borderSubtle(context)),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s4,
              vertical: AppSpacing.s3,
            ),
            child: Row(
              children: [
                if (showBrand) ...[
                  const ArcoBrandMark(),
                  const SizedBox(width: AppSpacing.s3),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title, style: AppText.navTitleFor(context)),
                      if (subtitle != null)
                        Text(subtitle!, style: AppText.navSubtitleFor(context)),
                    ],
                  ),
                ),
                ...actions,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArcoSegTabs extends StatelessWidget {
  const ArcoSegTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.s4,
        AppSpacing.s2,
        AppSpacing.s4,
        AppSpacing.s3,
      ),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColorsResolver.surface2(context),
        borderRadius: AppRadius.rMd,
        border: Border.all(color: AppColorsResolver.borderSubtle(context)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(labels.length, (i) {
            final active = i == selectedIndex;
            return Padding(
              padding: EdgeInsets.only(right: i < labels.length - 1 ? 2 : 0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onSelected(i),
                  borderRadius: AppRadius.rSm,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s3,
                      vertical: AppSpacing.s2,
                    ),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColorsResolver.surface1(context)
                          : Colors.transparent,
                      borderRadius: AppRadius.rSm,
                      boxShadow: active && !AppColorsResolver.isLight(context)
                          ? AppShadows.level1
                          : null,
                    ),
                    child: Text(
                      labels[i],
                      style: AppText.smallFor(context).copyWith(
                        fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                        color: active
                            ? AppColorsResolver.link(context)
                            : AppColorsResolver.text3(context),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class ArcoFieldLabel extends StatelessWidget {
  const ArcoFieldLabel({super.key, required this.label, this.hint});

  final String label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.labelFor(context)),
        if (hint != null) ...[
          const SizedBox(height: AppSpacing.s1),
          Text(hint!, style: AppText.captionFor(context)),
        ],
      ],
    );
  }
}
