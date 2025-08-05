import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart';

// Okay, this is my standard, reusable text input field.
class FormBox extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final FormFieldValidator<String>? validator;
  // --- Allow maxLines to be nullable ---
  final int? maxLines;
  final int? minLines;

  const FormBox({
    super.key,
    required this.controller,
    required this.text,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.validator,
    this.maxLines = 1, // Default to a single line
    this.minLines,
  });

  @override
  State<FormBox> createState() => _FormBoxState();
}

class _FormBoxState extends State<FormBox> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // --- FIX: Removed the fixed-size SizedBox wrapper ---
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      // --- FIX: Simplified null-aware assignment ---
      // If widget.maxLines is null, it uses the default of 1 from the constructor.
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      minLines: widget.minLines, // Can be null
      cursorColor: AppColors.textPrimaryBlack,
      style: GoogleFonts.poppins(color: AppColors.textSecondaryBlack),
      decoration: InputDecoration(
        // Use labelText for a better floating label effect
        labelText: widget.text,
        labelStyle: GoogleFonts.poppins(color: AppColors.textSecondaryBlack),
        // Use hintText for placeholder text when the field is empty
        hintText: 'Enter ${widget.text.toLowerCase()}',
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textSecondaryBlack.withOpacity(0.5),
          fontSize: 14,
        ),
        filled: true,
        fillColor: AppColors.cardDark.withOpacity(0.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.borderMuted,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.textPrimaryWhite,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        prefixIcon:
            widget.prefixIcon != null
                ? Icon(
                  widget.prefixIcon,
                  color: AppColors.textSecondaryWhite,
                  size: 22,
                )
                : null,
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondaryWhite,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
                : null,
      ),
    );
  }
}

class VerificationBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  // === FIX: Added an onChanged callback parameter ===
  // This allows the parent to listen for changes without the child having any logic.
  final ValueChanged<String>? onChanged;

  const VerificationBox({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged, // Make it available in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Use SizedBox for sizing instead of Container with decoration
      height: 60,
      width: 50,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        cursorColor: AppColors.textPrimaryBlack,
        // Limit input to a single digit
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: onChanged,
        style: GoogleFonts.poppins(
          color: AppColors.textSecondaryWhite,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: AppColors.cardDark.withOpacity(0.1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.borderDark,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.textPrimaryBlack,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 2),
          ),
        ),
      ),
    );
  }
}
