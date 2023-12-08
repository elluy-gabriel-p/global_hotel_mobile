import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ugdlayout2/entity/service.dart';

class ServiceClient {
  static final String url = '10.0.2.2:8000';
  static final String endpoint = '/api/service/';

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Future<List<Service>> showServices() async {
    try {
      var response = await http.get(
        Uri.http(url, endpoint),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];
      return list.map((e) => Service.fromJson(e)).toList();
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Service> showServiceById(int id) async {
    try {
      var response = await http.get(
        Uri.http(url, "$endpoint/$id"),
        headers: _setHeaders(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Service.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<http.Response> createService(Map<String, dynamic> data) async {
    print('data : ${data}');
    try {
      var response = await http.post(
        Uri.http(url, endpoint),
        headers: _setHeaders(),
        body: jsonEncode(data),
      );
      print('response : ${response.body}');

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}