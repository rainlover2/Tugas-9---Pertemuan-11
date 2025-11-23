import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/registrasi.dart';
import 'api.dart';

class RegisterService {
  static Future<Registrasi?> register(String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse(Api.register),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (res.statusCode == 200) {
        return Registrasi.fromJson(jsonDecode(res.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}