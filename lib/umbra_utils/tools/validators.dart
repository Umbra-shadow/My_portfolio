// lib/utils/services/validators.dart

// A utility class containing static methods for common form field validations.
// This approach keeps validation logic consistent and reusable across the app.
class Validators {
  Validators._(); // This class is not meant to be instantiated.

  /// Validator for any field that should not be empty.
  /// [fieldName] is the user-friendly name of the field (e.g., "Project Name").
  static String? notEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty.';
    }
    return null;
  }

  /// Validator for email fields.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address cannot be empty.';
    }
    // A robust regex for email validation.
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]+$");
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  /// Validator for password fields.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    // You can add more complex rules here (e.g., requires numbers, symbols, etc.)
    // if (!value.contains(RegExp(r'[A-Z]'))) return 'Must contain an uppercase letter.';
    // if (!value.contains(RegExp(r'[0-9]'))) return 'Must contain a number.';
    return null;
  }

  /// Validator for confirming a password.
  /// Requires the controller of the original password field to compare against.
  static String? confirmPassword(String? value, String originalPassword) {
    if (value != originalPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }

  /// Validator for phone numbers.
  /// This is a simple example; you can use more complex regex for specific formats.
  static String? phone(String? value, String countryCode) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number cannot be empty.';
    }
    // Check if the number only contains the country code
    if (value.trim() == countryCode) {
      return 'Please enter the national number.';
    }
    if (value.length < 10) { // A basic length check
      return 'Phone number seems too short.';
    }
    return null;
  }
}