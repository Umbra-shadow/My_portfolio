import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/model.dart'; // Ensure this path is correct
import 'package:myportfolio/pText.dart'; // Ensure this path is correct
import 'package:myportfolio/screens/main/mobilescreen.dart'; // Ensure this path is correct
import 'package:myportfolio/umbra_utils/design/color.dart'; // Ensure this path is correct

class HomeContent extends StatelessWidget {
  final bool isTablet;
  const HomeContent({super.key, required this.isTablet});

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
  static const double _tabletIntroFontSize = 23.0;
  static const double _mobileIntroFontSize = 16.0;

  static const double _desktopGreetingsFontSize = 14.0;
  static const double _tabletGreetingsFontSize = 20.0;
  static const double _mobileGreetingsFontSize = 14.0;

  static const double _desktopIntroSkillSize = 12.0;
  static const double _tabletIntroSkillSize = 20.0;
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

  //  Intro Text
  static const String _fullIntroText =
      "I'm a software engineer specializing in building exceptional digital experiences. My process often starts with paper sketches, and I’m currently focused on building accessible, human-centered products for mobile using Flutter, supported by robust Python & Django backends and Firebase.";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isCompact = width < _smallScreenBreakpoint;
        final bool isWideSkillsLayout = width > _mobileSkillsBreakpoint;

        // --- Responsive Calculations ---
        final headingFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactHeadingFontSize
                  : _mobileHeadingFontSize)
            : (isTablet ? _tabletHeadingFontSize : _desktopHeadingFontSize);

        final subHeadingFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactSubHeadingFontSize
                  : _mobileSubHeadingFontSize)
            : (isTablet
                  ? _tabletSubHeadingFontSize
                  : _desktopSubHeadingFontSize);

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
                  fontWeight: FontWeight.w500,
                  fontSize: headingFontSize,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 5),
              PText(
                "I build things for mobile.",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: subHeadingFontSize,
                  color: textColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 15),
              PText(
                _fullIntroText,
                style: GoogleFonts.poppins(
                  color: textColor,
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
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),

              // --- Adaptive Skills Section ---
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

              const SizedBox(height: 40),
              if (isTablet) _buildTabletExitButton(context),
            ],
          ),
        );
      },
    );
  }

  // In HomeContent class, inside _buildWideSkillsLayout

  Widget _buildWideSkillsLayout(
    double categoryFontSize,
    double skillFontSize,
    Color textColor,
  ) {
    return Row(
      // This remains CrossAxisAlignment.start, which is correct.
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
                // spacing: 8,
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

  /// Builds the skills layout for narrow screens (mobile).
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
              // --- KEY CHANGE: Replaced Wrap with a Column for a clean, vertical list ---
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

  /// The exit button and its related dialog, specific to the tablet view.
  Widget _buildTabletExitButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CtaButton(
          text: 'Exit Portfolio',
          ctaBackground: Colors.white,
          onPressed: () {
            _showAlertDialog(
              context: context,
              title: 'Exit Portfolio',
              content:
                  'Are you sure you want to exit? Behind this, is another world, far from this one (check it out).',
              actions: [
                _alertDialogAction(
                  text: 'Yes',
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Mobilescreen(),
                      ),
                    );
                  },
                ),
                _alertDialogAction(
                  text: 'No',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
          fontsize: 20,
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            const Icon(Icons.arrow_back_ios, color: AppColors.portfolioPurple),
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
    );
  }

  void _showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: AppColors.textPrimaryBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(
            content,
            style: GoogleFonts.poppins(color: AppColors.textSecondaryBlack),
          ),
          actions: actions,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: AppColors.portfolioPurple, width: 1),
          ),
        );
      },
    );
  }

  Widget _alertDialogAction({
    required String text,
    required void Function() onPressed,
  }) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}

/// A private, reusable widget for the main call-to-action button.
class _CtaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontsize;
  final Color ctaBackground;

  const _CtaButton({
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

/// An improved SkillPointer widget for better layout control.
class SkillPointer extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const SkillPointer({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final skill = getSkillDetails(text);

    // --- KEY CHANGE: Added padding here to create vertical spacing in the column layout ---
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        // Ensures the Row is only as wide as its content.
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.arrow_right, color: AppColors.portfolioPurple),
          const SizedBox(width: 8),
          if (skill.imageUrl != null && skill.imageUrl!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.network(
                skill.imageUrl!,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ),
            ),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.poppins(color: textColor, fontSize: fontSize),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
