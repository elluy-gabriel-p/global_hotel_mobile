import 'dart:convert';
import 'dart:ffi';

import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/model/auth/login_model.dart';
import 'package:ugdlayout2/model/auth/register_model.dart';
import 'package:http/http.dart' as http;
import 'package:ugdlayout2/model/user/update_profile_model.dart';

class UserRepository {
  final String url = "https://projecthotel.my.id/api";
  // final String url = "http://10.0.2.2:8000/api";

  Future<RegisterResponseModel> DoRegister(String name, String email,
      String password, String borndate, String notelp) async {
    try {
      final response = await http.post(Uri.parse(
          "$url/register?username=$name&email=$email&password=$password&borndate=$borndate&notelp=$notelp"));

      final decodedJson = jsonDecode(response.body);
      print(decodedJson);
      final result = RegisterResponseModel.fromJson(decodedJson);
      return result;
    } catch (e) {
      print('disini error');
      throw e;
    }
  }

  Future<LoginResponseModel> DoLogin(String username, String password) async {
    try {
      final response = await http
          .post(Uri.parse("$url/login?username=$username&password=$password"));

      final decodedJson = jsonDecode(response.body);

      final status = decodedJson["status"].toString();

      print(status);

      if (status == "true") {
        final result = LoginResponseModel.fromJson(decodedJson);
        return result;
      } else {
        return LoginResponseModel(
            status: false,
            message: decodedJson["message"],
            user: LoginDataModel(
                id: 0,
                username: "username",
                email: "email",
                password: "password",
                notelp: "notelp",
                borndate: DateTime.now(),
                createdAt: DateTime.now(),
                updatedAt: DateTime.now()));
      }
    } catch (e) {
      throw e;
    }
  }

  Future<UpdateProfileResponseModel> DoUpdateProfile(String name, String email,
      String password, String borndate, String notelp, int id) async {
    try {
      final response = await http.put(Uri.parse(
          "$url/user/$id?username=$name&email=$email&password=$password&borndate=$borndate&notelp=$notelp"));

      final decodedJson = jsonDecode(response.body);
      final result = UpdateProfileResponseModel.fromJson(decodedJson);
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<User> find(id) async {
    try {
      var response = await http.get(Uri.parse("$url/user/$id"));

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

  Future<bool> DoUpdateImageProfile(int id, String base64img) async {
    try {
      var response = await http.put(Uri.parse("$url/updateProfile"),
          body: {"id": id.toString(), "image": base64img});

      print(response.body);

      return true;
    } catch (e) {
      throw e;
    }
  }
}
