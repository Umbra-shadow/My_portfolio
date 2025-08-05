import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../umbra_utils/design/color.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  // State variables
  int? _selectedIndex;
  String? _selectedSkillName;
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // Your skills data
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
    _searchController.dispose();
    super.dispose();
  }

  void _submitSuggestion() {
    if (_selectedSkillName == null || _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a skill and provide a reason."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Thanks for your suggestion: '$_selectedSkillName'!"),
        backgroundColor: AppColors.portfolioPurple,
      ),
    );

    // Reset the form
    _reasonController.clear();
    _searchController.clear();
    setState(() {
      _selectedSkillName = null;
      _selectedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            bottom: 08.0,
            left: 08.0,
            right: 08.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER ---
              Text(
                "Suggest a Skill",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  color: AppColors.textPrimaryWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Help me grow by suggesting a skill you think is important.",
                style: GoogleFonts.poppins(
                  color: AppColors.textSecondaryWhite,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),

              // --- CATEGORY SELECTION ---
              Text(
                "1. Select a Category",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryWhite,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(_itSkillsWithRationales.length, (
                  index,
                ) {
                  return _SkillCategoryCard(
                    category: _itSkillsWithRationales[index]['category'],
                    icon: _itSkillsWithRationales[index]['icon'],
                    isSelected: _selectedIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _selectedSkillName = null; // Clear previous skill
                        _searchController.clear(); // Clear search field
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 40),

              // --- SKILL SELECTION (ANIMATED & IN-PAGE) ---
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      axisAlignment: -1.0,
                      child: child,
                    ),
                  );
                },
                child: _selectedIndex == null
                    ? const SizedBox.shrink() // Show nothing if no category is selected
                    : _SkillSelector(
                        key: ValueKey(
                          _selectedIndex,
                        ), // Important for rebuilding with new skills
                        skills: List<String>.from(
                          _itSkillsWithRationales[_selectedIndex!]['skills'],
                        ),
                        searchController: _searchController,
                        selectedSkillName: _selectedSkillName,
                        onSkillSelected: (skill) {
                          setState(() {
                            _selectedSkillName = skill;
                          });
                        },
                      ),
              ),

              // --- REASON & SUBMIT ---
              Text(
                "3. Why is this skill important?",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryWhite,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _reasonController,
                maxLines: 4,
                style: GoogleFonts.poppins(color: AppColors.textPrimaryWhite),
                decoration: InputDecoration(
                  labelText: 'Your reasoning...',
                  border: OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.textSecondaryWhite,
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
                  child: const Text("Submit Suggestion"),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SkillCategoryCard({
    required this.category,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.portfolioPurple.withOpacity(0.1)
              : AppColors.cardMuted,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.portfolioPurple : AppColors.cardMuted,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 36,
              color: isSelected
                  ? AppColors.portfolioPurple
                  : AppColors.textSecondaryBlack,
            ),
            const SizedBox(height: 10),
            Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.portfolioPurple
                    : AppColors.textPrimaryBlack,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillSelector extends StatefulWidget {
  final List<String> skills;
  final TextEditingController searchController;
  final String? selectedSkillName;
  final ValueChanged<String> onSkillSelected;

  const _SkillSelector({
    super.key,
    required this.skills,
    required this.searchController,
    this.selectedSkillName,
    required this.onSkillSelected,
  });

  @override
  State<_SkillSelector> createState() => _SkillSelectorState();
}

class _SkillSelectorState extends State<_SkillSelector> {
  @override
  Widget build(BuildContext context) {
    final filteredSkills = widget.skills
        .where(
          (skill) => skill.toLowerCase().contains(
            widget.searchController.text.toLowerCase(),
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2. Select a Skill",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryWhite,
          ),
        ),
        const SizedBox(height: 15),
        // Display the selected skill
        if (widget.selectedSkillName != null)
          Chip(
            label: Text(
              widget.selectedSkillName!,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppColors.portfolioPurple,
            onDeleted: () {
              widget.onSkillSelected(''); // Clear the skill
            },
            deleteIcon: const Icon(Icons.close, color: Colors.white, size: 18),
          )
        else
          Column(
            children: [
              TextField(
                controller: widget.searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  labelText: 'Search for a skill...',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.textSecondaryWhite,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cardMuted),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredSkills.length,
                  itemBuilder: (context, index) {
                    final skill = filteredSkills[index];
                    return ListTile(
                      title: Text(
                        skill,
                        style: GoogleFonts.poppins(
                          color: AppColors.textPrimaryWhite,
                        ),
                      ),
                      onTap: () => widget.onSkillSelected(skill),
                    );
                  },
                ),
              ),
            ],
          ),
        const SizedBox(height: 40),
      ],
    );
  }
}
