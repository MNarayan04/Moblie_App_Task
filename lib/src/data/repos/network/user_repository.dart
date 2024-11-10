import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserRepository {
  Future<bool> login(String email, String password) async {
    Uri uri = Uri.parse('https://reqres.in/api/login');

    Response response = await http.post(uri, body: {
      "email": email,
      "password": password,
    });

    Map<String, dynamic> token = json.decode(response.body);
    print(token);
    try {
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }

    // print(response.body);
  }
}
