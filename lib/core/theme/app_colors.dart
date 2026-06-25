import 'package:flutter/material.dart';

/// App-wide color palette using a custom theme system.
/// Supports both light and dark modes.
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.accent,
    required this.accentLight,
    required this.surface,
    required this.card,
    required this.cardBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.danger,
    required this.warning,
    required this.divider,
    required this.beatCircleBg,
    required this.premiumBadgeBg,
  });

  /// Deep ocean blue — primary actions, active states
  final Color primary;

  /// Sky blue — highlights, selected tabs
  final Color primaryLight;

  /// Navy — headers, pressed states
  final Color primaryDark;

  /// Teal-green — play buttons, toggles ON
  final Color accent;

  /// Mint — hover/focus tints
  final Color accentLight;

  /// Off-white — page background
  final Color surface;

  /// Pure white — instrument cards
  final Color card;

  /// Soft blue-grey — card borders
  final Color cardBorder;

  /// Near-black — headings, primary text
  final Color textPrimary;

  /// Blue-grey — subtitles, labels
  final Color textSecondary;

  /// Light grey — placeholders, disabled
  final Color textHint;

  /// Muted red — destructive, premium lock
  final Color danger;

  /// Amber — tempo warnings
  final Color warning;

  /// Near-white blue — list dividers
  final Color divider;

  /// Same as primary — beat count circle background
  final Color beatCircleBg;

  /// Dark navy — premium badge
  final Color premiumBadgeBg;

  static const light = AppColors(
    primary: Color(0xFF2D6A9F),
    primaryLight: Color(0xFF5B9FD4),
    primaryDark: Color(0xFF1A4870),
    accent: Color(0xFF1DB89A),
    accentLight: Color(0xFF4ED4BC),
    surface: Color(0xFFF4F7FB),
    card: Color(0xFFFFFFFF),
    cardBorder: Color(0xFFDDE5F0),
    textPrimary: Color(0xFF1A2537),
    textSecondary: Color(0xFF5A6A82),
    textHint: Color(0xFF9AAABB),
    danger: Color(0xFFE05C5C),
    warning: Color(0xFFF0A84B),
    divider: Color(0xFFEAEFF7),
    beatCircleBg: Color(0xFF2D6A9F),
    premiumBadgeBg: Color(0xFF1A4870),
  );

  static const dark = AppColors(
    primary: Color(0xFF5B9FD4),
    primaryLight: Color(0xFF7DB5E8),
    primaryDark: Color(0xFF1A4870),
    accent: Color(0xFF4ED4BC),
    accentLight: Color(0xFF6FE4D3),
    surface: Color(0xFF0F1419),
    card: Color(0xFF1A2230),
    cardBorder: Color(0xFF2A3847),
    textPrimary: Color(0xFFE8EEF5),
    textSecondary: Color(0xFFB0BCCF),
    textHint: Color(0xFF6A7A92),
    danger: Color(0xFFFF6B6B),
    warning: Color(0xFFFFA940),
    divider: Color(0xFF2A3847),
    beatCircleBg: Color(0xFF2D6A9F),
    premiumBadgeBg: Color(0xFF1A4870),
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? primaryLight,
    Color? primaryDark,
    Color? accent,
    Color? accentLight,
    Color? surface,
    Color? card,
    Color? cardBorder,
    Color? textPrimary,
    Color? textSecondary,
    Color? textHint,
    Color? danger,
    Color? warning,
    Color? divider,
    Color? beatCircleBg,
    Color? premiumBadgeBg,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryDark: primaryDark ?? this.primaryDark,
      accent: accent ?? this.accent,
      accentLight: accentLight ?? this.accentLight,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      cardBorder: cardBorder ?? this.cardBorder,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      danger: danger ?? this.danger,
      warning: warning ?? this.warning,
      divider: divider ?? this.divider,
      beatCircleBg: beatCircleBg ?? this.beatCircleBg,
      premiumBadgeBg: premiumBadgeBg ?? this.premiumBadgeBg,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t) ?? primaryLight,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t) ?? primaryDark,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      accentLight: Color.lerp(accentLight, other.accentLight, t) ?? accentLight,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      card: Color.lerp(card, other.card, t) ?? card,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t) ?? cardBorder,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textHint: Color.lerp(textHint, other.textHint, t) ?? textHint,
      danger: Color.lerp(danger, other.danger, t) ?? danger,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      beatCircleBg: Color.lerp(beatCircleBg, other.beatCircleBg, t) ?? beatCircleBg,
      premiumBadgeBg: Color.lerp(premiumBadgeBg, other.premiumBadgeBg, t) ?? premiumBadgeBg,
    );
  }
}
