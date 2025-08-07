import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/model.dart';

import '../../../pText.dart';
import '../../../umbra_utils/design/color.dart';
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

  // text color
  static const Color _tabletTextColor = AppColors.textPrimaryBlack;
  static const Color _desktopTextColor = AppColors.slate;

  //  intro text
  static const String _fullIntroText =
      "I'm a software engineer specializing in building exceptional digital experiences. My process often starts with paper sketches, and I’m currently focused on building accessible, human-centered products for mobile using Flutter, supported by robust Python & Django backends and Firebase.";
  // Skill list

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

        // Determine text color based on screen size.
        final Color textColor = isCompact
            ? (isTablet ? _tabletTextColor : _desktopTextColor)
            : (isTablet ? _tabletTextColor : _desktopTextColor);

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isCompact
                ? (isTablet ? _textPaddingCompactTablet : _textPadding)
                : (isTablet ? _textPaddingTablet : 10.0),
            horizontal: isCompact
                ? (isTablet ? _textPaddingCompactTablet : _textPadding)
                : (isTablet ? _textPaddingTablet : 10.0),
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
              const SizedBox(height: 05),
              PText(
                "I build things for mobile.",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: subHeadingFontSize,
                  color: textColor.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 05),
              PText(
                introText,
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
                ),
              ),
              const SizedBox(height: 05),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categories.map(
                  (category) {
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
                  },
                ).toList(), // Don't forget .toList() to create the list of widgets
              ),
              const SizedBox(height: 15),
              isTablet
                  ? Row(
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
                                  'Are you sure you want to exit? Behind this,is another world,far from this one(check it out).',
                              actions: [
                                _alertDialogAction(
                                  text: 'Yes',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Mobilescreen(),
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
          content: SizedBox(
            width: 50,
            height: 60,
            child: Text(
              content,
              style: GoogleFonts.poppins(color: AppColors.textSecondaryBlack),
            ),
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

  _alertDialogAction({
    required String text,
    required Null Function() onPressed,
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

// class _SkillChip extends StatelessWidget {
//   final double fontsize;
//   final String text;
//   final Color color1;
//   final Color color2;
//
//   const _SkillChip({
//     required this.text,
//     required this.fontsize,
//     required this.color1,
//     required this.color2,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       decoration: BoxDecoration(
//         color: color1,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.portfolioPurple, width: 1.0),
//       ),
//       child: PText(
//         text,
//         style: GoogleFonts.poppins(fontSize: fontsize, color: color2),
//       ),
//     );
//   }
// }

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

    return Row(
      children: [
        const Icon(Icons.arrow_right, color: AppColors.portfolioPurple),
        skill.imageUrl != null
            ? SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.network(
                  skill.imageUrl ?? '',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(width: 0),
        const SizedBox(width: 05),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.poppins(color: textColor, fontSize: fontSize),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
