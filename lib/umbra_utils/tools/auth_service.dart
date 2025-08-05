// // lib/utils/services/auth_service.dart
//
// // ignore_for_file: unrelated_type_equality_checks, avoid_print
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:local_auth/local_auth.dart';
//
// /// A centralized service to handle authentication-related logic,
// /// including internet checks, biometrics, and secure credential storage.
// class AuthService {
//   // Use the Singleton pattern to ensure only one instance of this service exists.
//   static final AuthService _instance = AuthService._internal();
//   factory AuthService() => _instance;
//   AuthService._internal();
//
//   // Initialize the necessary package plugins.
//   final _secureStorage = const FlutterSecureStorage();
//   final _localAuth = LocalAuthentication();
//
//   // Define constant keys for storing credentials to avoid typos.
//   static const _emailKey = 'biometric_email';
//   static const _passwordKey = 'biometric_password';
//
//   /// Checks if the device has an active internet connection (Wi-Fi or mobile data).
//   Future<bool> hasInternetConnection() async {
//     final result = await Connectivity().checkConnectivity();
//
//     // === FIX: Use equality checks for the modern connectivity_plus package ===
//     // This returns true only if the connection type is mobile or wifi.
//     return result == ConnectivityResult.wifi || result == ConnectivityResult.mobile;
//   }
//
//   /// Checks if the device hardware supports biometric authentication (fingerprint/face ID).
//   Future<bool> get canUseBiometrics async {
//     try {
//       // canCheckBiometrics checks for hardware support.
//       return await _localAuth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       // This can happen on unsupported devices or emulators.
//       print("Error checking for biometrics availability: $e");
//       return false;
//     }
//   }
//
//   /// Triggers the OS's biometric authentication prompt.
//   Future<bool> authenticateWithBiometrics() async {
//     // First, confirm that biometrics are actually usable.
//     final canUse = await canUseBiometrics;
//     if (!canUse) return false;
//
//     try {
//       // Prompt the user to authenticate.
//       return await _localAuth.authenticate(
//         localizedReason: 'Please authenticate to log in to Appodeo',
//         options: const AuthenticationOptions(
//           stickyAuth: true,      // Keeps the prompt active if the app is backgrounded.
//           biometricOnly: true,   // Prevents fallback to device PIN/password.
//         ),
//       );
//     } on PlatformException catch (e) {
//       print("Error during biometric authentication attempt: $e");
//       return false;
//     }
//   }
//
//   /// Saves user's email and password securely to the device's keychain/keystore.
//   Future<void> saveCredentialsForBiometrics(String email, String password) async {
//     await _secureStorage.write(key: _emailKey, value: email);
//     await _secureStorage.write(key: _passwordKey, value: password);
//     print("Credentials saved for biometric login.");
//   }
//
//   /// Retrieves saved credentials from secure storage.
//   /// Returns a map with 'email' and 'password', or null if none are found.
//   Future<Map<String, String>?> getSavedCredentials() async {
//     final email = await _secureStorage.read(key: _emailKey);
//     final password = await _secureStorage.read(key: _passwordKey);
//
//     if (email != null && password != null) {
//       return {'email': email, 'password': password};
//     }
//     return null;
//   }
//
//   /// Deletes all saved credentials. Should be called on logout.
//   Future<void> deleteSavedCredentials() async {
//     await _secureStorage.deleteAll();
//     print("Biometric credentials deleted.");
//   }
// }
