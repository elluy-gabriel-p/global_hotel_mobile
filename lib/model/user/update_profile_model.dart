// To parse this JSON data, do
//
//     final updateProfileResponseModel = updateProfileResponseModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) =>
    UpdateProfileResponseModel.fromJson(json.decode(str));

String updateProfileResponseModelToJson(UpdateProfileResponseModel data) =>
    json.encode(data.toJson());

class UpdateProfileResponseModel {
  final String message;
  final Data data;

  UpdateProfileResponseModel({
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final int id;
  final String username;
  final String email;
  final String password;
  final String notelp;
  final String borndate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Data({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.notelp,
    required this.borndate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        notelp: json["notelp"],
        borndate: json["borndate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "notelp": notelp,
        "borndate": borndate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
