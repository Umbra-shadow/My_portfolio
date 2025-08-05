// // ignore_for_file: avoid_print
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:whisra/screens/main/login.dart';
//
// // Your project imports (make sure paths are correct)
// import '../design/color.dart'; // To navigate on session expiry
//
// /// A centralized service to handle and interpret HTTP API responses.
// /// This class standardizes error messages and actions based on status codes.
// class ApiResponseHandler {
//   // This class is not meant to be instantiated.
//   ApiResponseHandler._();
//
//   /// The primary function to process an HTTP response.
//   static bool handleResponse({
//     required http.Response response,
//     required BuildContext context,
//     VoidCallback? onSuccess,
//     String? successMessage,
//   }) {
//     if (!context.mounted) return false;
//
//     switch (response.statusCode) {
//       // --- SUCCESS CASES ---
//       case 200:
//       case 201:
//       case 202:
//       case 204:
//         if (successMessage != null && successMessage.isNotEmpty) {
//           _showSnackBar(context, successMessage, isError: false);
//         }
//         if (onSuccess != null) {
//           onSuccess();
//         }
//         return true;
//
//       // --- CLIENT ERROR CASES ---
//       case 400:
//         _showSnackBar(
//           context,
//           _getErrorMessage(
//             response,
//             "Invalid data provided. Please check your input.",
//           ),
//           isError: true,
//         );
//         return false;
//
//       case 401:
//       case 403:
//         _showSnackBar(
//           context,
//           "Your session has expired or you don't have permission. Please log in again.",
//           isError: true,
//         );
//         _navigateToLogin(context);
//         return false;
//
//       case 404:
//         _showSnackBar(
//           context,
//           _getErrorMessage(
//             response,
//             "The requested resource could not be found.",
//           ),
//           isError: true,
//         );
//         return false;
//
//       case 409:
//         _showSnackBar(
//           context,
//           _getErrorMessage(
//             response,
//             "This item already exists or conflicts with current data.",
//           ),
//           isError: true,
//         );
//         return false;
//
//       case 429:
//         _showSnackBar(
//           context,
//           "You are making too many requests. Please wait a moment and try again.",
//           isError: true,
//         );
//         return false;
//
//       // --- SERVER ERROR CASES ---
//       case 500:
//       case 502:
//       case 503:
//         _showSnackBar(
//           context,
//           "We're having some trouble on our end. Please try again in a little while.",
//           isError: true,
//         );
//         return false;
//
//       // --- DEFAULT CASE ---
//       default:
//         _showSnackBar(
//           context,
//           "An unexpected error occurred (Code: ${response.statusCode}).",
//           isError: true,
//         );
//         return false;
//     }
//   }
//
//   /// A specific handler for exceptions (like network errors) that happen
//   /// *before* a response is even received.
//   static void handleException(BuildContext context, Object e) {
//     if (!context.mounted) return;
//
//     String errorMessage;
//     if (e is SocketException) {
//       errorMessage =
//           'Could not connect. Please check your internet connection and try again.';
//     } else if (e is FormatException) {
//       errorMessage =
//           'A response from the server could not be understood. Please try again later.';
//     } else {
//       errorMessage = 'An unexpected error occurred. Please try again.';
//     }
//
//     // === THIS IS THE CORRECTION ===
//     // We now call the single, correct _showSnackBar function.
//     _showSnackBar(context, errorMessage, isError: true);
//
//     print("API Handler Caught Exception: $e");
//   }
//
//   /// A private helper to safely parse an error message from a JSON response body.
//   static String _getErrorMessage(
//     http.Response response,
//     String defaultMessage,
//   ) {
//     try {
//       final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
//       if (decodedBody.containsKey('detail')) return decodedBody['detail'];
//       if (decodedBody.containsKey('message')) return decodedBody['message'];
//       if (decodedBody.containsKey('error')) return decodedBody['error'];
//       if (decodedBody.values.isNotEmpty) {
//         final firstValue = decodedBody.values.first;
//         if (firstValue is List && firstValue.isNotEmpty) {
//           return firstValue.first.toString();
//         } else {
//           return firstValue.toString();
//         }
//       }
//       return defaultMessage;
//     } catch (_) {
//       return defaultMessage;
//     }
//   }
//
//   /// Navigates the user to the LoginPage and removes all previous routes.
//   static void _navigateToLogin(BuildContext context) {
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => const LoginScreen()),
//       (route) => false,
//     );
//   }
//
//   /// A private helper to show a consistently styled SnackBar.
//   static void _showSnackBar(
//     BuildContext context,
//     String message, {
//     required bool isError,
//   }) {
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message, style: GoogleFonts.poppins()),
//         backgroundColor: isError ? AppColors.error : AppColors.mainColor1,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }
// }
