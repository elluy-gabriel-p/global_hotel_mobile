import 'dart:convert';

class Kamar {
  int id, harga, kapasitas;
  String tipe, status;

  Kamar(
      {required this.id,
      required this.tipe,
      required this.harga,
      required this.kapasitas,
      required this.status});

  factory Kamar.fromRawJson(String str) => Kamar.fromRawJson(json.decode(str));
  factory Kamar.fromJson(Map<String, dynamic> json) => Kamar(
        id: json["id"],
        tipe: json["tipe"],
        harga: json["harga"],
        kapasitas: json["kapasitas"],
        status: json["status"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipe": tipe,
        "harga": harga,
        "kapasitas": kapasitas,
        "status": status,
      };
}
