import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../umbra_utils/design/color.dart';

// --- DATA MODELS (for clean code) ---
class Project {
  final String title;
  final String role;
  final List<String> duties;
  const Project({
    required this.title,
    required this.role,
    required this.duties,
  });
}

// --- MAIN RESUME SCREEN WIDGET ---
class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  static const List<Project> _projects = [
    Project(
      title: "IdeaNest",
      role: "Full-Stack Mobile App",
      duties: [
        "Developed a cross-platform Flutter app for capturing and organizing project ideas with status tracking.",
        "Integrated Django REST API for user authentication, note-taking, and idea syncing.",
        "Designed modern UI to encourage creativity and fast editing.",
      ],
    ),
    Project(
      title: "Zura",
      role: "Emergency Communication Platform",
      duties: [
        "Created a fast-access emergency alert app for users to report issues in one tap to designated services.",
        "Implemented location-aware alerts and categorized contacts for medical, IT, or support teams.",
        "Designed for speed and clarity with offline caching and secure syncing.",
      ],
    ),
    Project(
      title: "Skora",
      role: "School-Based Alert System",
      duties: [
        "Built a dedicated version of Zura for internal school use, enabling students or staff to alert departments quickly.",
        "Supported alert routing to medical, IT, or admin staff while minimizing classroom disruption.",
      ],
    ),
    Project(
      title: "Apodeo",
      role: "Multi-App Integration & Sync System",
      duties: [
        "Developed a Django-based admin system to manage and connect multiple Flutter apps across isolated databases.",
        "Enabled real-time updates, cross-app messaging, and webhook integration for efficient communication.",
      ],
    ),
    Project(
      title: "Govonic",
      role: "Government Coordination Platform",
      duties: [
        "Focused on emergency response for government institutions with geolocation, alerts, and internal comms.",
        "Built with scalable architecture to support different departments and agencies securely.",
      ],
    ),
    Project(
      title: "Recurex",
      role: "Centralized Hospital Data System",
      duties: [
        "Built a secure, role-based system for hospitals to access patient records, sync medical history, and register visits.",
        "Doctors, nurses, and hospitals share data, while patients can privately view their personal records.",
      ],
    ),
    Project(
      title: "Whisra",
      role: "Poetic Expression Platform",
      duties: [
        "Anonymous poem-sharing app with music playback for emotional immersion.",
        "Users can write, attach songs, and loop playback to enhance expression, while only authors can edit their work.",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // List of all sections for easy animation and ordering
    final sections = [
      _buildHeader(context),
      const _ResumeSection(
        title: "Summary",
        child: Text(
          "Driven and self-motivated Software Engineering student with a proven ability to build full-stack mobile applications from concept to deployment. Passionate about creating clean, efficient code and user-centric designs. Seeking an internship or entry-level role to apply my skills in a professional environment.",
        ),
      ),
      const _ResumeSection(
        title: "Education",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bachelor of Science in Software Engineering",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryWhite,
                  ),
                ),
                Text(
                  "Expected: Dec 2027",
                  style: TextStyle(color: AppColors.textSecondaryWhite),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "United States International University - Africa, Nairobi, Kenya",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondaryWhite,
              ),
            ),
            SizedBox(height: 8),
            _BulletPoint(
              text:
                  "Relevant Coursework: Data Structures & Algorithms, Software Architecture, Database Systems, Mobile Development.",
            ),
          ],
        ),
      ),
      const _ResumeSection(title: "Skills", child: _SkillsGrid()),
      _ResumeSection(
        title: "Projects",
        child: Column(
          children: _projects.map((p) => _ProjectEntry(project: p)).toList(),
        ),
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Stagger the animation of each section
              children: sections
                  .animate(interval: 100.ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Balingene Dan",
          style: GoogleFonts.poppins(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryWhite,
          ),
        ),
        const SizedBox(height: 8),
        _ContactInfoBar(),
        const Divider(
          height: 40,
          thickness: 2,
          color: AppColors.portfolioPurple,
        ),
      ],
    );
  }
}

// --- REUSABLE SUB-WIDGETS ---

class _ResumeSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _ResumeSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.portfolioPurple,
            ),
          ),
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: const TextStyle(
              color: AppColors.textSecondaryWhite,
              height: 1.6,
              fontSize: 15,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _ContactInfoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 4.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _ClickableContact(
          label: "balingenensiidan@gmail.com",
          url: "mailto:balingenensiidan@gmail.com",
        ),
        const Text("•", style: TextStyle(color: AppColors.textSecondaryWhite)),
        _ClickableContact(
          label: "Portfolio",
          url: "YOUR_PORTFOLIO_LINK_HERE",
        ), // Replace with your portfolio link
        const Text("•", style: TextStyle(color: AppColors.textSecondaryWhite)),
        _ClickableContact(
          label: "LinkedIn",
          url: "https://www.linkedin.com/in/dan-balingene-802100326",
        ),
        const Text("•", style: TextStyle(color: AppColors.textSecondaryWhite)),
        _ClickableContact(
          label: "GitHub",
          url: "https://github.com/Umbra-shadow",
        ),
      ],
    );
  }
}

class _ClickableContact extends StatelessWidget {
  final String label;
  final String url;
  const _ClickableContact({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.portfolioPurple,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.portfolioPurple,
        ),
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  const _SkillsGrid();

  @override
  Widget build(BuildContext context) {
    final skills = [
      {"title": "Languages", "content": "Dart, Python, SQL"},
      {
        "title": "Frameworks",
        "content": "Flutter, Django, Django REST Framework",
      },
      {
        "title": "Tools & Concepts",
        "content": "Git, GitHub, REST APIs, App Architecture",
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: skills
                .map(
                  (s) =>
                      _SkillPillar(title: s["title"]!, content: s["content"]!),
                )
                .toList(),
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: skills
              .map(
                (s) => Expanded(
                  child: _SkillPillar(
                    title: s["title"]!,
                    content: s["content"]!,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _SkillPillar extends StatelessWidget {
  final String title;
  final String content;
  const _SkillPillar({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryWhite,
            ),
          ),
          const SizedBox(height: 4),
          Text(content),
        ],
      ),
    );
  }
}

class _ProjectEntry extends StatelessWidget {
  final Project project;
  const _ProjectEntry({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                project.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryWhite,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                project.role,
                style: const TextStyle(color: AppColors.textSecondaryWhite),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final duty in project.duties) _BulletPoint(text: duty),
        ],
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0, left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: AppColors.portfolioPurple)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
