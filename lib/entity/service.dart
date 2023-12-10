import 'dart:convert';

class Service {
  int id, harga;
  String namaService;

  Service({required this.id, required this.namaService, required this.harga});

  factory Service.fromRawJson(String str) =>
      Service.fromRawJson(json.decode(str));
  factory Service.fromJson(Map<String, dynamic> json) => Service(
      id: json["id"], namaService: json["namaService"], harga: json["harga"]);

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "namaService": namaService,
        "harga": harga,
      };
}
