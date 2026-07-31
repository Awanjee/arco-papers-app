// =================================================================
// iStatis Flutter theme — Paper light + Arco dark
// Fonts: Plus Jakarta Sans (UI) + JetBrains Mono (data) + Noto Nastaliq Urdu
// =================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ----------------------------- COLORS -----------------------------
class AppColors {
  AppColors._();

  // neutrals (cool carbon)
  static const canvas = Color(0xFF0D0F12);
  static const surface1 = Color(0xFF14171B);
  static const surface2 = Color(0xFF1A1E23);
  static const surface3 = Color(0xFF20252B);
  static const borderSubtle = Color(0xFF23282F);
  static const border = Color(0xFF2C323A);
  static const borderStrong = Color(0xFF3A424C);

  // text
  static const text1 = Color(0xFFEEF1F4);
  static const text2 = Color(0xFFA8B0B9);
  static const text3 = Color(0xFF717982);

  // accent · Sky
  static const accent = Color(0xFF7DD3FC);
  static const accentHover = Color(0xFFA5E0FD);
  static const accentPress = Color(0xFF5CC2F5);
  static const accentContrast = Color(0xFF0A0F12);

  // semantic
  static const success = Color(0xFF34D399);
  static const warning = Color(0xFFFBBF24);
  static const danger = Color(0xFFF87171);

  // soft tints (computed)
  static final accentSoft = accent.withOpacity(0.10);
  static final accentSoft2 = accent.withOpacity(0.16);
  static final accentBorder = accent.withOpacity(0.30);
  static final successSoft = success.withOpacity(0.12);
  static final warningSoft = warning.withOpacity(0.12);
  static final dangerSoft = danger.withOpacity(0.12);
}

/// Paper light theme tokens (variant B: Butter + cyan). Do not modify [AppColors].
class AppColorsLight {
  AppColorsLight._();

  static const canvas = Color(0xFFFFFFEB);
  static const surface1 = Color(0xFFFFFDF9);
  static const surface2 = Color(0xFFEDEDDC);
  static const borderSubtle = Color(0xFFEDEDDC);
  static const border = Color(0xFFE4E4D0);
  static const borderStrong = Color(0xFFCFCFB8);

  static const text1 = Color(0xFF1A1A1A);
  static const text2 = Color(0xA81A1A1A);
  static const text3 = Color(0x701A1A1A);

  static const feature = Color(0xFF034F46);
  static const featureInk = Color(0xFFFFFFEB);
  static const featureSub = Color(0xB8FFFFEB);

  static const accent = Color(0xFF07CEED);
  static const accentInk = Color(0xFF063A44);
  static const accentPress = Color(0xFF05B8D4);

  static const highlight = Color(0xFFFFA946);
  static const link = Color(0xFF0B5E72);

  static const success = Color(0xFF0F7A52);
  static const successSoft = Color(0xFFE2F2E9);
  static const warning = Color(0xFFA15C07);
  static const warningSoft = Color(0xFFFBF0DB);
  static const danger = Color(0xFFB3362B);
  static const dangerSoft = Color(0xFFFAE6E3);

  static final accentSoft = accent.withOpacity(0.10);
  static final accentSoft2 = accent.withOpacity(0.16);
  static final accentBorder = accent.withOpacity(0.30);
}

/// Resolves semantic colours by current theme brightness.
class AppColorsResolver {
  AppColorsResolver._();

  static bool isLight(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;

  static Color canvas(BuildContext c) =>
      isLight(c) ? AppColorsLight.canvas : AppColors.canvas;
  static Color surface1(BuildContext c) =>
      isLight(c) ? AppColorsLight.surface1 : AppColors.surface1;
  static Color surface2(BuildContext c) =>
      isLight(c) ? AppColorsLight.surface2 : AppColors.surface2;
  static Color surface3(BuildContext c) =>
      isLight(c) ? AppColorsLight.surface2 : AppColors.surface3;
  static Color borderSubtle(BuildContext c) =>
      isLight(c) ? AppColorsLight.borderSubtle : AppColors.borderSubtle;
  static Color border(BuildContext c) =>
      isLight(c) ? AppColorsLight.border : AppColors.border;
  static Color borderStrong(BuildContext c) =>
      isLight(c) ? AppColorsLight.borderStrong : AppColors.borderStrong;
  static Color text1(BuildContext c) =>
      isLight(c) ? AppColorsLight.text1 : AppColors.text1;
  static Color text2(BuildContext c) =>
      isLight(c) ? AppColorsLight.text2 : AppColors.text2;
  static Color text3(BuildContext c) =>
      isLight(c) ? AppColorsLight.text3 : AppColors.text3;
  static Color accent(BuildContext c) =>
      isLight(c) ? AppColorsLight.accent : AppColors.accent;
  static Color accentContrast(BuildContext c) =>
      isLight(c) ? AppColorsLight.accentInk : AppColors.accentContrast;
  static Color accentPress(BuildContext c) =>
      isLight(c) ? AppColorsLight.accentPress : AppColors.accentPress;
  static Color accentSoft(BuildContext c) =>
      isLight(c) ? AppColorsLight.accentSoft : AppColors.accentSoft;
  static Color accentSoft2(BuildContext c) =>
      isLight(c) ? AppColorsLight.accentSoft2 : AppColors.accentSoft2;
  static Color accentBorder(BuildContext c) =>
      isLight(c) ? AppColorsLight.accentBorder : AppColors.accentBorder;
  static Color feature(BuildContext c) =>
      isLight(c) ? AppColorsLight.feature : AppColors.accent;
  static Color featureInk(BuildContext c) =>
      isLight(c) ? AppColorsLight.featureInk : AppColors.accentContrast;
  static Color link(BuildContext c) =>
      isLight(c) ? AppColorsLight.link : AppColors.accent;
  static Color highlight(BuildContext c) =>
      isLight(c) ? AppColorsLight.highlight : AppColors.warning;
  static Color success(BuildContext c) =>
      isLight(c) ? AppColorsLight.success : AppColors.success;
  static Color warning(BuildContext c) =>
      isLight(c) ? AppColorsLight.warning : AppColors.warning;
  static Color danger(BuildContext c) =>
      isLight(c) ? AppColorsLight.danger : AppColors.danger;
  static Color successSoft(BuildContext c) =>
      isLight(c) ? AppColorsLight.successSoft : AppColors.successSoft;
  static Color warningSoft(BuildContext c) =>
      isLight(c) ? AppColorsLight.warningSoft : AppColors.warningSoft;
  static Color dangerSoft(BuildContext c) =>
      isLight(c) ? AppColorsLight.dangerSoft : AppColors.dangerSoft;
}

/// ----------------------------- RADIUS -----------------------------
class AppRadius {
  AppRadius._();
  static const double xs = 4, sm = 6, md = 8, lg = 12, xl = 16, pill = 999;

  static const rXs = BorderRadius.all(Radius.circular(xs));
  static const rSm = BorderRadius.all(Radius.circular(sm));
  static const rMd = BorderRadius.all(Radius.circular(md));
  static const rLg = BorderRadius.all(Radius.circular(lg));
  static const rXl = BorderRadius.all(Radius.circular(xl));
  static const rPill = BorderRadius.all(Radius.circular(pill));
}

/// --------------------------- SPACING (8pt) ------------------------
class AppSpacing {
  AppSpacing._();
  static const double s1 = 4,
      s2 = 8,
      s3 = 12,
      s4 = 16,
      s5 = 20,
      s6 = 24,
      s8 = 32,
      s10 = 40,
      s12 = 48,
      s16 = 64;
}

/// --------------------------- ELEVATION ----------------------------
class AppShadows {
  AppShadows._();
  static const level1 = [
    BoxShadow(color: Color(0x66000000), blurRadius: 2, offset: Offset(0, 1)),
  ];
  static const level2 = [
    BoxShadow(color: Color(0x6B000000), blurRadius: 20, offset: Offset(0, 6)),
  ];
  static const level3 = [
    BoxShadow(color: Color(0x85000000), blurRadius: 40, offset: Offset(0, 16)),
  ];
}

/// ----------------------------- TYPE -------------------------------
class AppText {
  AppText._();

  static TextStyle _sans(
    double size,
    FontWeight w, {
    double height = 1.3,
    double spacing = 0,
    Color? color,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: w,
    height: height,
    letterSpacing: spacing,
    color: color,
  );

  static TextStyle get display =>
      _sans(40, FontWeight.w700, height: 1.08, spacing: -1.0);
  static TextStyle get h1 =>
      _sans(30, FontWeight.w700, height: 1.15, spacing: -0.6);
  static TextStyle get h2 =>
      _sans(24, FontWeight.w600, height: 1.20, spacing: -0.36);
  static TextStyle get h3 =>
      _sans(19, FontWeight.w600, height: 1.30, spacing: -0.19);
  static TextStyle get bodyLg => _sans(16, FontWeight.w400, height: 1.60);
  static TextStyle get body => _sans(15, FontWeight.w400, height: 1.55);
  static TextStyle get small =>
      _sans(13, FontWeight.w400, height: 1.45, color: AppColors.text2);
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
    fontSize: 12,
    letterSpacing: 0.24,
    color: AppColors.text2,
  );

  // screen-level shortcuts
  static TextStyle get navTitle => _sans(16, FontWeight.w600);
  static TextStyle get navSubtitle =>
      _sans(11, FontWeight.w400, height: 1.4, color: AppColors.text2);
  static TextStyle get caption =>
      _sans(11, FontWeight.w400, height: 1.4, color: AppColors.text3);
  static TextStyle get label =>
      _sans(12, FontWeight.w600, color: AppColors.text2);
  static TextStyle get overline =>
      _sans(11, FontWeight.w700, spacing: 0.8, color: AppColors.text3);
  static TextStyle get button => GoogleFonts.plusJakartaSans(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );
  static TextStyle get eyebrow => GoogleFonts.jetBrainsMono(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.08 * 11,
    color: AppColors.text3,
  );
  static TextStyle get chip => _sans(11, FontWeight.w600);

  static TextStyle urdu({Color? color, double fontSize = 16}) =>
      GoogleFonts.notoNastaliqUrdu(
        fontSize: fontSize,
        height: 2.0,
        color: color,
      );

  static TextStyle navTitleFor(BuildContext c) =>
      navTitle.copyWith(color: AppColorsResolver.text1(c));
  static TextStyle displayFor(BuildContext c) =>
      display.copyWith(color: AppColorsResolver.text1(c));
  static TextStyle h1For(BuildContext c) =>
      h1.copyWith(color: AppColorsResolver.text1(c));
  static TextStyle h2For(BuildContext c) =>
      h2.copyWith(color: AppColorsResolver.text1(c));
  static TextStyle h3For(BuildContext c) =>
      h3.copyWith(color: AppColorsResolver.text1(c));
  static TextStyle bodyLgFor(BuildContext c) =>
      bodyLg.copyWith(color: AppColorsResolver.text1(c));
  static TextStyle navSubtitleFor(BuildContext c) =>
      navSubtitle.copyWith(color: AppColorsResolver.text2(c));
  static TextStyle captionFor(BuildContext c) =>
      caption.copyWith(color: AppColorsResolver.text3(c));
  static TextStyle labelFor(BuildContext c) =>
      label.copyWith(color: AppColorsResolver.text2(c));
  static TextStyle overlineFor(BuildContext c) =>
      overline.copyWith(color: AppColorsResolver.text3(c));
  static TextStyle eyebrowFor(BuildContext c) =>
      eyebrow.copyWith(color: AppColorsResolver.text3(c));
  static TextStyle smallFor(BuildContext c) =>
      small.copyWith(color: AppColorsResolver.text2(c));
  static TextStyle bodyFor(BuildContext c) =>
      body.copyWith(color: AppColorsResolver.text1(c));
  static TextStyle monoFor(BuildContext c) =>
      mono.copyWith(color: AppColorsResolver.text2(c));
}

/// --------------------------- DECORATIONS --------------------------
class AppDecorations {
  AppDecorations._();

  static BoxDecoration card(BuildContext context, {Color? color}) =>
      BoxDecoration(
        color: color ?? AppColorsResolver.surface1(context),
        borderRadius: AppRadius.rLg,
        border: Border.all(color: AppColorsResolver.borderSubtle(context)),
        boxShadow: AppColorsResolver.isLight(context)
            ? const [
                BoxShadow(
                  color: Color(0x0A1A1A1A),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ]
            : AppShadows.level1,
      );

  static BoxDecoration panel(BuildContext context, {Color? color}) =>
      BoxDecoration(
        color: color ?? AppColorsResolver.surface2(context),
        borderRadius: AppRadius.rLg,
        border: Border.all(color: AppColorsResolver.border(context)),
      );

  static BoxDecoration semanticTint(BuildContext context, Color color) =>
      BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: AppRadius.rLg,
        border: Border.all(color: color.withOpacity(0.2)),
      );

  /// Legacy dark-only helpers (prefer context-aware methods above).
  static BoxDecoration cardDark({Color? color}) => BoxDecoration(
    color: color ?? AppColors.surface1,
    borderRadius: AppRadius.rLg,
    border: Border.all(color: AppColors.borderSubtle),
    boxShadow: AppShadows.level1,
  );
}

/// ------------------------ CONFIDENCE COLORS -----------------------
class AppConfidence {
  AppConfidence._();

  static Color fg(BuildContext context, double conf) {
    if (conf >= 0.8) return AppColorsResolver.success(context);
    if (conf >= 0.6) return AppColorsResolver.warning(context);
    return AppColorsResolver.danger(context);
  }

  static Color bg(BuildContext context, double conf) {
    if (conf >= 0.8) return AppColorsResolver.successSoft(context);
    if (conf >= 0.6) return AppColorsResolver.warningSoft(context);
    return AppColorsResolver.dangerSoft(context);
  }
}

/// ----------------------------- THEME ------------------------------
class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildLight();

  static ThemeData get dark => _buildDark();
}

TextTheme _textThemeFor(Color text1, Color text2, Color text3) => TextTheme(
  displaySmall: AppText.display.copyWith(color: text1),
  headlineMedium: AppText.h1.copyWith(color: text1),
  headlineSmall: AppText.h2.copyWith(color: text1),
  titleLarge: AppText.h3.copyWith(color: text1),
  bodyLarge: AppText.bodyLg.copyWith(color: text1),
  bodyMedium: AppText.body.copyWith(color: text1),
  bodySmall: AppText.small.copyWith(color: text2),
  labelSmall: AppText.mono.copyWith(color: text2),
);

ThemeData _buildLight() {
  final scheme = const ColorScheme.light(
    primary: AppColorsLight.accent,
    onPrimary: AppColorsLight.accentInk,
    secondary: AppColorsLight.link,
    onSecondary: AppColorsLight.featureInk,
    surface: AppColorsLight.surface1,
    onSurface: AppColorsLight.text1,
    error: AppColorsLight.danger,
    onError: AppColorsLight.featureInk,
    outline: AppColorsLight.border,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.canvas,
    colorScheme: scheme,
    textTheme: _textThemeFor(
      AppColorsLight.text1,
      AppColorsLight.text2,
      AppColorsLight.text3,
    ),
    dividerColor: AppColorsLight.borderSubtle,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColorsLight.canvas,
      foregroundColor: AppColorsLight.text1,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppText.navTitle.copyWith(color: AppColorsLight.text1),
      iconTheme: const IconThemeData(color: AppColorsLight.text2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColorsLight.accent,
        foregroundColor: AppColorsLight.accentInk,
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
        elevation: 0,
        textStyle: AppText.button,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.rLg),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColorsLight.text1,
        backgroundColor: Colors.transparent,
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
        side: const BorderSide(color: AppColorsLight.border),
        textStyle: AppText.button,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.rLg),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColorsLight.text2),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColorsLight.surface1,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: 14,
      ),
      hintStyle: AppText.body.copyWith(color: AppColorsLight.text3),
      labelStyle: AppText.small.copyWith(color: AppColorsLight.text2),
      border: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColorsLight.border),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColorsLight.border),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColorsLight.link, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColorsLight.danger),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColorsLight.danger, width: 1.5),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColorsLight.surface1,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.rLg,
        side: const BorderSide(color: AppColorsLight.borderSubtle),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColorsLight.surface1,
      indicatorColor: AppColorsLight.accentSoft2,
      labelTextStyle: WidgetStatePropertyAll(
        AppText.caption.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColorsLight.text3,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColorsLight.link
              : AppColorsLight.text3,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorsLight.surface1,
      selectedItemColor: AppColorsLight.link,
      unselectedItemColor: AppColorsLight.text3,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColorsLight.link,
      labelColor: AppColorsLight.link,
      unselectedLabelColor: AppColorsLight.text3,
      labelStyle: AppText.small.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle: AppText.small.copyWith(fontWeight: FontWeight.w500),
      dividerColor: AppColorsLight.borderSubtle,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColorsLight.surface2,
      labelStyle: AppText.small.copyWith(color: AppColorsLight.text1),
      side: const BorderSide(color: AppColorsLight.border),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.rPill),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s1,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColorsLight.text1,
      contentTextStyle: AppText.body.copyWith(color: AppColorsLight.canvas),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rMd),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColorsLight.link,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColorsLight.surface1,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rXl),
    ),
  );
}

ThemeData _buildDark() {
  final scheme = const ColorScheme.dark(
    primary: AppColors.accent,
    onPrimary: AppColors.accentContrast,
    secondary: AppColors.accent,
    onSecondary: AppColors.accentContrast,
    surface: AppColors.surface1,
    onSurface: AppColors.text1,
    error: AppColors.danger,
    onError: Color(0xFF2A0606),
    outline: AppColors.border,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.canvas,
    colorScheme: scheme,
    textTheme: _textThemeFor(AppColors.text1, AppColors.text2, AppColors.text3),
    dividerColor: AppColors.borderSubtle,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface1,
      foregroundColor: AppColors.text1,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppText.navTitle,
      iconTheme: const IconThemeData(color: AppColors.text2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.accentContrast,
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
        elevation: 0,
        textStyle: AppText.button,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.rMd),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.text1,
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s5),
        side: const BorderSide(color: AppColors.borderStrong),
        textStyle: AppText.button,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.rMd),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.text2),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface2,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: 14,
      ),
      hintStyle: AppText.body.copyWith(color: AppColors.text3),
      labelStyle: AppText.small.copyWith(color: AppColors.text2),
      border: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColors.border),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColors.danger),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: AppRadius.rMd,
        borderSide: BorderSide(color: AppColors.danger, width: 1.5),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface1,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.rLg,
        side: const BorderSide(color: AppColors.borderSubtle),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface1,
      indicatorColor: AppColors.accentSoft2,
      labelTextStyle: WidgetStatePropertyAll(
        AppText.caption.copyWith(fontWeight: FontWeight.w500),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.accent
              : AppColors.text3,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface1,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.text3,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColors.accent,
      labelColor: AppColors.accent,
      unselectedLabelColor: AppColors.text3,
      labelStyle: AppText.small.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle: AppText.small.copyWith(fontWeight: FontWeight.w500),
      dividerColor: AppColors.borderSubtle,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surface2,
      labelStyle: AppText.small,
      side: const BorderSide(color: AppColors.border),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.rPill),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s3,
        vertical: AppSpacing.s1,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surface3,
      contentTextStyle: AppText.body.copyWith(color: AppColors.text1),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rMd),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accent,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface1,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.rXl),
    ),
  );
}
