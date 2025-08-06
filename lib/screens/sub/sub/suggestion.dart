import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

import '../../../umbra_utils/design/color.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  // State variables for multi-selection
  final Map<String, Set<String>> _selectedSkills = {};
  final TextEditingController _reasonController = TextEditingController();

  // Your skills data remains the same
  final List<Map<String, dynamic>> _itSkillsWithRationales = const [
    {
      'category': 'Programming & Development',
      'icon': Icons.code,
      'skills': ['Dart', 'Python', 'Rust', 'Go', 'JavaScript/TypeScript'],
    },
    {
      'category': 'Mobile Development',
      'icon': Icons.phone_android_rounded,
      'skills': [
        'Flutter',
        'State Management (Bloc, Provider)',
        'Native iOS (Swift)',
        'Native Android (Kotlin)',
      ],
    },
    {
      'category': 'Web Frameworks',
      'icon': Icons.public,
      'skills': ['Django', 'FastAPI', 'Node.js (Express)', 'React', 'Svelte'],
    },
    {
      'category': 'Cloud & DevOps',
      'icon': Icons.cloud_queue_rounded,
      'skills': [
        'Docker',
        'Kubernetes (K8s)',
        'AWS',
        'Google Cloud Platform (GCP)',
        'Terraform',
        'GitHub Actions (CI/CD)',
      ],
    },
    {
      'category': 'Databases & Data Management',
      'icon': Icons.storage_rounded,
      'skills': [
        'PostgreSQL (SQL)',
        'MySQL',
        'MongoDB (NoSQL)',
        'Redis',
        'Firebase Realtime Database',
      ],
    },
    {
      'category': 'APIs & Protocols',
      'icon': Icons.sync_alt_rounded,
      'skills': ['RESTful APIs', 'GraphQL', 'gRPC', 'WebSockets'],
    },
    {
      'category': 'Cybersecurity',
      'icon': Icons.security_rounded,
      'skills': [
        'Penetration Testing',
        'Network Security',
        'Cryptography',
        'OWASP Top 10',
        'Identity & Access Management (IAM)',
      ],
    },
    {
      'category': 'Software Architecture & Design',
      'icon': Icons.architecture_rounded,
      'skills': [
        'Microservices',
        'Domain-Driven Design (DDD)',
        'SOLID Principles',
        'System Design',
        'Design Patterns',
      ],
    },
    {
      'category': 'Testing & Quality Assurance',
      'icon': Icons.rule_rounded,
      'skills': [
        'Unit Testing',
        'Integration Testing',
        'End-to-End (E2E) Testing',
        'Pytest',
        'Flutter Test',
      ],
    },
    {
      'category': 'AI & Machine Learning',
      'icon': Icons.psychology_alt_rounded,
      'skills': [
        'TensorFlow',
        'PyTorch',
        'Scikit-learn',
        'Natural Language Processing (NLP)',
        'OpenAI API Integration',
      ],
    },
    {
      'category': 'Project Management & Collaboration',
      'icon': Icons.groups_rounded,
      'skills': [
        'Agile & Scrum Methodologies',
        'Jira',
        'Confluence',
        'Git',
        'GitHub',
      ],
    },
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _toggleSkill(String category, String skill) {
    setState(() {
      // Ensure the category entry exists
      _selectedSkills.putIfAbsent(category, () => <String>{});

      // Add or remove the skill
      if (_selectedSkills[category]!.contains(skill)) {
        _selectedSkills[category]!.remove(skill);
        // If the category becomes empty, remove it
        if (_selectedSkills[category]!.isEmpty) {
          _selectedSkills.remove(category);
        }
      } else {
        _selectedSkills[category]!.add(skill);
      }
    });
  }

  Future<void> _submitSuggestion() async {
    final hasSkills = _selectedSkills.values.any((skills) => skills.isNotEmpty);

    if (!hasSkills || _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select at least one skill and provide a reason.",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // --- Construct the email body ---
    final buffer = StringBuffer();
    buffer.writeln("Hello,");
    buffer.writeln("\nHere are some skill suggestions for your portfolio:");

    _selectedSkills.forEach((category, skills) {
      if (skills.isNotEmpty) {
        buffer.writeln("\n-- $category --");
        for (var skill in skills) {
          buffer.writeln("- $skill");
        }
      }
    });

    buffer.writeln("\n-- Reason --");
    buffer.writeln(_reasonController.text);
    buffer.writeln("\nBest regards,");
    buffer.writeln("A visitor of your portfolio");

    // --- Create and launch the mailto URI ---
    final Uri mailtoUri = Uri(
      scheme: 'mailto',
      path:
          'your.email@example.com', // <-- IMPORTANT: CHANGE THIS TO YOUR EMAIL
      query:
          'subject=${Uri.encodeComponent('Skill Suggestion for Your Portfolio')}&body=${Uri.encodeComponent(buffer.toString())}',
    );

    if (await canLaunchUrl(mailtoUri)) {
      await launchUrl(mailtoUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Could not launch email app. Please send your suggestion manually.",
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasSelections = _selectedSkills.values.any((s) => s.isNotEmpty);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER ---
              Text(
                "Suggest a Skill",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: AppColors.textPrimaryBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Help me grow by suggesting skills you think are important. You can select multiple!",
                style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryBlack,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // --- YOUR SELECTIONS SUMMARY ---
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SizeTransition(sizeFactor: animation, child: child),
                ),
                child: hasSelections
                    ? _SelectedSkillsSummary(
                        selectedSkills: _selectedSkills,
                        onSkillRemoved: _toggleSkill,
                      )
                    : const SizedBox.shrink(),
              ),

              // --- SKILL CATEGORIES & SKILLS LIST ---
              Text(
                "1. Select Skills by Category",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryBlack,
                ),
              ),
              const SizedBox(height: 15),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _itSkillsWithRationales.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final categoryData = _itSkillsWithRationales[index];
                  final categoryName = categoryData['category'] as String;
                  final skills = categoryData['skills'] as List<String>;
                  final icon = categoryData['icon'] as IconData;
                  final selectedSkillsForCategory =
                      _selectedSkills[categoryName] ?? <String>{};

                  return _SkillExpansionTile(
                    category: categoryName,
                    icon: icon,
                    skills: skills,
                    selectedSkillsForCategory: selectedSkillsForCategory,
                    onSkillToggled: (skill) =>
                        _toggleSkill(categoryName, skill),
                  );
                },
              ),
              const SizedBox(height: 40),

              // --- REASON & SUBMIT ---
              Text(
                "2. Why are these skills important?",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryBlack,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _reasonController,
                maxLines: 4,
                style: GoogleFonts.poppins(color: AppColors.textPrimaryBlack),
                decoration: InputDecoration(
                  hintText: 'Your reasoning...',
                  border: const OutlineInputBorder(),
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.textSecondaryBlack.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submitSuggestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.portfolioPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Submit Suggestion via Email"),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
        ),
      ),
    );
  }
}

// --- NEW & REFACTORED WIDGETS ---

class _SelectedSkillsSummary extends StatelessWidget {
  final Map<String, Set<String>> selectedSkills;
  final Function(String category, String skill) onSkillRemoved;

  const _SelectedSkillsSummary({
    required this.selectedSkills,
    required this.onSkillRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('summary'),
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.portfolioPurple.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Selections",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: selectedSkills.entries.expand((entry) {
              final category = entry.key;
              final skills = entry.value;
              return skills.map((skill) {
                return Chip(
                  label: Text(
                    skill,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: AppColors.portfolioPurple,
                  onDeleted: () => onSkillRemoved(category, skill),
                  deleteIcon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 18,
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillExpansionTile extends StatelessWidget {
  final String category;
  final IconData icon;
  final List<String> skills;
  final Set<String> selectedSkillsForCategory;
  final ValueChanged<String> onSkillToggled;

  const _SkillExpansionTile({
    required this.category,
    required this.icon,
    required this.skills,
    required this.selectedSkillsForCategory,
    required this.onSkillToggled,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedBackgroundColor: AppColors.cardMuted.withOpacity(0.5),
          backgroundColor: AppColors.cardMuted.withOpacity(0.7),
          leading: Icon(icon, color: AppColors.textPrimaryBlack),
          title: Text(
            category,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryBlack,
            ),
          ),
          trailing: selectedSkillsForCategory.isEmpty
              ? const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondaryBlack,
                )
              : CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.portfolioPurple,
                  child: Text(
                    selectedSkillsForCategory.length.toString(),
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: skills.map((skill) {
                  final isSelected = selectedSkillsForCategory.contains(skill);
                  return FilterChip(
                    label: Text(
                      skill,
                      style: GoogleFonts.poppins(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimaryBlack,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) => onSkillToggled(skill),
                    selectedColor: AppColors.portfolioPurple,
                    checkmarkColor: Colors.white,
                    backgroundColor: AppColors.cardMuted.withOpacity(0.8),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.portfolioPurple
                            : AppColors.cardMuted,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
