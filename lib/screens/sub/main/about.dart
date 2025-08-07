import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model.dart';
import '../../../umbra_utils/design/color.dart';
import 'home.dart';

class AboutContent extends StatelessWidget {
  final bool isTablet;
  const AboutContent({super.key, required this.isTablet});

  // font sizes
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
  static const double _tabletIntroFontSize = 20.0;
  static const double _mobileIntroFontSize = 16.0;

  // greetings font sizes
  static const double _desktopGreetingsFontSize = 14.0;
  static const double _tabletGreetingsFontSize = 20.0;
  static const double _mobileGreetingsFontSize = 14.0;

  // skill font sizes
  static const double _desktopIntroSkillSize = 10.0;
  static const double _tabletIntroSkillSize = 18.0;
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

  // text color
  static const Color _tabletTextColor = AppColors.textPrimaryBlack;
  static const Color _desktopTextColor = AppColors.slate;

  @override
  Widget build(BuildContext context) {
    const skills = [
      "C++",
      "Firebase",
      "REST APIs",
      "Fast APIs",
      "Git & GitHub",
      "Dart & Flutter",
      "SQL Databases",
      "App Architecture",
      "Python (Django)",
    ];

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
        // Determine text color based on screen size.
        final Color textColor = isCompact
            ? (isTablet ? _tabletTextColor : _desktopTextColor)
            : (isTablet ? _tabletTextColor : _desktopTextColor);

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
            children: [
              Text(
                "02. About Me",
                style: GoogleFonts.poppins(
                  fontSize: greetingFontSize,
                  color: AppColors.portfolioPurple,
                ),
              ).animate().fade(duration: 500.ms).slideX(begin: -0.2),
              const SizedBox(height: 20),
              isCompact
                  ? _buildMobileLayout(
                      skills: skills,
                      isCompact: isCompact,
                      aboutFontSize: introTextFontSize,
                      skillFontSize: skillTextFontSize,
                      textColor: textColor,
                      greetingFontSize: greetingFontSize,
                      skillTextFontSize: skillTextFontSize,
                    )
                  : _buildDesktopLayout(
                      skills: skills,
                      isCompact: isCompact,
                      aboutFontSize: introTextFontSize,
                      skillFontSize: skillTextFontSize,
                      textColor: textColor,
                      greetingFontSize: greetingFontSize,
                      skillTextFontSize: skillTextFontSize,
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout({
    required List<String> skills,
    required bool isCompact,
    required double aboutFontSize,
    required double skillFontSize,
    required Color textColor,
    required double greetingFontSize,
    required double skillTextFontSize,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _AboutTextContent(
                skills: skills,
                isCompact: isCompact,
                aboutFontSize: aboutFontSize,
                skillFontSize: skillFontSize,
                textColor: textColor,
                greetingFontSize: greetingFontSize,
                skillTextFontSize: skillTextFontSize,
              ),
            ),
            const SizedBox(width: 40),
            Expanded(flex: 2, child: _AboutImage(isCompact: isCompact)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((category) {
            return Expanded(
              child: Column(
                children: [
                  Text(
                    category,
                    style: GoogleFonts.poppins(
                      color: AppColors.portfolioPurple,
                      fontSize: greetingFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: getSkillsByCategory(category)
                        .map(
                          (skill) => SkillPointer(
                            textColor: textColor,
                            text: skill.skill,
                            fontSize: skillTextFontSize,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          }).toList(), // Don't forget .toList() to create the list of widgets
        ),
      ],
    );
  }

  /// Builds the MOBILE layout with staggered animations.
  Widget _buildMobileLayout({
    required List<String> skills,
    required bool isCompact,
    required double aboutFontSize,
    required double skillFontSize,
    required Color textColor,
    required double greetingFontSize,
    required double skillTextFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // The image fades and slides in first.
        _AnimatedFadeInSlide(
          delay: 100.ms,
          child: _AboutImage(isCompact: isCompact),
        ),
        const SizedBox(height: 40),
        // The text content follows.
        _AnimatedFadeInSlide(
          delay: 200.ms,
          child: _AboutTextContent(
            skills: skills,
            isCompact: isCompact,
            aboutFontSize: aboutFontSize,
            skillFontSize: skillFontSize,
            textColor: textColor,
            greetingFontSize: greetingFontSize,
            skillTextFontSize: skillTextFontSize,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((category) {
            return Expanded(
              child: Column(
                children: [
                  Text(
                    category,
                    style: GoogleFonts.poppins(
                      color: AppColors.portfolioPurple,
                      fontSize: greetingFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: getSkillsByCategory(category)
                        .map(
                          (skill) => SkillPointer(
                            textColor: textColor,
                            text: skill.skill,
                            fontSize: skillTextFontSize,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          }).toList(), // Don't forget .toList() to create the list of widgets
        ),
      ],
    );
  }
}

class _AnimatedFadeInSlide extends StatelessWidget {
  final Duration delay;
  final Widget child;

  const _AnimatedFadeInSlide({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fade(delay: delay, duration: 500.ms)
        .slideY(begin: 0.2, duration: 500.ms, curve: Curves.easeOut);
  }
}

class _AboutImage extends StatelessWidget {
  final bool isCompact;
  const _AboutImage({required this.isCompact});

  @override
  Widget build(BuildContext context) {
    final double imageSize = isCompact ? 200 : 250;

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.portfolioPurple, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Image.asset(
          'assets/images/me.jpg',
          fit: BoxFit.cover,
          semanticLabel: "Portrait of Dan",
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.person,
                size: 100,
                color: AppColors.portfolioPurple,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AboutTextContent extends StatelessWidget {
  final List<String> skills;
  final bool isCompact;
  final double aboutFontSize;
  final double skillFontSize;
  final Color textColor;
  final double greetingFontSize;
  final double skillTextFontSize;

  const _AboutTextContent({
    required this.skills,
    required this.isCompact,
    required this.aboutFontSize,
    required this.skillFontSize,
    required this.textColor,
    required this.greetingFontSize,
    required this.skillTextFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.poppins(
      fontSize: aboutFontSize,
      color: textColor,
      height: 1.6,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi! I'm Dan — a full-stack developer with a strong focus on mobile app development using Flutter. While I'm more invested in mobile experiences, I've also built my own portfolio website using Flutter for web, and I’m open to building more web-based projects.",
          style: textStyle,
        ),
        const SizedBox(height: 10),
        Text(
          "Beyond the frontend, I manage everything backend-related — from setting up databases and creating REST APIs with Firebase, Django REST Framework, or FastAPI, to handling Git workflows and deployment. I enjoy building complete products that connect powerful backends with polished user interfaces.",
          style: textStyle,
        ),
        const SizedBox(height: 10),
        Text(
          "I’ve worked on many exciting projects — some are already available to explore, while others are still in development. The ones in progress involve large-scale data handling and critical responsibilities, which require thoughtful design and time to execute properly.",
          style: textStyle,
        ),
        const SizedBox(height: 10),
        Text("Here are a few technologies I work with:", style: textStyle),
        const SizedBox(height: 15),
      ],
    );
  }
}
