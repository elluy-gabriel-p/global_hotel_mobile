import 'dart:ffi';

import 'package:ugdlayout2/entity/user.dart';

import 'dart:convert';
import 'package:http/http.dart';

class LoginClient {
  static final String url = '192.168.18.118'; //base url
  static final String endpoint = '/database_pbp/public/api/';

  //mengambil semua data user dari API
  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(
          Uri.http(url, endpoint)); //request ke api dan meyimpan responsenya

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // mengambil bagian data dari response body
      Iterable list = json.decode(response.body)['data'];

      // list.map untuk membuat list objek User berdasarkasn tiap elemen dari list
      return list.map((e) => User.fromMap(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengambil data user dari API sesuai id
  static Future<User> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode == 200) {
        return User.fromMap(json.decode(response.body)['data']);
      } else {
        print('Error fetching user data. Status code: ${response.statusCode}');
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return Future.error(e.toString());
    }
  }

  static Future<void> create(User user) async {
    try {
      print(user.toMap());
      var response =
          await post(Uri.http(url, "${endpoint}register"), body: user.toMap());
      print(response.body);
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // return respons;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengambil data user sesuai ID
  static Future<Response> update(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
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
