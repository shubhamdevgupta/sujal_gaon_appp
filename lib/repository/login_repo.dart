import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; // Kept this if you use other http methods
import 'package:http/io_client.dart'; // <--- Correct for IOClient

class LoginRepository {
  // Assuming the baseUrl is corrected for the Android Emulator/Device IP
  final String baseUrl = "https://10.0.2.2:7006";

  // New: Helper method to create the custom client (DRY!)
  IOClient _createInsecureClient() {
    final httpClient = HttpClient()
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
    return IOClient(httpClient);
  }

  // --- getForecast() function (Minimal change to use the new helper) ---
  Future<dynamic> getForecast() async {
    final url = Uri.parse("$baseUrl/WeatherForecast");

    // Use the helper method
    final client = _createInsecureClient();

    final headers = {
      "Content-Type": "application/json",
    };

    try {
      debugPrint("🔹 [FORECAST API] URL: $url");
      debugPrint("📦 [HEADERS]: $headers");

      // Use the custom client
      final response = await client.get(url, headers: headers);

      // IMPORTANT: Close the client after use!
      client.close();

      debugPrint("✅ [RESPONSE STATUS]: ${response.statusCode}");
      debugPrint("📥 [RESPONSE BODY RAW]: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        debugPrint("🧩 [PARSED RESPONSE]: $jsonResponse");
        return jsonResponse;
      } else {
        debugPrint("❌ [FORECAST FAILED]: ${response.statusCode}");
        throw Exception("Forecast fetch failed with status ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("🚨 [FORECAST ERROR]: $e");
      // Ensure the client is closed if you put the close() inside the try block
      throw Exception("Forecast error: $e");
    }
  }

  // --- login() function (Refactored to use the custom client) ---
  /*Future<LoginResponse> login(String userid, String password) async {
    final url = Uri.parse("$baseUrl/api/Login/GetFirstLogin");

    final body = jsonEncode({
      "Userid": "rishabh",
      "Password": "1234"
    });

    final headers = {
      "Content-Type": "application/json",
    };

    // 1. Get the custom client with the certificate bypass
    // Ensure your login method uses the custom client
    final client = _createInsecureClient();


    try {
      debugPrint("🔹 [LOGIN API] URL: $url");
      debugPrint("📤 [REQUEST BODY]: $body");
      debugPrint("📦 [HEADERS]: $headers");

      // 2. Change from http.post to client.post
      final response = await client.post(url, headers: headers, body: body); // <--- Use client.post!
      client.close();

      debugPrint("✅ [RESPONSE STATUS]: ${response.statusCode}");
      debugPrint("📥 [RESPONSE BODY RAW]: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        debugPrint("🧩 [PARSED RESPONSE]: $jsonResponse");

        return LoginResponse.fromJson(jsonResponse);
      } else {
        debugPrint("❌ [LOGIN FAILED]: ${response.statusCode}");
        throw Exception("Login failed with status ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("🚨 [LOGIN ERROR]: $e");
      // In case the error happens before closing the client, you might want
      // to ensure it's closed, but for simplicity here we let the error flow.
      throw Exception("Login error: $e");
    }
  }*/

}