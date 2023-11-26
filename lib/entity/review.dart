import 'dart:convert';

class Review {
  int id;
  String nama;
  String review;
  int rating;

  Review(
      {required this.id,
      required this.nama,
      required this.review,
      required this.rating});

  // untuk membuat objek  review dari data json yang diterima dari API
  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));
  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json["id"],
      nama: json["nama"],
      review: json["review"],
      rating: json["rating"]);

  // untuk membuat data json dari objek review yang dikirim ke API
  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "review": review,
        "rating": rating,
      };
}