import 'package:ugdlayout2/entity/kamar.dart';
import 'dart:convert';
import 'package:http/http.dart';

class KamarClient {
  //Untuk emulator
  static final String url = '192.168.18.118'; //base url
  static final String endpoint =
      '/database_pbp/public/api/kamar/'; //base endpoint

  //untuk hp
  // static final String url = '192.168.56.1';
  // static final String endpoint = '/api/';

  //mengambil semua data kamar dari API
  static Future<List<Kamar>> fetchAll() async {
    try {
      var response = await get(
          Uri.http(url, endpoint)); //req ke api dan menyimpan responsenya

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //mengambil bagian data dari response body
      Iterable list = json.decode(response.body)['data'];

      //list.map untuk membuat list objek Kamar berdasarkan tiap elemen dari list
      return list.map((e) => Kamar.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Mengambil data kamar dari API sesuai id
  static Future<Kamar> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id')); //request ke api

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //membuat objek Kamar berdasarkan bagian data dari response body
      return Kamar.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //membuat data kamar baru
  static Future<Response> create(Kamar kamar) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: kamar.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Mengubah data kamar sesuai ID
  static Future<Response> update(Kamar kamar) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${kamar.id}'),
          headers: {"Content-Type": "application/json"},
          body: kamar.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Menghapus data kamar sesuai ID
  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
