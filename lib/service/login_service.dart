import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/login.dart';
import 'api.dart';

class LoginService {
  static Future<Login?> login(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse(Api.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (res.statusCode == 200) {
        return Login.fromJson(jsonDecode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}