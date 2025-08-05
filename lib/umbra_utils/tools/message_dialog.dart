// lib/utils/reusable/message_dialogs.dart

// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart';

enum DialogType { success, error }

class MessageDialogs {
  // This class is not meant to be instantiated.
  MessageDialogs._();

  /// Shows a success dialog overlay.
  static void showSuccess({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    _showCustomDialog(
      context: context,
      title: title,
      message: message,
      type: DialogType.success,
    );
  }

  /// Shows an error dialog overlay.
  static void showError({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    _showCustomDialog(
      context: context,
      title: title,
      message: message,
      type: DialogType.error,
    );
  }

  // The private helper function that builds and displays the dialog.
  static void _showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    required DialogType type,
  }) {
    // Determine colors and icon based on the dialog type
    final Color iconColor =
        type == DialogType.success ? AppColors.success : AppColors.error;
    final IconData iconData =
        type == DialogType.success
            ? CupertinoIcons.checkmark_shield_fill
            : CupertinoIcons.xmark_shield_fill;

    showDialog(
      context: context,
      // Use a transparent barrier to see the blur effect
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext dialogContext) {
        // === FIX: The unsafe Future.delayed timer has been removed from here. ===
        // The responsibility for auto-closing is now handled inside _MessageDialogContent.

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            // Make the default dialog background transparent
            elevation: 0,
            child: _MessageDialogContent(
              title: title,
              message: message,
              iconColor: iconColor,
              iconData: iconData,
            ),
          ),
        );
      },
    );
  }
}

// A private widget for the animated content of the dialog.
class _MessageDialogContent extends StatefulWidget {
  final String title;
  final String message;
  final Color iconColor;
  final IconData iconData;

  const _MessageDialogContent({
    required this.title,
    required this.message,
    required this.iconColor,
    required this.iconData,
  });

  @override
  State<_MessageDialogContent> createState() => _MessageDialogContentState();
}

class _MessageDialogContentState extends State<_MessageDialogContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut, // A bouncy, satisfying animation
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: AppColors.cardGlass,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The big icon
              Icon(widget.iconData, color: widget.iconColor, size: 80),
              const SizedBox(height: 24),
              // The title
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimaryWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // The message
              Text(
                widget.message,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimaryWhite,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
