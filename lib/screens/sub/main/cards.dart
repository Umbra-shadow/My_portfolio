import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A generic styled card to be reused by each content widget
class ContentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String contentText;

  const ContentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 48),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            contentText,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class TabletHomeContent extends StatelessWidget {
  const TabletHomeContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.home, size: 80, color: Colors.deepPurple),
    );
  }
}

class TabletAboutContent extends StatelessWidget {
  const TabletAboutContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.person, size: 80, color: Colors.teal),
    );
  }
}

class TabletSkillsContent extends StatelessWidget {
  const TabletSkillsContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.star, size: 80, color: Colors.orange),
    );
  }
}

class TabletProjectsContent extends StatelessWidget {
  const TabletProjectsContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.apps, size: 80, color: Colors.blueAccent),
    );
  }
}

class TabletContactContent extends StatelessWidget {
  const TabletContactContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.phone_android, size: 80, color: Colors.redAccent),
    );
  }
}
