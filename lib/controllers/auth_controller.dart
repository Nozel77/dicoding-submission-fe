import 'dart:convert';
import 'dart:io';
import 'package:dicoding_submission/models/user_model.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController{
  final String baseUrl = 'https://dicoding-backend.rplrus.com/api';

  Future<bool> register(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await saveAuthToken(token);

      return true;
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Registration failed');
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      final token = jsonResponse['token'];

      await saveAuthToken(token);

      return true;
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Login failed');
    }
  }

  Future<bool> logout() async {
    final url = Uri.parse('$baseUrl/auth/logout');
    try {
      final String? token = await getAuthToken();

      final response = await http.post(
          url,
          headers: {
            'Authorization' : 'Bearer $token',
          }
      );

      if(response.statusCode == 200){
        await saveAuthToken('');
        return true;
      } else {
        print("Failed to logout. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e){
      print("Error while logging out: $e");
      return false;
    }
  }

  Future<UserModel?> me() async {
    final String url = '$baseUrl/auth/me';
    final String? token = await getAuthToken();

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        if (json['data'] != null) {
          log("User data: $json");
          return UserModel.fromJson(json['data']);
        } else {
          print("Unexpected JSON structure: $json");
          return null;
        }
      } else {
        print("Failed to fetch user data. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error while fetching user: $e");
      return null;
    }
  }

  Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool> updateAvatar(File avatarFile) async {
    final String url = '$baseUrl/auth/update-avatar';
    final String? token = await getAuthToken();

    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(await http.MultipartFile.fromPath('avatar', avatarFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        print("Avatar updated successfully");
        return true;
      } else {
        print("Failed to update avatar. Status code: ${response.statusCode}");
        final responseBody = await response.stream.bytesToString();
        print("Response: $responseBody");
        return false;
      }
    } catch (e) {
      print("Error while updating avatar: $e");
      return false;
    }
  }
}
