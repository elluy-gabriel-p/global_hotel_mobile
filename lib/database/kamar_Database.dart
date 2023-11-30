import 'package:ugdlayout2/entity/kamar.dart';
import 'dart:convert';
import 'package:http/http.dart';

class KamarClient {
  static final String url = '10.0.2.2:8000'; // base url
  static final String endpoint = '/api/kamar/'; // base endpoint

  //untuk hp
  // static final String url = '192.168.56.1';
  // static final String endpoint = '/api/';

  //mengambil semua data kamar dari API
  static Future<List<Kamar>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Kamar.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Kamar> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Kamar.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

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

  static Future<Response> update(Kamar kamar) async {
    print('Kamar ID: ${kamar.id}');
    try {
      final updateUrl = Uri.http(url, '/api/kamar/${kamar.id}');
      print('Update URL: $updateUrl');
      print('Request Body: ${kamar.toRawJson()}');

      var response = await patch(
        updateUrl,
        headers: {"Content-Type": "application/json"},
        body: kamar.toRawJson(),
      );

      if (response.statusCode != 200) {
        throw Exception(response.reasonPhrase);
      }

      print('Update Data Success');
      return response;
    } catch (e) {
      print('Error: $e');
      return Future.error(e.toString());
    }
  }

  static Future<Response> destroy(id) async {
    try {
      var response = await delete(Uri.http(url, '/api/kamar/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
