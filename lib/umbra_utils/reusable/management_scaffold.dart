import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart';

class ManagementPageScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onAdd; // Make onAdd optional

  const ManagementPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppColors.textPrimaryBlack,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryBlack,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: AppColors.backgroundCream,
      ),
      floatingActionButton:
          onAdd != null
              ? FloatingActionButton(
                onPressed: onAdd,
                // --- COLOR CHANGE ---
                backgroundColor: AppColors.textPrimaryBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  CupertinoIcons.add,
                  color: AppColors.textPrimaryBlack,
                ),
              )
              : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child, // The child is the list view
        ),
      ),
    );
  }
}
