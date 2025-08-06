import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/umbra_utils/design/color.dart';
import 'package:myportfolio/umbra_utils/design/poem_text.dart';
import 'package:url_launcher/url_launcher.dart';

class PoemScreen extends StatefulWidget {
  const PoemScreen({super.key});

  @override
  State<PoemScreen> createState() => _PoemScreenState();
}

class _PoemScreenState extends State<PoemScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start with a random poem when the screen first loads.
    _currentIndex = Random().nextInt(poems.length);
  }

  void _shufflePoem() {
    int newIndex;
    // Ensure the new poem is different from the current one, if possible.
    if (poems.length > 1) {
      do {
        newIndex = Random().nextInt(poems.length);
      } while (newIndex == _currentIndex);
    } else {
      newIndex = 0;
    }
    setState(() {
      _currentIndex = newIndex;
    });
  }

  Future<void> _playMusic() async {
    final uri = Uri.parse(poems[_currentIndex].musicUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not play song.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // This provides the currently selected poem.
    final AppPoems currentPoem = poems[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // --- HEADER SECTION ---
                _PoemHeader(
                  title: currentPoem.title,
                  onShuffle: _shufflePoem,
                  onPlayMusic: _playMusic,
                ),

                const SizedBox(height: 20),
                const _DecorativeLine(),
                const SizedBox(height: 30),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: Text(
                    currentPoem.poem,
                    key: ValueKey<String>(currentPoem.title),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.breeSerif(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryBlack,
                      height: 1.8,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const _DecorativeLine(),
                const SizedBox(height: 20),
                Text(
                  '~~ Balingene Dan ~~',
                  style: GoogleFonts.pacifico(
                    fontSize: 18,
                    color: AppColors.textSecondaryBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PoemHeader extends StatelessWidget {
  final String title;
  final VoidCallback onShuffle;
  final VoidCallback onPlayMusic;

  const _PoemHeader({
    required this.title,
    required this.onShuffle,
    required this.onPlayMusic,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 500;
            if (isWide) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildTitle(), _buildButtons()],
              );
            } else {
              return Column(
                children: [
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildButtons(),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimaryBlack,
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: "Show another poem",
          child: IconButton(
            onPressed: onShuffle,
            icon: const Icon(
              CupertinoIcons.shuffle,
              color: AppColors.textSecondaryBlack,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Tooltip(
          message: "Play inspired song on Spotify",
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dashboardGreen,
              foregroundColor: AppColors.textPrimaryBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: onPlayMusic,
            icon: const Icon(Icons.music_note, size: 18, color: Colors.white),
            label: Text(
              'Play Song',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DecorativeLine extends StatelessWidget {
  const _DecorativeLine();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      width: 120,
      child: CustomPaint(painter: _LinePainter()),
    );
  }
}

// A custom painter for the elegant separator lines.
class _LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textSecondaryBlack.withOpacity(0.3)
      ..strokeWidth = 1.0;

    // Draw a simple line with dots at the end
    canvas.drawLine(
      Offset(10, size.height / 2),
      Offset(size.width - 10, size.height / 2),
      paint,
    );
    canvas.drawCircle(Offset(5, size.height / 2), 2, paint);
    canvas.drawCircle(Offset(size.width - 5, size.height / 2), 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
