import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'umbra_utils/design/color.dart';

class NavButton extends StatelessWidget {
  final String text;
  final String number;
  final bool isSelected;
  final VoidCallback onPressed;

  const NavButton({
    super.key,
    required this.text,
    required this.number,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? AppColors.portfolioPurple
        : AppColors.lightestSlate;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Row(
        children: [
          Text(
            number,
            style: GoogleFonts.poppins(
              color: AppColors.portfolioPurple,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          Text(text, style: GoogleFonts.poppins(color: color, fontSize: 13)),
        ],
      ),
    );
  }
}

// Button for the bottom bar inside the tablet
class NavBarButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const NavBarButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isSelected
              ? AppColors.darkNavy.withOpacity(0.5)
              : Colors.transparent,
          foregroundColor: isSelected
              ? Colors.white
              : AppColors.textSecondaryWhite,
          shape: RoundedRectangleBorder(),
          padding: const EdgeInsets.all(30),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: isSelected ? 25 : 18,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class PText extends StatelessWidget {
  const PText(this.text, {super.key, this.style, this.textAlign});

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.poppins().merge(style),
    );
  }
}
