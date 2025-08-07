import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../umbra_utils/design/color.dart';

class WorkContent extends StatelessWidget {
  final bool isTablet;
  const WorkContent({super.key, required this.isTablet});

  static const double _smallScreenBreakpoint = 450.0;
  static const double _cardSpacing = 10.0;

  // fonts
  static const double _desktopHeadingFontSize = 12.0;
  static const double _tabletHeadingFontSize = 25.0;
  static const double _mobileHeadingFontSize = 20.0;

  //title font sizes
  static const double _desktopTitleFontSize = 13.0;
  static const double _tabletTitleFontSize = 25.0;
  static const double _mobileTitleFontSize = 16.0;

  // description font sizes
  static const double _desktopDescriptionFontSize = 10.0;
  static const double _tabletDescriptionFontSize = 16.0;
  static const double _mobileDescriptionFontSize = 14.0;

  // tags font sizes
  static const double _desktopTagsFontSize = 10.0;
  static const double _tabletTagsFontSize = 14.0;
  static const double _mobileTagsFontSize = 10.0;

  // intro font sizes
  static const double _desktopIntroFontSize = 13.0;
  static const double _tabletIntroFontSize = 20.0;
  static const double _mobileIntroFontSize = 14.0;

  // compact font sizes
  static const double _tabletCompactTitleFontSize = 20.0;
  static const double _tabletCompactDescriptionFontSize = 14.0;
  static const double _tabletCompactTagsFontSize = 10.0;
  static const double _tabletCompactHeadingFontSize = 14.0;
  static const double _tabletCompactIntroFontSize = 14.0;
  static const double _tabletCompactVerticalPadding = 100.0;

  // vertical padding
  static const double _desktopVerticalPadding = 0.0;
  static const double _mobileVerticalPadding = 100.0;
  static const double _tabletVerticalPadding = 50.0;
  // text color
  static const Color _tabletTextColor = AppColors.textPrimaryBlack;
  static const Color _desktopTextColor = AppColors.slate;

  static const List<Map<String, dynamic>> _projects = [
    {
      'title': 'IdeaNest',
      'desc':
          'A full-stack mobile application for capturing, organizing, and developing personal project ideas.',
      'tags': ['Flutter', 'Django', 'PostgreSQL'],
      'isAvailable': true,
      'iosLink': 'https://apps.apple.com/app/id6748742063',
      'androidLink':
          'https://play.google.com/store/apps/details?id=com.ashumerix.ideanest_u',
    },
    {
      'title': 'Zura',
      'desc':
          'A streamlined mobile app for emergency alerts and instant communication with emergency services.',
      'tags': ['Flutter', 'Django', 'PostgreSQL'],
      'isAvailable': false,
      'iosLink': '',
      'androidLink': '',
    },
    {
      'title': 'Skoora',
      'desc':
          'A school-specific emergency system designed to quickly send alerts from classrooms to support teams.',
      'tags': ['Flutter', 'Django', 'PostgreSQL'],
      'isAvailable': false,
      'iosLink': '',
      'androidLink': '',
    },
    {
      'title': 'Appodeo',
      'desc':
          'A decentralized control system for managing multiple apps and databases from a single admin interface.',
      'tags': ['Django', 'Flutter', 'PostgreSQL'],
      'isAvailable': false,
      'iosLink': '',
      'androidLink': '',
    },
    {
      'title': 'Govonic',
      'desc':
          'A secure digital infrastructure designed to streamline identity verification and official documentation access in governmental interactions. Built for adaptability and discretion, it enhances how individuals and institutions manage and present critical records within regulated environments.',
      'tags': ['Django', 'Flutter', 'PostgreSQL'],
      'isAvailable': false,
      'iosLink': '',
      'androidLink': '',
    },
    {
      'title': 'Recurex',
      'desc':
          'A hospital-grade platform for centralizing and managing patient medical records securely.',
      'tags': ['Django', 'Flutter', 'PostgreSQL'],
      'isAvailable': false,
      'iosLink': '',
      'androidLink': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < _smallScreenBreakpoint;

        // heading font size
        final double headingFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactHeadingFontSize
                  : _mobileHeadingFontSize)
            : (isTablet ? _tabletHeadingFontSize : _desktopHeadingFontSize);

        // title font size
        final double titleFontSize = isCompact
            ? (isTablet ? _tabletCompactTitleFontSize : _mobileTitleFontSize)
            : (isTablet ? _tabletTitleFontSize : _desktopTitleFontSize);

        // description font size
        final double descriptionFontSize = isCompact
            ? (isTablet
                  ? _tabletCompactDescriptionFontSize
                  : _mobileDescriptionFontSize)
            : (isTablet
                  ? _tabletDescriptionFontSize
                  : _desktopDescriptionFontSize);

        // tags font size
        final double tagsFontSize = isCompact
            ? (isTablet ? _tabletCompactTagsFontSize : _mobileTagsFontSize)
            : (isTablet ? _tabletTagsFontSize : _desktopTagsFontSize);

        // intro font size
        final double introFontSize = isCompact
            ? (isTablet ? _tabletCompactIntroFontSize : _mobileIntroFontSize)
            : (isTablet ? _tabletIntroFontSize : _desktopIntroFontSize);

        // Determine text color based on screen size.
        final Color textColor = isCompact
            ? (isTablet ? _tabletTextColor : _desktopTextColor)
            : (isTablet ? _tabletTextColor : _desktopTextColor);

        // card ratio
        final double ratio = isCompact
            ? (isTablet ? 1 : 0.99)
            : (isTablet ? 0.8 : 1.25);

        // padding
        final double verticalPadding = isCompact
            ? (isTablet
                  ? _tabletCompactVerticalPadding
                  : _desktopVerticalPadding)
            : (isTablet ? _tabletVerticalPadding : _desktopVerticalPadding);

        // colors
        final Color titleColor = isTablet
            ? AppColors.textPrimaryBlack
            : AppColors.textPrimaryBlack;
        final Color cardColor = isTablet
            ? Colors.white
            : AppColors.lightestSlate;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "04. Some Things I've Built",
                  style: GoogleFonts.poppins(
                    fontSize: headingFontSize,
                    color: AppColors.portfolioPurple,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Here are a few projects I've worked on or am still actively building. Some are already available, while others are still in development — often involving complex systems, large datasets, or responsibilities that take time to shape fully.",
                  style: GoogleFonts.poppins(
                    fontSize: introFontSize,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isCompact ? 2 : 3,
                    childAspectRatio: ratio,
                    crossAxisSpacing: _cardSpacing,
                    mainAxisSpacing: _cardSpacing,
                  ),
                  itemCount: _projects.length,
                  itemBuilder: (context, index) {
                    return _ProjectCard(
                      project: _projects[index],
                      titleFont: titleFontSize,
                      descFont: descriptionFontSize,
                      tagFont: tagsFontSize,
                      textColor: textColor,
                      titleColor: titleColor,
                      cardColor: cardColor,
                      maxlines: isCompact ? 1 : 3,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- THE INTERACTIVE, STYLED PROJECT CARD ---
class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final double titleFont;
  final double descFont;
  final double tagFont;
  final Color textColor;
  final Color titleColor;
  final Color cardColor;
  final int maxlines;

  const _ProjectCard({
    required this.project,
    required this.titleFont,
    required this.descFont,
    required this.tagFont,
    required this.textColor,
    required this.titleColor,
    required this.cardColor,
    required this.maxlines,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = widget.project['isAvailable'] as bool;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        decoration: BoxDecoration(
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.portfolioPurple.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: widget.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.portfolioPurple, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.folder_open_outlined,
                        size: 20,
                        color: AppColors.portfolioPurple,
                      ),
                      if (isAvailable)
                        Row(
                          children: [
                            Tooltip(
                              message: "Get on Google Play",
                              child: IconButton(
                                icon: const Icon(Icons.android),
                                iconSize: 15,
                                color: widget.textColor,
                                onPressed: () =>
                                    _launchUrl(widget.project['androidLink']),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Tooltip(
                              message: "Get on the App Store",
                              child: IconButton(
                                icon: const Icon(Icons.apple),
                                iconSize: 15,
                                color: widget.textColor,
                                onPressed: () =>
                                    _launchUrl(widget.project['iosLink']),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 05),
                  Text(
                    widget.project['title'],
                    style: GoogleFonts.poppins(
                      fontSize: widget.titleFont,
                      fontWeight: FontWeight.w500,
                      color: widget.titleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    // Use Flexible instead of Expanded
                    child: Text(
                      widget.project['desc'],
                      style: GoogleFonts.poppins(
                        color: widget.textColor,
                        height: 1.5,
                        fontSize: widget.descFont,
                      ),
                      maxLines: widget.maxlines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  // --- Bottom: Tags ---
                  Wrap(
                    spacing: 08.0,
                    runSpacing: 8.0,
                    children: (widget.project['tags'] as List<String>)
                        .map(
                          (tag) => Text(
                            tag,
                            style: GoogleFonts.poppins(
                              fontSize: widget.tagFont,
                              color: widget.textColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
