// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart';

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const FormButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 0),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(380, 50),
          backgroundColor: AppColors.textPrimaryBlack.withOpacity(0.65),
          disabledBackgroundColor: AppColors.mainColor1Dark.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(
                    color: AppColors.textPrimaryWhite,
                    strokeWidth: 3.0,
                  ),
                )
                : Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: AppColors.textPrimaryWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  final String? semanticLabel;

  const SignButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          height: 64,
          width: 64,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderMuted, width: 1.5),
          ),
          child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

class BackButtonApp extends StatelessWidget {
  const BackButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimaryWhite),
      ),
    );
  }
}
