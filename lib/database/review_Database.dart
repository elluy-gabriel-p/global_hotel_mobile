import 'package:ugdlayout2/entity/review.dart';
import 'dart:convert';
import 'package:http/http.dart';

class ReviewClient {
  static final String url = 'https://projecthotel.my.id'; // base url
  // static final String url = 'http://10.0.2.2:8000'; // base url
  static final String endpoint = '/api/review/'; // base endpoint

  //untuk hp
  // static final String url = '192.168.56.1';
  // static final String endpoint = '/api/';

  //mengambil semua data review dari API
  static Future<List<Review>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((e) => Review.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Review> find(id) async {
    try {
      var response = await get(Uri.http(url, '$endpoint/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Review.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

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

  static Future<Response> update(Review review) async {
    print('Review ID: ${review.id}');
    try {
      final updateUrl = Uri.http(url, '/api/review/${review.id}');
      print('Update URL: $updateUrl');
      print('Request Body: ${review.toRawJson()}');

      var response = await patch(
        updateUrl,
        headers: {"Content-Type": "application/json"},
        body: review.toRawJson(),
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
      var response = await delete(Uri.http(url, '/api/review/$id'));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
