// lib/utils/reusable/chip.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart';

class FilterChips extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChips({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textPrimaryBlack : AppColors.cardGlass,
          borderRadius: BorderRadius.circular(25),
          border: isSelected ? null : Border.all(color: AppColors.borderLight),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color:
                isSelected
                    ? AppColors.textPrimaryWhite
                    : AppColors.textSecondaryBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class CustomChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.textPrimaryBlack.withOpacity(0.5)
                  : AppColors.cardGlass,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color:
                isSelected
                    ? AppColors.textPrimaryWhite
                    : AppColors.textPrimaryBlack,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class MoodFilterChips extends StatelessWidget {
  const MoodFilterChips({
    super.key,
    required this.moods,
    required this.selectedMood,
    required this.onSelected,
  });

  final List<String> moods;
  final String selectedMood;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: moods.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final mood = moods[index];
                return CustomChoiceChip(
                  label: mood,
                  isSelected: mood == selectedMood,
                  onSelected: () => onSelected(mood),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
