// lib/utils/reusable/tile.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Your project imports (placeholder AppColors is included below)
import '../design/color.dart';

class ManagementListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final IconData? icon;
  final bool isExpanded;
  final VoidCallback onExpand;

  // Optional parameters for custom action labels
  final String editText;
  final String deleteText;

  const ManagementListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onEdit,
    required this.onDelete,
    this.icon,
    required this.isExpanded,
    required this.onExpand,
    this.editText = "Edit",
    this.deleteText = "Delete",
  });

  @override
  Widget build(BuildContext context) {
    // --- THIS IS THE CORRECTED WIDGET, RESTORING YOUR DESIGN ---
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.05),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardLightSoft.withOpacity(0.1),
      clipBehavior: Clip.antiAlias, // Ensures content respects the rounded corners
      child: InkWell(
        onTap: onExpand,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  // Icon is now correctly placed to the side
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(icon, color: AppColors.dashboardGreen, size: 24),
                    ),
                  // Main text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: AppColors.textPrimaryWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (subtitle.isNotEmpty)
                          Text(
                            subtitle,
                            style: GoogleFonts.poppins(
                              color: AppColors.textSecondaryWhite,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // The expand/collapse icon
                  Icon(
                    isExpanded ? CupertinoIcons.chevron_up : CupertinoIcons.chevron_down,
                    color: AppColors.textSecondaryWhite,
                    size: 20,
                  ),
                ],
              ),
              // --- The Animated, Collapsible Action Row ---
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  height: isExpanded ? null : 0,
                  child: isExpanded
                      ? _ActionRow(
                    onEdit: onEdit,
                    onDelete: onDelete,
                    editText: editText,
                    deleteText: deleteText,
                  )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper for the action buttons
class _ActionRow extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String editText;
  final String deleteText;

  const _ActionRow({
    required this.onEdit,
    required this.onDelete,
    required this.editText,
    required this.deleteText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: AppColors.borderMuted.withOpacity(0.5), height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: onEdit,
              icon: const Icon(CupertinoIcons.pen, size: 18),
              label: Text(editText),
              style: TextButton.styleFrom(foregroundColor: AppColors.textSecondaryWhite),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: onDelete,
              icon: const Icon(CupertinoIcons.delete, size: 18),
              label: Text(deleteText),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
            ),
          ],
        ),
      ],
    );
  }
}
