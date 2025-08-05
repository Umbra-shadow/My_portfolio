import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../umbra_utils/design/color.dart';
import '../../main/mainscreen.dart';

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
                    )
                  : _buildDesktopLayout(
                      skills: skills,
                      isCompact: isCompact,
                      aboutFontSize: introTextFontSize,
                      skillFontSize: skillTextFontSize,
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
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _AboutTextContent(
            skills: skills,
            isCompact: isCompact,
            aboutFontSize: aboutFontSize,
            skillFontSize: skillFontSize,
          ),
        ),
        const SizedBox(width: 50),
        Expanded(flex: 2, child: _AboutImage(isCompact: isCompact)),
      ],
    );
  }

  /// Builds the MOBILE layout with staggered animations.
  Widget _buildMobileLayout({
    required List<String> skills,
    required bool isCompact,
    required double aboutFontSize,
    required double skillFontSize,
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
          ),
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
          'assets/images/me1.jpg',
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

  const _AboutTextContent({
    required this.skills,
    required this.isCompact,
    required this.aboutFontSize,
    required this.skillFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.poppins(
      fontSize: aboutFontSize,
      color: AppColors.lightSlate,
      height: 1.6,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello! I'm Dan, a developer who loves taking an idea from a blank canvas to a fully-realized product. My journey in tech began with a curiosity for how things work, which evolved into a passion for building software that is both useful and elegant.",
          style: textStyle,
        ),
        const SizedBox(height: 15),
        Text(
          "I thrive in the space where backend architecture meets user-facing design. Whether I'm architecting a database schema or polishing the final animations in a Flutter app, my focus is on quality and craftsmanship.",
          style: textStyle,
        ),
        const SizedBox(height: 15),
        Text("Here are a few technologies I work with:", style: textStyle),
        const SizedBox(height: 20),
        _SkillsList(
          skills: skills,
          isCompact: isCompact,
          skillFontSize: skillFontSize,
        ),
      ],
    );
  }
}

/// Renders the list of skills with staggered animations on mobile.
class _SkillsList extends StatelessWidget {
  final List<String> skills;
  final bool isCompact;
  final double skillFontSize;

  const _SkillsList({
    required this.skills,
    required this.isCompact,
    required this.skillFontSize,
  });

  @override
  Widget build(BuildContext context) {
    // On desktop, the Wrap widget is returned directly.
    // On mobile, it's animated.
    return Wrap(
      spacing: 16,
      runSpacing: 10,
      children: skills.map((skill) {
        final skillWidget = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(index: 3),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_right,
                color: AppColors.portfolioPurple,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              skill,
              style: GoogleFonts.poppins(
                color: AppColors.slate,
                fontSize: skillFontSize,
              ),
            ),
          ],
        );

        // Only apply animation if on mobile.
        if (isCompact) {
          // Stagger the animation of each skill for a nice cascading effect.
          return skillWidget
              .animate()
              .fade(delay: 500.ms, duration: 400.ms)
              .slideX(begin: -0.1);
        }

        return skillWidget;
      }).toList(),
    );
  }
}
