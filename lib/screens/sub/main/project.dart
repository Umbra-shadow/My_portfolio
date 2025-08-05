import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../umbra_utils/design/color.dart';
import '../../../umbra_utils/reusable/pText.dart'; // Assuming PText is in this path

class ProjectsContent extends StatelessWidget {
  final bool isTablet;
  const ProjectsContent({super.key, required this.isTablet});

  static const double _smallScreenBreakpoint = 768.0;
  static const double _desktopHeadingFontSize = 28.0;
  static const double _mobileHeadingFontSize = 24.0;
  static const double _cardSpacing = 20.0;
  static const double _desktopPadding = 40.0;
  static const double _mobilePadding = 20.0;

  // Structured data for the projects
  static final List<Map<String, dynamic>> _projects = [
    {
      'title': 'E-commerce App',
      'description':
          'A multi-vendor e-commerce platform built with Flutter. Features include user authentication, product listings, a shopping cart, and a secure payment gateway.',
      'techStack': ['Flutter', 'Dart', 'Firebase'],
      'icon': Icons.shopping_cart,
    },
    {
      'title': 'Fitness Tracker',
      'description':
          'An app to track daily workouts and monitor progress. It includes features like a workout log, calorie counter, and goal-setting tools.',
      'techStack': ['Flutter', 'Python', 'Django'],
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Social Media Platform',
      'description':
          'A mobile-first social platform for sharing photos and interacting with friends. Implemented features like a user feed, direct messaging, and push notifications.',
      'techStack': ['Flutter', 'Dart', 'Node.js', 'Express'],
      'icon': Icons.group,
    },
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
                "04. My Projects",
                style: GoogleFonts.robotoMono(
                  fontSize: headingFontSize,
                  color: AppColors.lightestSlate,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // Use a Wrap widget for desktop/wide screens and a Column for mobile
              isMobile
                  ? Column(
                      children: _projects
                          .map(
                            (project) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: _cardSpacing,
                              ),
                              child: _ProjectCard(project: project),
                            ),
                          )
                          .toList(),
                    )
                  : Wrap(
                      spacing: _cardSpacing,
                      runSpacing: _cardSpacing,
                      children: _projects
                          .map(
                            (project) => _ProjectCard(
                              project: project,
                              width:
                                  (constraints.maxWidth -
                                      horizontalPadding * 2 -
                                      _cardSpacing) /
                                  2,
                            ),
                          )
                          .toList(),
                    ),
            ],
          ),
        );
      },
    );
  }
}

/// A private, reusable widget to display a single project card.
class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, this.width});

  final Map<String, dynamic> project;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Card(
        color: AppColors.lightNavy,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    project['icon'] as IconData,
                    size: 40,
                    color: AppColors.primaryIndigo,
                  ),
                  const Icon(
                    Icons.folder_open,
                    size: 40,
                    color: AppColors.primaryIndigo,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PText(
                project['title'] as String,
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightestSlate,
                ),
              ),
              const SizedBox(height: 10),
              PText(
                project['description'] as String,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.slate,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Display technology tags
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: (project['techStack'] as List<String>)
                    .map(
                      (tech) => PText(
                        tech,
                        style: GoogleFonts.robotoMono(
                          fontSize: 12,
                          color: AppColors.lightSlate,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
