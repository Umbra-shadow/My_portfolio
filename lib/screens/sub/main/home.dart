import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/screens/main/mainscreen.dart';

import '../../../umbra_utils/design/color.dart';
import '../../../umbra_utils/reusable/pText.dart';
import '../../main/mobilescreen.dart';

class HomeContent extends StatelessWidget {
  final bool isTablet;
  const HomeContent({super.key, required this.isTablet});

  // small screen breakpoint
  static const double _smallScreenBreakpoint = 450.0;

  // heading font sizes
  static const double _mobileHeadingFontSize = 30.0;
  static const double _desktopHeadingFontSize = 60.0;
  static const double _tabletHeadingFontSize = 70.0;

  // subheading font sizes
  static const double _mobileSubHeadingFontSize = 20.0;
  static const double _desktopSubHeadingFontSize = 40.0;
  static const double _tabletSubHeadingFontSize = 50.0;

  // intro font sizes
  static const double _desktopIntroFontSize = 13.0;
  static const double _tabletIntroFontSize = 23.0;
  static const double _mobileIntroFontSize = 16.0;

  // greetings font sizes
  static const double _desktopGreetingsFontSize = 14.0;
  static const double _tabletGreetingsFontSize = 20.0;
  static const double _mobileGreetingsFontSize = 14.0;

  // skill font sizes
  static const double _desktopIntroSkillSize = 10.0;
  static const double _tabletIntroSkillSize = 20.0;
  static const double _mobileSkillFontSize = 14.0;

  // tablet compact font sizes
  static const double _tabletCompactHeadingFontSize = 60.0;
  static const double _tabletCompactSubHeadingFontSize = 40.0;
  static const double _tabletCompactGreetingsFontSize = 40.0;
  static const double _tabletCompactIntroFontSize = 40.0;
  static const double _tabletCompactSkillFontSize = 40.0;

  // text padding
  static const double _textPadding = 20.0;
  static const double _textPaddingTablet = 50.0;
  static const double _textPaddingCompactTablet = 5.0;

  //  intro text
  static const String _fullIntroText =
      "I'm a software engineer specializing in building exceptional digital experiences. My process often starts with paper sketches, and I’m currently focused on building accessible, human-centered products for mobile using Flutter, supported by robust Python & Django backends and Firebase.";
  // Skill list
  static const List<String> _skills = [
    'Git',
    'Dart',
    'Flutter',
    'Firebase',
    'REST APIs',
    'Agile Methodologies',
    'UI/UX Design Principles',
    'State Management (Bloc, Provider)',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isCompact = width < _smallScreenBreakpoint;

        // Determine heading font sizes based on screen size.
        final headingFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactHeadingFontSize
                  : _mobileHeadingFontSize)
            : (isTablet ? _tabletHeadingFontSize : _desktopHeadingFontSize);

        // Determine subheading font sizes based on screen size.
        final subHeadingFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactSubHeadingFontSize
                  : _mobileSubHeadingFontSize)
            : (isTablet
                  ? _tabletSubHeadingFontSize
                  : _desktopSubHeadingFontSize);

        // Determine greeting font sizes based on screen size.
        final double greetingFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactGreetingsFontSize
                  : _mobileGreetingsFontSize)
            : (isTablet ? _tabletGreetingsFontSize : _desktopGreetingsFontSize);

        // Determine intro font sizes based on screen size.
        final double introTextFontSize = isCompact
            ? (isTablet ? _tabletCompactIntroFontSize : _mobileIntroFontSize)
            : (isTablet ? _tabletIntroFontSize : _desktopIntroFontSize);

        final double skillTextFontSize = isCompact
            ? (isTablet ? _tabletCompactSkillFontSize : _mobileSkillFontSize)
            : (isTablet ? _tabletIntroSkillSize : _desktopIntroSkillSize);

        // Determine which text to display.
        final String introText = isCompact
            ? (isTablet ? _fullIntroText : _fullIntroText)
            : (isTablet ? _fullIntroText : _fullIntroText);

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isCompact
                ? (isTablet ? _textPaddingCompactTablet : _textPadding)
                : (isTablet ? _textPaddingTablet : 25.0),
            horizontal: isCompact
                ? (isTablet ? _textPaddingCompactTablet : _textPadding)
                : (isTablet ? _textPaddingTablet : 25.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PText(
                "Hi, my name is",
                style: GoogleFonts.poppins(
                  color: AppColors.portfolioPurple,
                  fontSize: greetingFontSize,
                ),
              ),
              PText(
                "Balingene Dan.",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: headingFontSize,
                  color: AppColors.lightestSlate,
                ),
              ),
              const SizedBox(height: 05),
              PText(
                "I build things for mobile.",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: subHeadingFontSize,
                  color: AppColors.slate,
                ),
              ),
              const SizedBox(height: 05),
              PText(
                introText,
                style: GoogleFonts.poppins(
                  color: AppColors.slate,
                  height: 1.5,
                  fontSize: introTextFontSize,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'My Skills',
                style: GoogleFonts.poppins(
                  color: AppColors.portfolioPurple,
                  fontSize: greetingFontSize,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 12.0, // Horizontal space between chips
                runSpacing: 12.0, // Vertical space between lines of chips
                children: _skills
                    .map(
                      (skill) => _SkillChip(
                        text: skill,
                        fontsize: skillTextFontSize,
                        color1: isCompact
                            ? AppColors.textSecondaryBlack.withOpacity(0.3)
                            : AppColors.portfolioPurple.withOpacity(0.1),
                        color2: isCompact
                            ? AppColors.portfolioPurple
                            : AppColors.portfolioPurple,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 15),
              _CtaButton(
                text: 'Check Out My Work!',
                ctaBackground: isTablet ? Colors.white : Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(index: 3),
                    ),
                  );
                },
                fontsize: isCompact
                    ? (isTablet ? 14 : 12)
                    : (isTablet ? 14 : 14),
              ),
              SizedBox(height: 20),
              isTablet
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _CtaButton(
                          text: 'Exit Portfolio',
                          ctaBackground: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Mobilescreen(),
                              ),
                            );
                          },
                          fontsize: 20,
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.portfolioPurple,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Click me',
                              style: GoogleFonts.poppins(
                                color: AppColors.portfolioPurple,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

/// A private, reusable widget for the main call-to-action button.
class _CtaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontsize;
  final Color ctaBackground;

  const _CtaButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.fontsize,
    required this.ctaBackground,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.portfolioPurple,
        backgroundColor: ctaBackground,
        side: const BorderSide(color: AppColors.portfolioPurple, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      ),
      child: PText(text, style: GoogleFonts.poppins(fontSize: fontsize)),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final double fontsize;
  final String text;
  final Color color1;
  final Color color2;

  const _SkillChip({
    required this.text,
    required this.fontsize,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.portfolioPurple, width: 1.0),
      ),
      child: PText(
        text,
        style: GoogleFonts.poppins(fontSize: fontsize, color: color2),
      ),
    );
  }
}
