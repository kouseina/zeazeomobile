import 'dart:convert';

import 'package:zeazeoshop/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'https://99c9-36-88-30-194.ngrok-free.app/api';

  Future<UserModel> register({
    String? name,
    String? username,
    String? email,
    String? password,
    String? phone,
  }) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
    });

    var response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: headers,
      body: body,
    );

    print('HEADERS : ${response.headers}');
    print('METHOD | URL : ${response.request?.method} ${response.request?.url}');
    print('REQUEST : $body');
    print('STATUS CODE | RESPONSE : ${response.statusCode} | ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['access_token']}';

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: headers,
      body: body,
    );

    print('HEADERS : ${response.headers}');
    print('METHOD | URL : ${response.request?.method} ${response.request?.url}');
    print('REQUEST : $body');
    print('STATUS CODE | RESPONSE : ${response.statusCode} | ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['access_token']}';

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }
}
