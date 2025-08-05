import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../umbra_utils/design/color.dart';

class ExperienceContent extends StatefulWidget {
  final bool isTablet;
  const ExperienceContent({super.key, required this.isTablet});

  @override
  State<ExperienceContent> createState() => _ExperienceContentState();
}

class _ExperienceContentState extends State<ExperienceContent> {
  // --- Breakpoints ---
  static const double _mobileBreakpoint = 768.0;

  // --- Font Sizes ---
  // Greetings ("03. My Journey")
  static const double _desktopGreetingsFontSize = 14.0;
  static const double _tabletGreetingsFontSize = 25.0;
  static const double _mobileGreetingsFontSize = 14.0;

  // Tab Titles ("Professional Journey", "Education")
  static const double _desktopTabTitleFontSize = 14.0;
  static const double _tabletTabTitleFontSize = 20.0;
  static const double _mobileTabTitleFontSize = 13.0;

  // Panel Title ("My Journey as a Developer")
  static const double _desktopPanelTitleFontSize = 20.0;
  static const double _tabletPanelTitleFontSize = 30.0;
  static const double _mobilePanelTitleFontSize = 18.0;

  // Panel Subtitle ("Since 2023 - Present")
  static const double _desktopPanelSubtitleFontSize = 13.0;
  static const double _tabletPanelSubtitleFontSize = 25.0;
  static const double _mobilePanelSubtitleFontSize = 12.0;

  // Panel Body Text (Bullet Points)
  static const double _desktopPanelBodyFontSize = 14.0;
  static const double _tabletPanelBodyFontSize = 25.0;
  static const double _mobilePanelBodyFontSize = 13.0;

  // --- State ---
  int _activeIndex = 0;
  final List<String> _tabTitles = ["Professional Journey", "Education"];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobileLayout = constraints.maxWidth < _mobileBreakpoint;

        // Determine all font sizes based on screen type
        final double greetingFontSize = widget.isTablet
            ? _tabletGreetingsFontSize
            : (isMobileLayout
                  ? _mobileGreetingsFontSize
                  : _desktopGreetingsFontSize);

        final double tabTitleFontSize = widget.isTablet
            ? _tabletTabTitleFontSize
            : (isMobileLayout
                  ? _mobileTabTitleFontSize
                  : _desktopTabTitleFontSize);

        final double panelTitleFontSize = widget.isTablet
            ? _tabletPanelTitleFontSize
            : (isMobileLayout
                  ? _mobilePanelTitleFontSize
                  : _desktopPanelTitleFontSize);

        final double panelSubtitleFontSize = widget.isTablet
            ? _tabletPanelSubtitleFontSize
            : (isMobileLayout
                  ? _mobilePanelSubtitleFontSize
                  : _desktopPanelSubtitleFontSize);

        final double panelBodyFontSize = widget.isTablet
            ? _tabletPanelBodyFontSize
            : (isMobileLayout
                  ? _mobilePanelBodyFontSize
                  : _desktopPanelBodyFontSize);

        // Define panels here, inside build, so they can use the calculated font sizes
        final List<Widget> tabPanels = [
          _ExperiencePanel(
            title: "My Journey as a Developer",
            subtitle: "Since 2023 - Present",
            titleFontSize: panelTitleFontSize,
            subtitleFontSize: panelSubtitleFontSize,
            bodyFontSize: panelBodyFontSize,
            responsibilities: const [
              "My coding experience started in 2023 and has been centered on personal projects spanning web development, backend services, and full-stack mobile development.",
              "I am all about building robust and user-friendly applications and am actively looking to apply my skills in professional settings through internships, or full-time roles.",
              "Eager to contribute to innovative teams and grow my expertise in a collaborative environment.",
            ],
          ),
          _ExperiencePanel(
            title: "B.Sc. in Software Engineering",
            institution: "United State International University - Africa",
            institutionUrl: "https://www.usiu.ac.ke/",
            subtitle: "Expected Graduation: December 2027",
            titleFontSize: panelTitleFontSize,
            subtitleFontSize: panelSubtitleFontSize,
            bodyFontSize: panelBodyFontSize,
            responsibilities: const [
              "Focused on core principles of software architecture, data structures, and algorithms.",
              "Developed a strong understanding of database systems and network protocols.",
              "Completed numerous projects involving both individual and team-based development, emphasizing agile methodologies.",
            ],
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "03. My Journey",
              style: GoogleFonts.poppins(
                fontSize: greetingFontSize,
                color: AppColors.portfolioPurple,
              ),
            ).animate().fade(duration: 500.ms).slideX(begin: -0.2),
            const SizedBox(height: 40),
            Flexible(
              child: isMobileLayout
                  ? _buildMobileLayout(
                      tabPanels: tabPanels,
                      tabTitleFontSize: tabTitleFontSize,
                    )
                  : _buildDesktopLayout(
                      tabPanels: tabPanels,
                      tabTitleFontSize: tabTitleFontSize,
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDesktopLayout({
    required List<Widget> tabPanels,
    required double tabTitleFontSize,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              _tabTitles.length,
              (index) => _TabButton(
                title: _tabTitles[index],
                titleFontSize: tabTitleFontSize,
                isActive: _activeIndex == index,
                onTap: () => setState(() => _activeIndex = index),
                isVertical: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: _buildAnimatedContentPanel(tabPanels)),
      ],
    );
  }

  Widget _buildMobileLayout({
    required List<Widget> tabPanels,
    required double tabTitleFontSize,
  }) {
    return Column(
      children: [
        Row(
          children: List.generate(
            _tabTitles.length,
            (index) => Expanded(
              child: _TabButton(
                title: _tabTitles[index],
                titleFontSize: tabTitleFontSize,
                isActive: _activeIndex == index,
                onTap: () => setState(() => _activeIndex = index),
                isVertical: false,
              ),
            ),
          ),
        ).animate().fade(delay: 200.ms, duration: 500.ms),
        const SizedBox(height: 20),
        _buildAnimatedContentPanel(tabPanels),
      ],
    ).animate().slideY(begin: 0.1, delay: 100.ms, duration: 500.ms);
  }

  Widget _buildAnimatedContentPanel(List<Widget> tabPanels) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: Container(
        key: ValueKey<int>(_activeIndex),
        child: tabPanels[_activeIndex],
      ),
    );
  }
}

// --- HELPER AND SUB-WIDGETS ---

class _TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final bool isVertical;
  final double titleFontSize;

  const _TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.titleFontSize,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: AppColors.lightNavy.withOpacity(0.5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.lightNavy : Colors.transparent,
          border: isVertical
              ? Border(
                  left: BorderSide(
                    color: isActive
                        ? AppColors.portfolioPurple
                        : AppColors.slate.withOpacity(0.3),
                    width: 2,
                  ),
                )
              : Border(
                  bottom: BorderSide(
                    color: isActive
                        ? AppColors.portfolioPurple
                        : AppColors.slate.withOpacity(0.3),
                    width: 2,
                  ),
                ),
        ),
        child: Text(
          title,
          textAlign: isVertical ? TextAlign.left : TextAlign.center,
          style: GoogleFonts.poppins(
            color: isActive ? AppColors.portfolioPurple : AppColors.slate,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ExperiencePanel extends StatelessWidget {
  final String title;
  final String? institution;
  final String? institutionUrl;
  final String subtitle;
  final List<String> responsibilities;
  final double titleFontSize;
  final double subtitleFontSize;
  final double bodyFontSize;

  const _ExperiencePanel({
    required this.title,
    this.institution,
    this.institutionUrl,
    required this.subtitle,
    required this.responsibilities,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.bodyFontSize,
  });

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.poppins(
      fontSize: titleFontSize,
      fontWeight: FontWeight.bold,
      color: AppColors.lightestSlate,
    );
    final institutionStyle = titleStyle.copyWith(
      color: AppColors.portfolioPurple,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 4.0,
            spacing: 8.0,
            children: [
              Text(title, style: titleStyle),
              if (institution != null) ...[
                Text("@", style: institutionStyle),
                InkWell(
                  onTap: () {
                    if (institutionUrl != null) {
                      _launchUrl(context, institutionUrl!);
                    }
                  },
                  child: Text(institution!, style: institutionStyle),
                ),
                if (institutionUrl != null)
                  _ClickableIndicator(fontSize: bodyFontSize),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: AppColors.lightSlate,
              fontSize: subtitleFontSize,
            ),
          ),
          const SizedBox(height: 20),
          for (var responsibility in responsibilities)
            _BulletPoint(text: responsibility, fontSize: bodyFontSize),
        ],
      ),
    );
  }
}

class _ClickableIndicator extends StatelessWidget {
  final double fontSize;
  const _ClickableIndicator({required this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            Icon(
              Icons.ads_click_rounded,
              color: AppColors.portfolioPurple,
              size: fontSize,
            ),
            const SizedBox(width: 4),
            Text(
              "<- click me",
              style: TextStyle(
                color: AppColors.portfolioPurple,
                fontSize: fontSize,
              ),
            ),
          ],
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(delay: 2000.ms, duration: 1000.ms, color: AppColors.lightNavy);
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  final double fontSize;
  const _BulletPoint({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(
              Icons.arrow_right,
              color: AppColors.portfolioPurple,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: AppColors.slate,
                fontSize: fontSize,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
