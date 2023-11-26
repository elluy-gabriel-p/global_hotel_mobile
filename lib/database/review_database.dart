import 'package:ugdlayout2/entity/review.dart';

import 'dart:convert';
import 'package:http/http.dart';

class ReviewClient {
  //sesuaikan url dan endpoint: dengan device yang kalian gunakan untuk uji coba besual langkah 7

  static final String url = '192.168.18.118'; //base url
  static final String endpoint =
      '/database_pbp/public/api/review'; //base endpoint

  //mengambil semua data review dari API
  static Future<List<Review>> fetchAll() async {
    try {
      var response = await get(
          Uri.http(url, endpoint)); //request ke api dan meyimpan responsenya

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      // mengambil bagian data dari response body
      Iterable list = json.decode(response.body)['data'];

      // list.map untuk membuat list objek Review berdasarkasn tiap elemen dari list
      return list.map((e) => Review.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengambil data review dari API sesuai id
  static Future<Review> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      //membuat objek Review berdasasrkan bagian data dari response body
      return Review.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengambil data review baru
  static Future<Response> create(Review review) async {
    try {
      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},
          body: review.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //mengambil data review sesuai ID
  static Future<Response> update(Review review) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${review.id}'),
          headers: {"Content-Type": "application/json"},
          body: review.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //menghapus data review sesuai ID
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
