import 'dart:convert';

class Review {
  int id;
  String content;

  Review(
      {required this.id,
      required this.content});

  factory Review.fromRawJson(String str) => Review.fromRawJson(json.decode(str));
  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        content: json["content"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content
      };
}
