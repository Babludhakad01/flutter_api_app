import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtub_flutter_project/core/constants/api_urls/auth_api.dart';
import 'package:youtub_flutter_project/data/models/user_model.dart';

class AuthRepository {
  Future<UserModel> login(String email, password) async {
    try {
      final response = await http.post(
        Uri.parse("${AuthApi.baseUrl}/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);

        final userData = data['user'] ?? data;

        final user = UserModel.fromJson(userData);
        return user;
      } else {
        throw Exception(" ${data['message']}");
      }
    } catch (e) {
      throw Exception('Login error: ${e.toString()}');
    }
  }
}
