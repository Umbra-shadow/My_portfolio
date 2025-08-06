import 'dart:convert';

import 'package:http/http.dart' as http;

// baseUrl variable to make easy changes if needed
const String baseUrl = "https://appodeo.onrender.com/appodeo-api/";

Future<http.Response> sendQuestionToBot(String userInput) async {
  // 1. Correct Key: Use "user_message" to match the Django backend
  final Map<String, dynamic> data = {"user_message": userInput};

  final response = await http.post(
    Uri.parse("${baseUrl}chat/"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  return response;
}
