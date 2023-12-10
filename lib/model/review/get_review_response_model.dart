// To parse this JSON data, do
//
//     final getReviewResponseModel = getReviewResponseModelFromJson(jsonString);

import 'dart:convert';

GetReviewResponseModel getReviewResponseModelFromJson(String str) => GetReviewResponseModel.fromJson(json.decode(str));

String getReviewResponseModelToJson(GetReviewResponseModel data) => json.encode(data.toJson());

class GetReviewResponseModel {
    final bool status;
    final String message;
    final List<ReviewModelData> data;

    GetReviewResponseModel({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetReviewResponseModel.fromJson(Map<String, dynamic> json) => GetReviewResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<ReviewModelData>.from(json["data"].map((x) => ReviewModelData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ReviewModelData {
    final int id;
    final int idKamar;
    final String komentar;
    final int idUser;
    final String username;
    final String tipe;
    final int harga;

    ReviewModelData({
        required this.id,
        required this.idKamar,
        required this.komentar,
        required this.idUser,
        required this.username,
        required this.tipe,
        required this.harga,
    });

    factory ReviewModelData.fromJson(Map<String, dynamic> json) => ReviewModelData(
        id: json["id"],
        idKamar: json["id_kamar"],
        komentar: json["komentar"],
        idUser: json["id_user"],
        username: json["username"],
        tipe: json["tipe"],
        harga: json["harga"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_kamar": idKamar,
        "komentar": komentar,
        "id_user": idUser,
        "username": username,
        "tipe": tipe,
        "harga": harga,
    };
}
