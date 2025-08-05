// Okay, this file holds all my functions for talking to the backend API.

import 'dart:convert';
import 'package:http/http.dart' as http;

// This is the main URL for my backend. All my API calls will start with this.
const String baseUrl = "https://skoora.onrender.com/skr/";

// =================== AUTHENTICATION ===================
// These are the functions for users who are not yet logged in.
// Notice they don't take a `token` argument.
// For these POST requests, http sends the body as 'x-www-form-urlencoded' by default.

Future<http.Response> login(String email, String password) {
  return http.post(
    Uri.parse("${baseUrl}login/"),
    body: {"email": email, "password": password},
  );
}

Future<http.Response> register(
  String username,
  String email,
  String phone,
  String country,
  String password,
  String staffCode,
  String school,
) {
  return http.post(
    Uri.parse("${baseUrl}register/"),
    body: {
      "username": username,
      "email": email,
      "phone": phone,
      "country_name": country,
      "password": password,
      "code": staffCode,
      "school_name": school,
    },
  );
}


// Sends the initial OTP for email verification after registration.
Future<http.Response> reSendPhoneOtp(String phone) {
  return http.post(
    Uri.parse("${baseUrl}phone-otp-resend/"),
    body: {"phone": phone},
  );
}

// Verifies the OTP sent to the user's email.
Future<http.Response> verifyPhoneOtp(String phoneOtp, String phone) {
  return http.post(
    Uri.parse("${baseUrl}otp-verification/"),
    body: {"phone_otp": phoneOtp, "phone": phone},
  );
}


// Verifies the OTP for the 'forgot password' flow.
Future<http.Response> forgotPassword(String email, String emailOtp) {
  return http.post(
    Uri.parse("${baseUrl}forgot-password/"),
    body: {"email": email, "email_otp": emailOtp},
  );
}

// Sends an OTP specifically for the 'forgot password' process.
Future<http.Response> sendForgotOtp(String email) {
  return http.post(
    Uri.parse("${baseUrl}forgot-otp-sending/"),
    body: {"email": email},
  );
}

// Sends an OTP specifically for the 'forgot password' process.
Future<http.Response> resendForgotOtp(String email) {
  return http.post(
    Uri.parse("${baseUrl}forgot-otp-resending/"),
    body: {"email": email},
  );
}

// After successful OTP verification, this sets the new password.
Future<http.Response> resetPassword(String email, String password) {
  return http.post(
    Uri.parse("${baseUrl}reset-password/"),
    body: {"email": email, "new_password": password},
  );
}

// =================== USER & PROFILE (Authenticated) ===================
// All functions below this point are for logged-in users and MUST include the auth token.

// Gets the current user's profile information. It's a GET request.
Future<http.Response> fetchProfile(String token) {
  return http.get(
    Uri.parse("${baseUrl}user-info/"),
    // The token is passed in the request headers to prove who I am.
    headers: {'Authorization': 'Token $token'},
  );
}

// Changes the user's password. This is a POST request.
Future<http.Response> changePassword(
  String token,
  String oldPassword,
  String newPassword,
) {
  return http.post(
    Uri.parse("${baseUrl}change-password/"),
    headers: {
      'Authorization': 'Token $token',
      // I have to specify that I'm sending JSON data.
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // The body must be encoded into a JSON string.
    body: jsonEncode({
      "old_password": oldPassword,
      "new_password": newPassword,
    }),
  );
}

// Updates the user's profile. I'm using PATCH because I might only be updating some fields, not all.
Future<http.Response> updateProfile({
  required String token,
  required String username,
  required String email,
  required String phone,
  required String country,
}) {
  return http.patch(
    Uri.parse("${baseUrl}user-info/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "username": username,
      "email": email,
      "phone": phone,
      "country": country,
    }),
  );
}

// Sends user feedback to the server.
Future<http.Response> sendUserFeedback({
  required String token,
  required String username,
  required int rating,
  required String feedback,
  required String category,
}) {
  return http.post(
    Uri.parse("${baseUrl}feedback/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "username": username,
      "rating": rating,
      "feedback": feedback,
      "category": category.isEmpty ? null : category,
    }),
  );
}

// Logs the user out. It's a POST request so the server can invalidate the token.
Future<http.Response> logout(String token) {
  return http.post(
    Uri.parse("${baseUrl}logout/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Deletes the user's account. It's a POST request so the server can invalidate the token.
Future<http.Response> deleteAccount(String token) {
  return http.delete(
    Uri.parse("${baseUrl}user-info/"),
    headers: {'Authorization': 'Token $token'},
  );
}
Future<http.Response> fetchAllUsers(String token) {
  return http.get(
    Uri.parse("${baseUrl}users/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Deletes a specific user by their ID.
Future<http.Response> deleteUser(String token, int userId) {
  return http.delete(
    Uri.parse("${baseUrl}users/$userId/"),
    headers: {'Authorization': 'Token $token'},
  );
}
Future<http.Response> updateUser({
  required String token,
  required int userId,
  required Map<String, dynamic> data, // A map containing only the fields to be changed
}) {
  return http.patch(
    Uri.parse("${baseUrl}users/$userId/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
}
// =================== make alerts =============================================

// for department : medic , security , fire-fighter
Future<http.Response> makeCallAlert({
  required String token,
  required String longitude,
  required String latitude,
  required String department,
}) {
  return http.post(
    Uri.parse("${baseUrl}make-call-alert/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // The keys here (like 'problem_statement') must exactly match what my Django API expects.
    body: jsonEncode({
      'longitude': longitude,
      'latitude': latitude,
      'department': department,
    }),
  );
}

// for department : ICT , maintenance , cleaner
Future<http.Response> makeTextAlert({
  required String token,
  required String longitude,
  required String latitude,
  required String department,
}) {
  return http.post(
    Uri.parse("${baseUrl}make-text-alert/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'longitude': longitude,
      'latitude': latitude,
      'department': department,
    }),
  );
}

// ================== join user circle ==========================================

Future<http.Response> join({
  required String token,
  required String code,
}) {
  return http.post(
    Uri.parse("${baseUrl}join/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'personal_code': code,
    }),
  );
}
Future<http.Response> fetchJoinedUsers(String token) {
  // This GET request fetches the list of users who have joined your circle.
  return http.get(
    Uri.parse("${baseUrl}join/"),
    headers: {
      'Authorization': 'Token $token',
    },
  );
}

Future<http.Response> removeJoinedUser({
  required String token,
  required int joinId, // The ID of the Join model instance
}) {
  // Note the URL targets the specific join ID
  return http.delete(
    Uri.parse("${baseUrl}join/$joinId/"),
    headers: {
      'Authorization': 'Token $token',
    },
  );
}
Future<http.Response> sendPersonalAlert({
  required String token,
  required int alertedUserId,
  required String latitude,
  required String longitude,
}) {
  return http.post(
    Uri.parse("${baseUrl}personal-alert/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'alerted_user_id': alertedUserId,
      'latitude': double.parse(latitude), // Ensure it's a number
      'longitude': double.parse(longitude), // Ensure it's a number
    }),
  );
}

// ================================= history + alert ===================================
 Future<http.Response> fetchHistory({
  required String token,
}) {
  return http.get(
    Uri.parse("${baseUrl}alerts/history/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}
Future<http.Response> fetchStaffHistory({
  required String token,
}) {
  return http.get(
    Uri.parse("${baseUrl}staff-alerts/history/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

 Future<http.Response> cancelAlert({
  required String token,
  required int alertId,
}) {
  return http.post(
    Uri.parse("${baseUrl}alerts/$alertId/cancel/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

 Future<http.Response> markDoneAlert({
  required String token,
  required int alertId,
}) {
  return http.post(
    Uri.parse("${baseUrl}alerts/$alertId/mark-done/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}
Future<http.Response> fetchDepartmentAlerts(String token) {
  return http.get(
    Uri.parse("${baseUrl}department-alerts/"),
    headers: {'Authorization': 'Token $token'},
  );
}

Future<http.Response> dismissAlert(String token, int alertId) {
  return http.post(
    Uri.parse("${baseUrl}alerts/$alertId/dismiss/"),
    headers: {'Authorization': 'Token $token'},
  );
}

Future<http.Response> deleteDismissedAlert(String token, int alertId) {
  return http.delete(
    Uri.parse("${baseUrl}alerts/$alertId/delete-dismissed/"),
    headers: {'Authorization': 'Token $token'},
  );
}
// =================== differents CRUD routes (Authenticated) ===================

// Creates a new Department.
Future<http.Response> createDepartment({
  required String token,
  required String name,
  required String description,
  required String status,
}) {
  return http.post(
    Uri.parse("${baseUrl}departments/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'name': name,
      'description': description,
      'status': status,
    }),
  );
}

// Gets the summary counts (users,building,categories,rooms.) for the home page.
Future<http.Response> fetchDasboardSummary(String token) {
  return http.get(
    Uri.parse("${baseUrl}dashboard/summary/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Gets the list of all of the user's Categories.
Future<http.Response> fetchDepartment(String token) {
  return http.get(
    Uri.parse("${baseUrl}departments/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Updates an existing Department. Using PUT because I'm replacing all the main fields.
Future<http.Response> updateDepartment({
  required String token,
  required String name,
  required String description,
  required String status,
  required int departmentId,
}) {
  return http.put(
    Uri.parse("${baseUrl}departments/$departmentId/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'name': name,
      'description': description,
      'status': status,
    }),
  );
}

// Deletes a Department. This is an HTTP DELETE request.
Future<http.Response> deleteDepartment(String token, int departmentId) {
  return http.delete(
    Uri.parse("${baseUrl}departments/$departmentId/"),
    headers: {'Authorization': 'Token $token'},
  );
}



// Creates a new Category.
Future<http.Response> createSchool({
  required String token,
  required String name,
  required String address,
  required String abbreviation,
  required String domain,
  required String status,
}) {
  return http.post(
    Uri.parse("${baseUrl}schools/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // The keys here (like 'problem_statement') must exactly match what my Django API expects.
    body: jsonEncode({
      'name': name,
      'address': address,
      'abbreviation': abbreviation,
      'domain': domain,
      'status': status,
    }),
  );
}


// Gets the list of all of the user's Categories.
Future<http.Response> fetchSchool(String token) {
  return http.get(
    Uri.parse("${baseUrl}schools/"),
    headers: {'Authorization': 'Token $token'},
  );
}
// Gets the list of all of the user's Categories.
Future<http.Response> fetchAllowSchool(String token) {
  return http.get(
    Uri.parse("${baseUrl}schools-list/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Updates an existing Category. Using PUT because I'm replacing all the main fields.
Future<http.Response> updateSchool({
   required String token,
  required String name,
  required String address,
  required String abbreviation,
  required String domain,
  required String status,
  required int schoolId,
}) {
  return http.put(
    Uri.parse("${baseUrl}schools/$schoolId/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'name': name,
      'address': address,
      'abbreviation': abbreviation,
      'domain': domain,
      'status': status,
    }),
  );
}

// Deletes a Category. This is an HTTP DELETE request.
Future<http.Response> deleteSchool(String token, int schoolId) {
  return http.delete(
    Uri.parse("${baseUrl}schools/$schoolId/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Creates a new Category.
Future<http.Response> createCentralisedNumber({
  required String token,
  required String number,
  required String school,
  required String? building,
  required String department,
}) {
  return http.post(
    Uri.parse("${baseUrl}centralised-numbers/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // The keys here (like 'problem_statement') must exactly match what my Django API expects.
    body: jsonEncode({
      'number': number,
      'school': school,
      'building': building,
      'department': department,
    }),
  );
}

// Gets the list of all of the user's Categories.
Future<http.Response> fetchCentralisedNumber(String token) {
  return http.get(
    Uri.parse("${baseUrl}centralised-numbers/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Updates an existing Category. Using PUT because I'm replacing all the main fields.
Future<http.Response> updateCentralisedNumber({
  required String token,
  required String number,
  required String school,
  required String building,
  required String department,
  required int CentralisedNumberId,
}) {
  return http.put(
    Uri.parse("${baseUrl}centralised-numbers/$CentralisedNumberId/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'number': number,
      'school': school,
      'building': building,
      'department': department,
    }),
  );
}

// Deletes a Category. This is an HTTP DELETE request.
Future<http.Response> deleteCentralisedNumber(String token, int CentralisedNumberId) {
  return http.delete(
    Uri.parse("${baseUrl}centralised-numbers/$CentralisedNumberId/"),
    headers: {'Authorization': 'Token $token'},
  );
}
// Creates a new Category.
Future<http.Response> createBuilding({
  required String token,
  required String name,
  required String school,
  required String abbreviation,
  required String numberOfFloors,
  required String longitude,
  required String latitude,
}) {
  return http.post(
    Uri.parse("${baseUrl}buildings/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // The keys here (like 'problem_statement') must exactly match what my Django API expects.
    body: jsonEncode({
      'name': name,
      'school': school,
      'abbreviation':abbreviation,
      'number_of_floors':numberOfFloors,
      'longitude':longitude,
      'latitude': latitude,
    }),
  );
}

// Gets the list of all of the user's Categories.
Future<http.Response> fetchBuilding(String token) {
  return http.get(
    Uri.parse("${baseUrl}buildings/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Updates an existing Category. Using PUT because I'm replacing all the main fields.
Future<http.Response> updateBuilding({
  required String token,
  required String name,
  required String school,
  required String abbreviation,
  required String numberOfFloors,
  required String longitude,
  required String latitude,
  required int buildingId,
}) {
  return http.put(
    Uri.parse("${baseUrl}buildings/$buildingId/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'name': name,
      'school': school,
      'abbreviation':abbreviation,
      'number_of_floors':numberOfFloors,
      'longitude':longitude,
      'latitude': latitude,
    }),
  );
}

// Deletes a Category. This is an HTTP DELETE request.
Future<http.Response> deleteBuilding(String token, int buildingId) {
  return http.delete(
    Uri.parse("${baseUrl}buildings/$buildingId/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Creates a new Category.
Future<http.Response> createRoom({
  required String token,
  required String number,
  required String building,
  required String floor,
  required String longitude,
  required String latitude,
}) {
  return http.post(
    Uri.parse("${baseUrl}rooms/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // The keys here (like 'problem_statement') must exactly match what my Django API expects.
    body: jsonEncode({
      'number': number,
      'building': building,
      'floor':floor,
      'longitude':longitude,
      'latitude': latitude,
    }),
  );
}

// Gets the list of all of the user's Categories.
Future<http.Response> fetchRoom(String token) {
  return http.get(
    Uri.parse("${baseUrl}rooms/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// Updates an existing Category. Using PUT because I'm replacing all the main fields.
Future<http.Response> updateRoom({
  required String token,
  required String number,
  required String building,
  required String floor,
  required String longitude,
  required String latitude,
  required int roomId,
}) {
  return http.put(
    Uri.parse("${baseUrl}rooms/$roomId/"),
    headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'number': number,
      'building': building,
      'floor':floor,
      'longitude':longitude,
      'latitude': latitude,
    }),
  );
}

// Deletes a Category. This is an HTTP DELETE request.
Future<http.Response> deleteRoom(String token, int roomId) {
  return http.delete(
    Uri.parse("${baseUrl}rooms/$roomId/"),
    headers: {'Authorization': 'Token $token'},
  );
}

// ==========================================================
//  !!! NEW FUNCTION TO FETCH ALL NOTIFICATIONS !!!
// ==========================================================
Future<List<dynamic>> fetchNotifications(String token) async {
  const String url = "${baseUrl}notifications/";

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );

    // If the request was successful, decode the JSON and return the list.
    if (response.statusCode == 200) {
      // The response body will be a JSON string representing a list of objects.
      List<dynamic> notifications = jsonDecode(response.body);
      return notifications;
    } else {
      // If the server returns an error, throw an exception to be caught by the FutureBuilder.
      throw Exception('Failed to load notifications: ${response.statusCode}');
    }
  } catch (e) {
    print("Exception caught in fetchNotifications: $e");
    // Rethrow the exception so the UI can display an error state.
    rethrow;
  }
}

// notifications
Future<http.Response> getUnreadNotificationCount(String token) async {
  // Construct the full URL for the new endpoint
  const String url = "${baseUrl}notifications/unread-count/";

  try {
    // Make a GET request, including the user's auth token in the headers
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token', // Assuming TokenAuthentication
      },
    );
    return response;
  } catch (e) {
    // Handle network errors or other exceptions
    print("Exception caught in getUnreadNotificationCount: $e");
    // Return a custom error response or rethrow the exception
    // For simplicity, we can rethrow to be handled by the caller's try-catch block
    rethrow;
  }
}

// ==========================================================
//  !!! NEW FUNCTION TO MARK NOTIFICATIONS AS READ !!!
// ==========================================================
Future<http.Response> markNotificationsAsRead(String token) async {
  const String url = "${baseUrl}notifications/mark-as-read/";

  try {
    // Make a POST request. The body can be empty as the action is implicit.
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );
    return response;
  } catch (e) {
    print("Exception caught in markNotificationsAsRead: $e");
    rethrow;
  }
}
