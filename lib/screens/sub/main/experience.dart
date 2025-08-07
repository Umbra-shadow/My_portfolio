import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/umbra_utils/design/color.dart'; // Make sure this path is correct
import 'package:url_launcher/url_launcher.dart';

// --- DATA MODEL (Remains the same for scalability) ---
class ExperienceItem {
  final String category;
  final String title;
  final String subtitle;
  final String? institution;
  final String? institutionUrl;
  final List<String> responsibilities;

  const ExperienceItem({
    required this.category,
    required this.title,
    required this.subtitle,
    this.institution,
    this.institutionUrl,
    required this.responsibilities,
  });
}

final List<ExperienceItem> _allExperiences = [
  const ExperienceItem(
    category: "Professional Journey",
    title: "From Electronics to Software — A Cross-Disciplinary Path",
    subtitle: "2018 - Present",
    responsibilities: [
      "My journey began with hands-on electronics, where I spent four years studying Electronic Engineering — building systems with Arduino and Raspberry Pi, gaining deep knowledge of circuits, sensors, and embedded logic.",
      "In 2022, I spent a year at Kenya Aeronautical College pursuing Aerospace Engineering. There, I worked on small plane prototypes, learning about aerodynamics, thermodynamics, and mechanical structures — which taught me discipline, systems integration, and precision thinking.",
      "In 2023, I transitioned to Software Engineering, where I’ve found a balance between logic and creativity. I now build full-stack mobile and web apps using Flutter, Django, FastAPI, and Firebase.",
      "I’m proficient in both frontend design and backend architecture, and I handle every aspect of my projects — from database models to Git workflows to deployment pipelines.",
      "Some of my systems work with sensitive data (healthcare, emergency services, government), so while not all projects are public, many are in progress and others are already available to see for some in my portfolio.",
      "This cross-domain background — electronics, aerospace, and software — makes me a systems thinker, capable of designing robust and scalable tech for real-world challenges.",
      "This journey is more than just a story — it's also a growing body of work. If you're curious to see what I've built so far or want a glance at the ideas I've brought to life, head over to the 'Work' section. There, you'll find some of my ongoing and completed projects, each with a story of its own.",
    ],
  ),
  const ExperienceItem(
    category: "Education",
    title: "B.Sc. in Software Engineering",
    institution: "United States International University - Africa",
    institutionUrl: "https://www.usiu.ac.ke/",
    subtitle: "Expected Graduation: December 2027",
    responsibilities: [
      "Studying software architecture, databases, algorithms, systems design, and machine learning.",
      "Building both frontend and backend systems using tools like Flutter, Django, Firebase, and PostgreSQL.",
      "Designing and managing complete applications and interfaces — from UX to infrastructure.",
      "Expected to graduate in 2027 with plans to pursue a Master's in a related engineering field.",
    ],
  ),
  const ExperienceItem(
    category: "Education",
    title: "Aviation Engineering (1 year)",
    institution: "Kenya Aeronautical College",
    institutionUrl: "https://www.kac.co.ke/",
    subtitle: "Focus: Aeronautical Systems, 2022",
    responsibilities: [
      "Completed foundational studies in aeronautics, electronics, and systems navigation.",
      "Built foundational engineering problem-solving and technical interpretation skills.",
      "Transitioned to software engineering to pursue a broader engineering vision.",
    ],
  ),
  const ExperienceItem(
    category: "Education",
    title: "High School Diploma – Electronics Engineering Track",
    institution: "École du Cinquantenaire - Goma (DRC)",
    institutionUrl:
        "https://www.youtube.com/watch?v=Y3ZTZSfhTmI&ab_channel=BertinVick",
    subtitle: "2014–2021 (DR Congo)",
    responsibilities: [
      "Began electronic engineering studies two years after enrollment.",
      "Gained hands-on skills in electrical circuits, hardware logic, and early-stage device prototyping.",
      "Laid the foundation for future engineering interests — especially in embedded and digital systems.",
    ],
  ),
];

// --- MAIN WIDGET ---
class ExperienceContent extends StatefulWidget {
  final bool isTablet;
  const ExperienceContent({super.key, required this.isTablet});

  @override
  State<ExperienceContent> createState() => _ExperienceContentState();
}

class _ExperienceContentState extends State<ExperienceContent> {
  // --- State and Constants ---
  static const double _mobileBreakpoint = 768.0;
  int _activeIndex = 0;
  List<String> _tabTitles = []; // This will be generated dynamically

  @override
  void initState() {
    super.initState();
    // THE KEY: Automatically generate the tab titles from the data.
    // This uses a Set to get the unique category names in order.
    _tabTitles = _allExperiences.map((item) => item.category).toSet().toList();
  }

  // --- Font Size Constants (no changes here) ---
  static const double _desktopGreetingsFontSize = 14.0;
  static const double _tabletGreetingsFontSize = 25.0;
  static const double _mobileGreetingsFontSize = 14.0;

  static const double _desktopTabTitleFontSize = 14.0;
  static const double _tabletTabTitleFontSize = 20.0;
  static const double _mobileTabTitleFontSize = 13.0;

  static const double _desktopPanelTitleFontSize = 20.0;
  static const double _tabletPanelTitleFontSize = 30.0;
  static const double _mobilePanelTitleFontSize = 18.0;

  static const double _desktopPanelSubtitleFontSize = 13.0;
  static const double _tabletPanelSubtitleFontSize = 25.0;
  static const double _mobilePanelSubtitleFontSize = 12.0;

  static const double _desktopPanelBodyFontSize = 14.0;
  static const double _tabletPanelBodyFontSize = 25.0;
  static const double _mobilePanelBodyFontSize = 13.0;

  static const Color _tabletTextColor = AppColors.textPrimaryBlack;
  static const Color _desktopTextColor = AppColors.slate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobileLayout = constraints.maxWidth < _mobileBreakpoint;

        // --- Responsive Font Size Calculations (no changes here) ---
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

        final Color textColor = widget.isTablet
            ? _tabletTextColor
            : _desktopTextColor;

        // DYNAMIC CONTENT: Filter the experiences to get only the items
        // for the currently selected tab.
        final String selectedCategory = _tabTitles[_activeIndex];
        final List<ExperienceItem> activeItems = _allExperiences
            .where((item) => item.category == selectedCategory)
            .toList();

        // Build the panel of content for the active tab.
        final Widget contentPanel = SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: activeItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: _ExperiencePanel(
                  item: item,
                  titleFontSize: panelTitleFontSize,
                  subtitleFontSize: panelSubtitleFontSize,
                  bodyFontSize: panelBodyFontSize,
                  textColor: textColor,
                ),
              );
            }).toList(),
          ),
        );

        return SingleChildScrollView(
          child: Column(
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
              // Use the responsive layout builders again
              isMobileLayout
                  ? _buildMobileLayout(
                      contentPanel: contentPanel,
                      tabTitleFontSize: tabTitleFontSize,
                      textColor: textColor,
                    )
                  : _buildDesktopLayout(
                      contentPanel: contentPanel,
                      tabTitleFontSize: tabTitleFontSize,
                      textColor: textColor,
                    ),
            ],
          ),
        );
      },
    );
  }

  // --- Responsive Layout Builders ---

  Widget _buildDesktopLayout({
    required Widget contentPanel,
    required double tabTitleFontSize,
    required Color textColor,
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
                textColor: textColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: _buildAnimatedContentPanel(contentPanel)),
      ],
    );
  }

  Widget _buildMobileLayout({
    required Widget contentPanel,
    required double tabTitleFontSize,
    required Color textColor,
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
                textColor: textColor,
              ),
            ),
          ),
        ).animate().fade(delay: 200.ms, duration: 500.ms),
        const SizedBox(height: 20),
        _buildAnimatedContentPanel(contentPanel),
      ],
    ).animate().slideY(begin: 0.1, delay: 100.ms, duration: 500.ms);
  }

  // The AnimatedSwitcher makes the content fade in and out smoothly.
  Widget _buildAnimatedContentPanel(Widget contentPanel) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: Container(
        // The key is crucial for AnimatedSwitcher to know the content has changed.
        key: ValueKey<int>(_activeIndex),
        child: contentPanel,
      ),
    );
  }
}

// --- HELPER AND SUB-WIDGETS (No changes needed below this line) ---

class _TabButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final bool isVertical;
  final double titleFontSize;
  final Color textColor;

  const _TabButton({
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.titleFontSize,
    required this.textColor,
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
            color: isActive ? AppColors.portfolioPurple : textColor,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ExperiencePanel extends StatelessWidget {
  final ExperienceItem item;
  final double titleFontSize;
  final double subtitleFontSize;
  final double bodyFontSize;
  final Color textColor;

  const _ExperiencePanel({
    required this.item,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.bodyFontSize,
    required this.textColor,
  });

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.poppins(
      fontSize: titleFontSize,
      fontWeight: FontWeight.w500,
      color: textColor,
    );
    final institutionStyle = titleStyle.copyWith(
      color: AppColors.portfolioPurple,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 4.0,
          spacing: 8.0,
          children: [
            Text(item.title, style: titleStyle),
            if (item.institution != null) ...[
              Text("@", style: institutionStyle),
              InkWell(
                onTap: () {
                  if (item.institutionUrl != null) {
                    _launchUrl(context, item.institutionUrl!);
                  }
                },
                child: Text(item.institution!, style: institutionStyle),
              ),
              if (item.institutionUrl != null)
                _ClickableIndicator(fontSize: bodyFontSize),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          item.subtitle,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: subtitleFontSize,
          ),
        ),
        const SizedBox(height: 20),
        for (var responsibility in item.responsibilities)
          _BulletPoint(
            text: responsibility,
            fontSize: bodyFontSize,
            textColor: textColor,
          ),
      ],
    );
  }
}

class _ClickableIndicator extends StatelessWidget {
  final double fontSize;
  const _ClickableIndicator({required this.fontSize});

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
  final Color textColor;

  const _BulletPoint({
    required this.text,
    required this.fontSize,
    required this.textColor,
  });

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
                color: textColor,
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
