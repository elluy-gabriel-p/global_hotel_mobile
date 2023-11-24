import 'dart:ffi';

import 'package:ugdlayout2/entity/user.dart';

import 'dart:convert';
import 'package:http/http.dart';

class LoginClient{
   static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/';

  static Future<void> create(User user) async {
    try {
      print(user.toMap());
      var response = await post(Uri.http(url, "${endpoint}register"),
          body: user.toMap());
          print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // return respons;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
  static Future<User> login(String username, String password) async {
    try {
      var response = await post(Uri.http(url, "${endpoint}login"),
          body: {'username': username, 'password': password});
          // print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      final userData = json.decode(response.body)['user'];
      print(userData);
      
      return User.fromMap(userData[0]);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  
}