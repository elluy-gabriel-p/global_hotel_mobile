import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/entity/hotel.dart';
import 'package:ugdlayout2/entity/service.dart';

import 'dart:convert';
import 'package:http/http.dart';

class LoginClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/';

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
      var response = await get(Uri.http(url, '/api/user/$id'));

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
    print('User ID: ${user.id}');
    try {
      var response = await put(Uri.http(url, '/api/user/${user.id}'),
          headers: {'Content-Type': 'application/json'},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      print('Update Data Success');
      return response;
    } catch (e) {
      print('Error : $e');
      print('Request Body: ${user.toRawJson()}');

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

  static Future<User> updatePassword(String email, String newPassword) async {
    try {
      var response = await put(
        Uri.http(url, "/api/updatePass"),
        body: {
          'email': email,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return User.fromMap(json.decode(response.body)['data']);
      } else {
        throw Exception(
            'Failed to update password. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating password: $e');
    }
  }

  
}

class HotelClient {
  static final String url = 'https://projecthotel.my.id';
  // static final String url = '10.0.2.2:8000';

  static final String endpoint = '/api/hotel/';

  static Future<List<Hotel>> fetchAll() async {
    try {
      var response = await get(Uri.parse(
          '$url/api/hotel')); // request ke api dan menyimpan responsenya

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //ambil data dari response body
      Iterable list = json.decode(response.body)['data'];

      //list map utk membuat list hotel berdasar tiap elemen dari list
      return list.map((e) => Hotel.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //ambil data dari API sesuai id
  static Future<Hotel> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id')); //req ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //buat hotel berdasarkan data dari response body
      return Hotel.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //membuat data baru
  static Future<Response> create(Hotel hotel) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: hotel.toRawJson());
      print(response.body);

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengubaah data sesuai id
  static Future<Response> update(Hotel objek) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${objek.id}'),
          headers: {'Content-Type': 'application/json'},
          body: objek.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //menghapus data sesuai id
  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}