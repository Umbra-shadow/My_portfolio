import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../pText.dart';
import '../../../umbra_utils/design/color.dart';

class ContactScreen extends StatelessWidget {
  final bool isTablet;
  const ContactScreen({super.key, required this.isTablet});

  // Constants for styling and layout

  // small screen breakpoint
  static const double _smallScreenBreakpoint = 600.0;

  // headings font sizes
  static const double _desktopHeadingFontSize = 50.0;
  static const double _mobileHeadingFontSize = 52.0;
  static const double _tabletHeadingFontSize = 90.0;

  // paragraph width
  static const double _desktopParagraphWidth = 500.0;
  static const double _mobileParagraphWidth = 300.0;
  static const double _tabletParagraphWidth = 300.0;

  // Compacts tablet font sizes
  static const double _tabletCompactHeadingFontSize = 50.0;
  static const double _tabletCompactParagraphWidth = 300.0;
  static const double _tabletCompactVerticalPadding = 100.0;

  // vertical padding
  static const double _desktopVerticalPadding = 50.0;
  static const double _mobileVerticalPadding = 100.0;
  static const double _tabletVerticalPadding = 150.0;

  // question font sizes
  static const double _desktopQuestionFontSize = 12.0;
  static const double _mobileQuestionFontSize = 20.0;
  static const double _tabletQuestionFontSize = 25.0;

  // text color
  static const Color _tabletTextColor = AppColors.textPrimaryBlack;
  static const Color _desktopTextColor = AppColors.slate;

  // Helper to launch URL
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final bool isCompact = width < _smallScreenBreakpoint;

        // Determine responsive values

        // vertical padding
        final double verticalPadding = isCompact
            ? (isTablet
                  ? _tabletCompactVerticalPadding
                  : _desktopVerticalPadding)
            : (isTablet ? _tabletVerticalPadding : _desktopVerticalPadding);

        // heading font sizes
        final double headingFontSize = isCompact
            ? (isTablet ? _tabletHeadingFontSize : _mobileHeadingFontSize)
            : (isTablet ? _tabletHeadingFontSize : _desktopHeadingFontSize);

        // paragraph width
        final double paragraphWidth = isCompact
            ? (isTablet ? _tabletCompactParagraphWidth : _desktopParagraphWidth)
            : (isTablet ? _desktopParagraphWidth : _desktopParagraphWidth);

        // question font sizes
        final double questionFontSize = isCompact
            ? (isTablet ? _tabletQuestionFontSize : _mobileQuestionFontSize)
            : (isTablet ? _tabletQuestionFontSize : _desktopQuestionFontSize);

        // Determine text color based on screen size.
        final Color textColor = isCompact
            ? (isTablet ? _tabletTextColor : _desktopTextColor)
            : (isTablet ? _tabletTextColor : _desktopTextColor);

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PText(
                  "05. What's Next?",
                  style: GoogleFonts.poppins(
                    color: AppColors.portfolioPurple,
                    fontSize: questionFontSize,
                  ),
                ),
                const SizedBox(height: 20),
                PText(
                  "Get In Touch",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: headingFontSize,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: paragraphWidth,
                  child: PText(
                    "I'm always excited to connect with new people and explore interesting opportunities. My inbox is open—whether for a potential project or just to say hi!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: textColor,
                      height: 1.5,
                      fontSize: questionFontSize,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _ContactButton(
                  onPressed: _launchUrl,
                  color: isTablet ? Colors.white : Colors.transparent,
                  fontSize: questionFontSize,
                ),
                const SizedBox(height: 40),
                _SocialLinks(
                  onPressed: _launchUrl,
                  size: isTablet ? 50 : 25,
                  textColor: textColor,
                ),
                SizedBox(height: 20),
                Text(
                  'Designed & Built with care by Balingene Dan',
                  style: GoogleFonts.poppins(
                    color: textColor,
                    fontSize: questionFontSize,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A private, reusable widget for the contact button.
class _ContactButton extends StatelessWidget {
  final Color color;
  final double fontSize;
  final Future<void> Function(String url) onPressed;

  const _ContactButton({
    required this.onPressed,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed('mailto:balingenensiidan@gmail.com'),
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.portfolioPurple,
        backgroundColor: color,
        side: const BorderSide(color: AppColors.portfolioPurple, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      ),
      child: PText('Say Hello', style: GoogleFonts.poppins(fontSize: fontSize)),
    );
  }
}

/// A private, reusable widget for the social media icons.
class _SocialLinks extends StatelessWidget {
  final Future<void> Function(String url) onPressed;
  final double size;
  final Color textColor;
  const _SocialLinks({
    required this.onPressed,
    required this.size,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => onPressed('mailto:balingenensiidan@gmail.com'),
          icon: Icon(CupertinoIcons.mail, color: textColor, size: size),
        ),
        IconButton(
          onPressed: () => onPressed('https://github.com/Umbra-shadow'),
          icon: Icon(BoxIcons.bxl_github, color: textColor, size: size),
        ),
        IconButton(
          onPressed: () =>
              onPressed('https://www.linkedin.com/in/dan-balingene-802100326'),
          icon: Icon(BoxIcons.bxl_linkedin, color: textColor, size: size),
        ),
      ],
    );
  }
}
