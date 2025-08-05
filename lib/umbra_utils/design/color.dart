import 'package:flutter/material.dart';

class AppColors {
  // ------------------------
  // Background Colors
  // ------------------------
  static const Color backgroundNeutral = Color(0xFFF5F5F0); // Soft neutral
  static const Color backgroundBlueDark = Color(0xFF0D1B2A); // Navy-blue
  static const Color backgroundBlack = Color(0xFF121212);
  static const Color backgroundGray = Color(0xFFEDEDED);
  static const Color backgroundCream = Color(0xFFFFFDF7); // Light cream
  static const Color backgroundSlate = Color(0xFF1E293B); // Slate blue-gray
  static const Color backgroundSoftPurple = Color(0xFFECEAFB); // Whisper purple
  static const Color backgroundMutedGreen = Color(0xFFEFF6EC); // Soft mint
  static const Color backgroundLight = Colors.white12;
  static const Color backgroundRose = Color(0xFFFFF1F3); // Subtle rose tone
  static const Color backgroundLavender = Color(0xFFF3F0FF); // Pastel lavender
  static const Color backgroundSoftPeach = Color(0xFFFFF6F0); // Light peach

  static const List<Color> backgrounds = [
    backgroundNeutral,
    backgroundBlueDark,
    backgroundBlack,
    backgroundGray,
    backgroundCream,
    backgroundSlate,
    backgroundSoftPurple,
    backgroundMutedGreen,
    backgroundRose,
    backgroundLavender,
    backgroundSoftPeach,
  ];

  // ------------------------
  // Text Colors
  // ------------------------
  static const Color textPrimaryBlack = Colors.black87;
  static const Color textSecondaryBlack = Colors.black54;
  static const Color textPrimaryWhite = Colors.white70;
  static const Color textSecondaryWhite = Colors.white60;
  static const Color textMuted = Color(0xFF6B7280); // Tailwind-style muted text
  static const Color textAccent = mainColorAccent;

  // ------------------------
  // Status Colors
  // ------------------------
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFFA000);
  static const Color success = Color(0xFF388E3C);
  static const Color info = Color(0xFF1976D2);
  static const Color notice = Color(0xFF5C6BC0); // Indigo notice

  // ------------------------
  // Border Colors
  // ------------------------
  static const Color borderLight = Color(0xFFD1D5DB);
  static const Color borderDark = Color(0xFF4B5563);
  static const Color borderMuted = Color(0xFF9CA3AF);
  static const Color borderTransparent = Colors.transparent;
  static const Color borderSubtle = Color(0xFFE0E0E0);

  // ------------------------
  // Card Backgrounds
  // ------------------------
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardLightSoft = Color(0xFFFAFAFA);
  static const Color cardMuted = Color(0xFFF0F0F0);
  static const Color cardDark = Color(0xFF1F1F1F);
  static const Color cardGlass = Color(0x99FFFFFF); // Semi-transparent white
  static const Color cardBlurPurple = Color(0xEDECEAFF);
  static const Color cardBlurRose = Color(0xFFFEF2F2);

  // ------------------------
  // Main/App Theme Colors
  // ------------------------

  // Indigo (Poetic)
  static const Color mainColor1 = Color(0xFF3F51B5);
  static const Color mainColor1Light = Color(0xFFC5CAE9);
  static const Color mainColor1Dark = Color(0xFF303F9F);

  // Teal (Emotive Calm)
  static const Color mainColor2 = Color(0xFF00695C);
  static const Color mainColor2Light = Color(0xFF439889);
  static const Color mainColor2Dark = Color(0xFF003D33);

  // Purple (Creative & Dreamy)
  static const Color mainColor3 = Color(0xFF7B1FA2);
  static const Color mainColor3Light = Color(0xFFBA68C8);
  static const Color mainColor3Dark = Color(0xFF4A0072);

  // Pink Accent (Whisper Emotion)
  static const Color mainColorAccent = Color(0xFFFF4081);
  static const Color mainColorAccentLight = Color(0xFFFF80AB);
  static const Color mainColorAccentDark = Color(0xFFF50057);

  // Soft Sky (Optional Light Blue Alt)
  static const Color mainColorSky = Color(0xFF6EC6FF);
  static const Color mainColorSkyLight = Color(0xFFB3E5FC);
  static const Color mainColorSkyDark = Color(0xFF0288D1);

  // ------------------------
  // Dashboard / GridView Highlights
  // ------------------------
  static const Color dashboardBlue = Color(0xFF2196F3);
  static const Color dashboardGreen = Color(0xFF4CAF50);
  static const Color dashboardOrange = Color(0xFFFF9800);
  static const Color dashboardPurple = Color(0xFF9C27B0);
  static const Color dashboardRed = Color(0xFFF44336);
  static const Color dashboardGray = Color(0xFFB0BEC5);

  static const List<Color> dashboardAccentSet = [
    dashboardBlue,
    dashboardGreen,
    dashboardOrange,
    dashboardPurple,
    dashboardRed,
    dashboardGray,
  ];

  // ------------------------
  // Utility & Overlay
  // ------------------------
  static const Color transparent = Colors.transparent;
  static const Color overlayDark = Color(0x88000000); // Black 50%
  static const Color overlayLight = Color(0x88FFFFFF); // White 50%
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // ------------------------
  // Gradients
  // ------------------------
  static const LinearGradient mainGradient = LinearGradient(
    colors: [mainColor3, mainColor1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient poeticGradient = LinearGradient(
    colors: [textPrimaryBlack, textSecondaryBlack],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient poeticGradient2 = LinearGradient(
    colors: [mainColor1Dark.withOpacity(0.7), mainColor1Dark.withOpacity(0.9)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const LinearGradient nightSkyGradient = LinearGradient(
    colors: [backgroundBlueDark, backgroundSlate],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ------------------------
  // Whisra Theme – Black, White, Deep Indigo
  // ------------------------

  /// Primary black background for dark mode and immersive reading areas.
  static const Color whisraBlack = Color(0xFF121212);

  /// Clean white background for light mode and neutral sections.
  static const Color whisraWhite = Color(0xFFFFFFFF);

  /// Core accent color – Deep Indigo – used for highlights, buttons, and emotional emphasis.
  static const Color whisraIndigo = Color(0xFF4B0082);

  /// Softened variant of Deep Indigo for hover states or secondary accents.
  static const Color whisraIndigoLight = Color(0xFF9370DB);

  /// Darker indigo shade for overlays, pressed states, or gradient depth.
  static const Color whisraIndigoDark = Color(0xFF2A0050);

  /// Light indigo-toned background for mood chips or soft cards.
  static const Color whisraIndigoChipBg = Color(0xFFEDE7F6);

  /// Indigo text color used inside mood chips or tag elements.
  static const Color whisraIndigoChipText = whisraIndigo;

  /// Complete color set for Whisra’s core visual theme.
  static const List<Color> whisraThemeSet = [
    whisraBlack,
    whisraWhite,
    whisraIndigo,
    whisraIndigoLight,
    whisraIndigoDark,
  ];

  // ------------------------
  // Portfolio Themes
  // ------------------------

  // 🔵 Deep Blue + Soft Gray
  static const Color portfolioNavy = Color(0xFF1E2A38);
  static const Color portfolioSkyBlue = Color(0xFF4C8EDA);
  static const Color portfolioGray = Color(0xFFF4F6F8);
  static const Color portfolioTextDark = Color(0xFF1A1A1A);
  static const Color portfolioHighlight = Color(0xFFB5D1F2);

  // 🟣 Purple + Orange Contrast
  static const Color portfolioPurple = Color(0xFF6C5CE7);
  static const Color portfolioCoral = Color(0xFFFF7675);
  static const Color portfolioNeutral = Color(0xFFFDFDFD);
  static const Color portfolioTextCharcoal = Color(0xFF2D3436);
  static const Color portfolioIcyBlue = Color(0xFFDFF9FB);

  static const Color primaryIndigo = Color(
    0xFF64FFDA,
  ); // A vibrant accent, like the site's teal/indigo highlights
  static const Color darkNavy = Color(0xFF0A192F);
  static const Color navy = Color(0xFF112240);
  static const Color lightNavy = Color(0xFF233554);

  static const Color slate = Color(0xFF8892B0);
  static const Color lightSlate = Color(0xFFA8B2D1);
  static const Color lightestSlate = Color(0xFFCCD6F6);

  // 🟢 Greenish Tech Vibe
  static const Color portfolioTurquoise = Color(0xFF1ABC9C);
  static const Color portfolioDeepGreen = Color(0xFF16A085);
  static const Color portfolioBrightGray = Color(0xFFF8F9FA);
  static const Color portfolioCharcoalBlue = Color(0xFF2C3E50);
  static const Color portfolioDivider = Color(0xFFDCDCDC);

  // ⚫ Black + Neon (Developer Style)
  static const Color portfolioDark = Color(0xFF0F0F0F);
  static const Color portfolioNeonCyan = Color(0xFF00FFC6);
  static const Color portfolioDeepBlack = Color(0xFF121212);
  static const Color portfolioWhiteText = Color(0xFFFFFFFF);
  static const Color portfolioNeonPink = Color(0xFFFF0080);

  // 🟠 Orange + Slate Gray
  static const Color portfolioOrange = Color(0xFFF57C00);
  static const Color portfolioSlate = Color(0xFF37474F);
  static const Color portfolioSnowWhite = Color(0xFFFAFAFA);
  static const Color portfolioDeepText = Color(0xFF212121);
  static const Color portfolioLightOrange = Color(0xFFFFB74D);

  // Grouped Lists (optional for theming)
  static const List<Color> portfolioBlueTheme = [
    portfolioNavy,
    portfolioSkyBlue,
    portfolioGray,
    portfolioTextDark,
    portfolioHighlight,
  ];

  static const List<Color> portfolioPurpleOrangeTheme = [
    portfolioPurple,
    portfolioCoral,
    portfolioNeutral,
    portfolioTextCharcoal,
    portfolioIcyBlue,
  ];

  static const List<Color> portfolioGreenTheme = [
    portfolioTurquoise,
    portfolioDeepGreen,
    portfolioBrightGray,
    portfolioCharcoalBlue,
    portfolioDivider,
  ];

  static const List<Color> portfolioNeonTheme = [
    portfolioDark,
    portfolioNeonCyan,
    portfolioDeepBlack,
    portfolioWhiteText,
    portfolioNeonPink,
  ];

  static const List<Color> portfolioOrangeSlateTheme = [
    portfolioOrange,
    portfolioSlate,
    portfolioSnowWhite,
    portfolioDeepText,
    portfolioLightOrange,
  ];
}
