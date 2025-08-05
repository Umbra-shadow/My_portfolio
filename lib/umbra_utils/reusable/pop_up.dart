// lib/utils/reusable/pop_up.dart

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Your other project imports
import '../design/color.dart';
import 'box.dart'; // For FormBox

// --- THIS IS THE PUBLIC FUNCTION WITH THE CORRECT DEFINITION ---
Future<void> showAddMemberDialog(
  BuildContext context, {
  // THIS LINE DEFINES THE 'onJoin' PARAMETER THAT 'JoinPage' USES
  required Future<void> Function(String code) onJoin,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext dialogContext) {
      return _AddMemberDialogContent(onJoin: onJoin);
    },
  );
}

// --- PRIVATE STATEFUL WIDGET TO MANAGE DIALOG STATE ---
class _AddMemberDialogContent extends StatefulWidget {
  final Future<void> Function(String code) onJoin;

  const _AddMemberDialogContent({required this.onJoin});

  @override
  State<_AddMemberDialogContent> createState() =>
      _AddMemberDialogContentState();
}

class _AddMemberDialogContentState extends State<_AddMemberDialogContent> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _handleConnect() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() => _isLoading = true);
    try {
      await widget.onJoin(_codeController.text.trim());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: AppColors.backgroundCream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(24),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.group_solid,
                  color: AppColors.textSecondaryBlack,
                  size: 40,
                ),
                const SizedBox(height: 16),
                Text(
                  'Join a Circle',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryBlack,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter the join code you received to connect with another member.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: AppColors.textSecondaryBlack,
                  ),
                ),
                const SizedBox(height: 24),
                FormBox(
                  controller: _codeController,
                  text: "Join Code",
                  prefixIcon: CupertinoIcons.link,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a code';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textPrimaryBlack,
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimaryBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleConnect,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.textPrimaryBlack,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child:
                _isLoading
                    ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : Text(
                      'Connect',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
