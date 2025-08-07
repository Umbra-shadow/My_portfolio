import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconsDesign extends StatelessWidget {
  final String path;
  final String name;
  final VoidCallback onTap;
  const IconsDesign({
    super.key,
    required this.path,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.white54),
              ),
              elevation: 18,
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                'assets/images/$path',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              shadows: [
                const Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
