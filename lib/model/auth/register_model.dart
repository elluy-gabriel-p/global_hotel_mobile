// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
    final bool status;
    final String message;
    final RegisterDataModel user;

    RegisterResponseModel({
        required this.status,
        required this.message,
        required this.user,
    });

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        status: json["status"],
        message: json["message"],
        user: RegisterDataModel.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
    };
}

class RegisterDataModel {
    final String username;
    final String password;
    final String email;
    final String notelp;
    final String borndate;
    final DateTime updatedAt;
    final DateTime createdAt;
    final int id;

    RegisterDataModel({
        required this.username,
        required this.password,
        required this.email,
        required this.notelp,
        required this.borndate,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory RegisterDataModel.fromJson(Map<String, dynamic> json) => RegisterDataModel(
        username: json["username"],
        password: json["password"],
        email: json["email"],
        notelp: json["notelp"],
        borndate: json["borndate"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "notelp": notelp,
        "borndate": borndate,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
