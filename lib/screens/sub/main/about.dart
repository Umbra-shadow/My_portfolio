import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/model.dart'; // Ensure this path is correct
import 'package:myportfolio/screens/sub/main/home.dart'; // Contains SkillPointer
import 'package:myportfolio/umbra_utils/design/color.dart'; // Ensure this path is correct

class AboutContent extends StatelessWidget {
  final bool isTablet;
  const AboutContent({super.key, required this.isTablet});

  // --- Constants ---
  // Breakpoints
  static const double _mobileSkillsBreakpoint = 650.0;
  static const double _smallScreenBreakpoint = 450.0;

  // Font Sizes
  static const double _mobileHeadingFontSize = 30.0;
  static const double _desktopHeadingFontSize = 60.0;
  static const double _tabletHeadingFontSize = 70.0;

  static const double _mobileSubHeadingFontSize = 20.0;
  static const double _desktopSubHeadingFontSize = 40.0;
  static const double _tabletSubHeadingFontSize = 50.0;

  static const double _desktopIntroFontSize = 13.0;
  static const double _tabletIntroFontSize = 20.0;
  static const double _mobileIntroFontSize = 16.0;

  static const double _desktopGreetingsFontSize = 14.0;
  static const double _tabletGreetingsFontSize = 20.0;
  static const double _mobileGreetingsFontSize = 14.0;

  static const double _desktopIntroSkillSize = 12.0;
  static const double _tabletIntroSkillSize = 18.0;
  static const double _mobileSkillFontSize = 14.0;

  static const double _tabletCompactHeadingFontSize = 60.0;
  static const double _tabletCompactSubHeadingFontSize = 40.0;
  static const double _tabletCompactGreetingsFontSize = 40.0;
  static const double _tabletCompactIntroFontSize = 40.0;
  static const double _tabletCompactSkillFontSize = 40.0;

  // Padding
  static const double _textPadding = 20.0;
  static const double _textPaddingTablet = 50.0;
  static const double _textPaddingCompactTablet = 5.0;

  // Colors
  static const Color _tabletTextColor = AppColors.textPrimaryBlack;
  static const Color _desktopTextColor = AppColors.slate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isCompact = width < _smallScreenBreakpoint;
        // This new breakpoint specifically controls the skills section layout
        final bool isWideSkillsLayout = width > _mobileSkillsBreakpoint;

        // --- Responsive Font Size Calculations ---
        final double greetingFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactGreetingsFontSize
                  : _mobileGreetingsFontSize)
            : (isTablet ? _tabletGreetingsFontSize : _desktopGreetingsFontSize);

        final double introTextFontSize = isCompact
            ? (isTablet ? _tabletCompactIntroFontSize : _mobileIntroFontSize)
            : (isTablet ? _tabletIntroFontSize : _desktopIntroFontSize);

        final double skillTextFontSize = isCompact
            ? (isTablet ? _tabletCompactSkillFontSize : _mobileSkillFontSize)
            : (isTablet ? _tabletIntroSkillSize : _desktopIntroSkillSize);

        final Color textColor = isTablet ? _tabletTextColor : _desktopTextColor;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isCompact
                ? (isTablet ? _textPaddingCompactTablet : _textPadding)
                : (isTablet ? _textPaddingTablet : 24.0),
            horizontal: isCompact
                ? (isTablet ? _textPaddingCompactTablet : _textPadding)
                : (isTablet ? _textPaddingTablet : 24.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "02. About Me",
                style: GoogleFonts.poppins(
                  fontSize: greetingFontSize,
                  color: AppColors.portfolioPurple,
                  fontWeight: FontWeight.w500,
                ),
              ).animate().fade(duration: 500.ms).slideX(begin: -0.2),
              const SizedBox(height: 30),

              // This part handles the main content (Image + Text)
              isCompact
                  ? _buildMobileLayout(
                      aboutFontSize: introTextFontSize,
                      textColor: textColor,
                    )
                  : _buildDesktopLayout(
                      aboutFontSize: introTextFontSize,
                      textColor: textColor,
                    ),

              const SizedBox(height: 20),
              Text(
                "Technologies I Use",
                style: GoogleFonts.poppins(
                  fontSize: greetingFontSize,
                  color: AppColors.portfolioPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              if (isWideSkillsLayout)
                _buildWideSkillsLayout(
                  greetingFontSize,
                  skillTextFontSize,
                  textColor,
                )
              else
                _buildNarrowSkillsLayout(
                  greetingFontSize,
                  skillTextFontSize,
                  textColor,
                ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the layout for the main content (text + image) on WIDE screens.
  Widget _buildDesktopLayout({
    required double aboutFontSize,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3, // Give more space to text
          child: _AboutTextContent(
            aboutFontSize: aboutFontSize,
            textColor: textColor,
          ),
        ),
        const SizedBox(width: 50),
        Expanded(
          flex: 2, // A bit less space for the image
          child: const _AboutImage(
            isCompact: false,
          ).animate().fade(delay: 200.ms, duration: 500.ms),
        ),
      ],
    );
  }

  /// Builds the layout for the main content (text + image) on NARROW screens.
  Widget _buildMobileLayout({
    required double aboutFontSize,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: const _AboutImage(
            isCompact: true,
          ).animate().fade(delay: 100.ms, duration: 500.ms),
        ),
        const SizedBox(height: 40),
        _AboutTextContent(
          aboutFontSize: aboutFontSize,
          textColor: textColor,
        ).animate().fade(delay: 200.ms, duration: 500.ms),
      ],
    );
  }

  /// Builds the skills layout for WIDE screens (desktop/tablet).
  Widget _buildWideSkillsLayout(
    double categoryFontSize,
    double skillFontSize,
    Color textColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((category) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: GoogleFonts.poppins(
                  color: AppColors.portfolioPurple,
                  fontSize: categoryFontSize,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 15),
              Wrap(
                // spacing: 5,
                // runSpacing: 10,
                alignment: WrapAlignment.start,
                children: getSkillsByCategory(category)
                    .map(
                      (skill) => SkillPointer(
                        textColor: textColor,
                        text: skill.skill,
                        fontSize: skillFontSize,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Builds the skills layout for NARROW screens (mobile).
  Widget _buildNarrowSkillsLayout(
    double categoryFontSize,
    double skillFontSize,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: GoogleFonts.poppins(
                  color: AppColors.portfolioPurple,
                  fontSize: categoryFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              // Use a Column for a clean, vertical list on mobile
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: getSkillsByCategory(category)
                    .map(
                      (skill) => SkillPointer(
                        textColor: textColor,
                        text: skill.skill,
                        fontSize: skillFontSize,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _AboutImage extends StatelessWidget {
  final bool isCompact;
  const _AboutImage({required this.isCompact});

  @override
  Widget build(BuildContext context) {
    final double imageSize = isCompact ? 220 : 280;

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        color: AppColors.portfolioPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // The image itself
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/me.jpg',
                fit: BoxFit.cover,
                width: imageSize - 10, // Slightly smaller to reveal the border
                height: imageSize - 10,
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
          ),
          // The decorative border
          Container(
            width: imageSize,
            height: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.portfolioPurple, width: 2),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutTextContent extends StatelessWidget {
  final double aboutFontSize;
  final Color textColor;

  const _AboutTextContent({
    required this.aboutFontSize,
    required this.textColor,
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
        const SizedBox(height: 15),
        Text(
          "Beyond the frontend, I manage everything backend-related — from setting up databases and creating REST APIs with Firebase, Django REST Framework, or FastAPI, to handling Git workflows and deployment. I enjoy building complete products that connect powerful backends with polished user interfaces.",
          style: textStyle,
        ),
        const SizedBox(height: 15),
        Text(
          "I’ve worked on many exciting projects — some are already available to explore, while others are still in development. The ones in progress involve large-scale data handling and critical responsibilities, which require thoughtful design and time to execute properly.",
          style: textStyle,
        ),
      ],
    );
  }
}
