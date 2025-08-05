// lib/utils/reusable/dropdown.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart';

abstract class Dropdownable {
  String get displayName;
}

class StringDropdownItem implements Dropdownable {
  final String value;

  StringDropdownItem(this.value);

  @override
  String get displayName => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringDropdownItem &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

class CustomDropdown<T extends Dropdownable> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final IconData? icon;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.icon,
    this.hintText = "Select an option",
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedValue,
      items:
          items.map((T value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(
                value.displayName,
                style: GoogleFonts.poppins(color: AppColors.textSecondaryWhite),
              ),
            );
          }).toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: AppColors.textSecondaryWhite),
        prefixIcon:
            icon != null
                ? Icon(icon, color: AppColors.textSecondaryWhite)
                : null,
        filled: true,
        fillColor: AppColors.cardDark.withOpacity(0.05),
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderMuted, width: 1),
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
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
      ),

      dropdownColor: AppColors.backgroundCream,
      style: GoogleFonts.poppins(
        color: AppColors.textPrimaryWhite,
        fontSize: 16,
      ),
      hint: Text(
        hintText,
        style: GoogleFonts.poppins(
          color: AppColors.textSecondaryWhite,
          fontSize: 16,
        ),
      ),
      icon: const Icon(
        CupertinoIcons.chevron_down,
        color: AppColors.textSecondaryWhite,
        size: 12,
      ),
    );
  }
}
