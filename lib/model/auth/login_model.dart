// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  final bool status;
  final String message;
  final LoginDataModel user;

  LoginResponseModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        message: json["message"],
        user: LoginDataModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class LoginDataModel {
  final int id;
  final String username;
  final String email;
  final String password;
  final String notelp;
  final DateTime borndate;
  final DateTime createdAt;
  final DateTime updatedAt;

  LoginDataModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.notelp,
    required this.borndate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        notelp: json["notelp"],
        borndate: DateTime.parse(json["borndate"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "notelp": notelp,
        "borndate":
            "${borndate.year.toString().padLeft(4, '0')}-${borndate.month.toString().padLeft(2, '0')}-${borndate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
