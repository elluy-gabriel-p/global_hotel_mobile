// To parse this JSON data, do
//
//     final bookingResponseModel = bookingResponseModelFromJson(jsonString);

import 'dart:convert';

BookingResponseModel bookingResponseModelFromJson(String str) =>
    BookingResponseModel.fromJson(json.decode(str));

String bookingResponseModelToJson(BookingResponseModel data) =>
    json.encode(data.toJson());

class BookingResponseModel {
  final bool status;
  final String messege;
  final List<BookingResponseDataModel> data;

  BookingResponseModel({
    required this.status,
    required this.messege,
    required this.data,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) =>
      BookingResponseModel(
        status: json["status"],
        messege: json["messege"],
        data: List<BookingResponseDataModel>.from(
            json["data"].map((x) => BookingResponseDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "messege": messege,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BookingResponseDataModel {
  final int id;
  final int idKamar;
  final int idUser;
  final int jumlahOrang;
  final int jumlahKamar;
  final DateTime tglCheckIn;
  final DateTime tglCheckOut;
  final String notelp;
  final String username;
  final String tipe;
  final int harga;

  BookingResponseDataModel({
    required this.id,
    required this.idKamar,
    required this.idUser,
    required this.jumlahOrang,
    required this.jumlahKamar,
    required this.tglCheckIn,
    required this.tglCheckOut,
    required this.notelp,
    required this.username,
    required this.tipe,
    required this.harga,
  });

  factory BookingResponseDataModel.fromJson(Map<String, dynamic> json) =>
      BookingResponseDataModel(
        id: json["id"],
        idKamar: json["id_kamar"],
        idUser: json["id_user"],
        jumlahOrang: json["jumlah_orang"],
        jumlahKamar: json["jumlah_kamar"],
        tglCheckIn: DateTime.parse(json["tgl_check_in"]),
        tglCheckOut: DateTime.parse(json["tgl_check_out"]),
        notelp: json["notelp"],
        username: json["username"],
        tipe: json["tipe"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_kamar": idKamar,
        "id_user": idUser,
        "jumlah_orang": jumlahOrang,
        "jumlah_kamar": jumlahKamar,
        "tgl_check_in": tglCheckIn.toIso8601String(),
        "tgl_check_out": tglCheckOut.toIso8601String(),
        "notelp": notelp,
        "username": username,
        "tipe": tipe,
        "harga": harga,
      };
}
