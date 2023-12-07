import 'dart:convert';

class Hotel {
  final int? id;
  double? harga, rating;
  String nama, alamat, deskripsi, fasilitas;
  String? gambar;

  Hotel({
    this.id,
    required this.nama,
    required this.alamat,
    required this.deskripsi,
    required this.gambar,
    required this.rating,
    required this.harga,
    required this.fasilitas,
  });

  factory Hotel.fromRawJson(String str) => Hotel.fromJson(json.decode(str));

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        nama: json["nama"],
        alamat: json["alamat"],
        deskripsi: json["deskripsi"],
        gambar: json["gambar"],
        rating: json["rating"].toDouble(),
        harga: json["harga"].toDouble(),
        fasilitas: json["fasilitas"],
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
        "deskripsi": deskripsi,
        "gambar": gambar,
        "rating": rating,
        "harga": harga,
        "fasilitas": fasilitas,
      };
}
