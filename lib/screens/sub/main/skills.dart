import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../pText.dart'; // Assuming PText is in this path
import '../../../umbra_utils/design/color.dart';

class SkillsContent extends StatelessWidget {
  const SkillsContent({super.key});

  static const double _smallScreenBreakpoint = 600.0;
  static const double _desktopHeadingFontSize = 28.0;
  static const double _mobileHeadingFontSize = 24.0;
  static const double _desktopPadding = 40.0;
  static const double _mobilePadding = 20.0;

  // Structured data for the skills
  static const List<String> _skills = [
    'Flutter',
    'Dart',
    'Firebase',
    'State Management (Bloc, Provider)',
    'REST APIs',
    'UI/UX Design Principles',
    'Git',
    'Agile Methodologies',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < _smallScreenBreakpoint;

        final double headingFontSize = isMobile
            ? _mobileHeadingFontSize
            : _desktopHeadingFontSize;
        final double horizontalPadding = isMobile
            ? _mobilePadding
            : _desktopPadding;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PText(
                "04. My Skills",
                style: GoogleFonts.robotoMono(
                  fontSize: headingFontSize,
                  color: AppColors.lightestSlate,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // The Wrap widget automatically handles line breaks for a responsive layout.
              Wrap(
                spacing: 12.0, // Horizontal space between chips
                runSpacing: 12.0, // Vertical space between lines of chips
                children: _skills
                    .map((skill) => _SkillChip(text: skill))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// A private, reusable widget to display a single skill as a chip/tag.
class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.primaryIndigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryIndigo, width: 1.0),
      ),
      child: PText(
        text,
        style: GoogleFonts.robotoMono(
          fontSize: 14,
          color: AppColors.primaryIndigo,
        ),
      ),
    );
  }
}
