import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ugdlayout2/entity/kamar.dart';
import 'package:ugdlayout2/model/booking/booking_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/model/review/get_review_response_model.dart';

class BookingRepository {
  final String url = "https://projecthotel.my.id/api";
  // final String url = "http://10.0.2.2:8000/api";

  Future<bool> DoBookingHotel(int idKamar, int idUser, int jumlahOrang,
      int jumlahKamar, String checkin, String checkout, String notelp) async {
    try {
      final response = await http.post(Uri.parse(
          "$url/booking?id_kamar=$idKamar&id_user=$idUser&jumlah_orang=$jumlahOrang&jumlah_kamar=$jumlahKamar&tgl_check_in=$checkin&tgl_check_out=$checkout&notelp=$notelp"));

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> DoCancelBookingHotel(int idBooking) async {
    try {
      final response =
          await http.delete(Uri.parse("$url/batalBooking?id=$idBooking"));

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<BookingResponseDataModel>> GetBookingHotelList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    try {
      final response = await http.get(Uri.parse("$url/getBooking?id=$userId"));

      final decodedJson = jsonDecode(response.body);
      final result = BookingResponseModel.fromJson(decodedJson);
      return result.data;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<BookingResponseDataModel>> GetBookingHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    try {
      final response = await http.get(Uri.parse("$url/getHistory?id=$userId"));

      final decodedJson = jsonDecode(response.body);
      final result = BookingResponseModel.fromJson(decodedJson);
      return result.data;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> DoUpdateCheckin(int id) async {
    try {
      final response = await http.put(Uri.parse("$url/checkIn?id=$id"));

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> AddRoomReview(int idKamar, String komentar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    try {
      final response = await http.post(Uri.parse(
          "$url/addReview?id_kamar=$idKamar&komentar=$komentar&id_user=$userId"));

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<ReviewModelData>> GetMyReview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    try {
      final response = await http.get(Uri.parse("$url/getReview?id=$userId"));

      final decodedJson = jsonDecode(response.body);
      final result = GetReviewResponseModel.fromJson(decodedJson);
      return result.data;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> EditRoomReview(int idReview, String komentar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    try {
      final response = await http
          .put(Uri.parse("$url/editReview?id=$idReview&komentar=$komentar"));

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> DeleteRoomReview(int idReview) async {
    try {
      final response =
          await http.delete(Uri.parse("$url/deleteReview?id=$idReview"));

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> DoUpdateKamar(Kamar kamar) async {
    try {
      final response = await http.put(Uri.parse(
          "$url/kamar/${kamar.id}?tipe=${kamar.tipe}&tipe=${kamar.tipe}&harga=${kamar.harga}&kapasitas=${kamar.kapasitas}&status=${kamar.status}"));

      return true;
    } catch (e) {
      print('Error: $e');
      return Future.error(e.toString());
    }
  }
}
