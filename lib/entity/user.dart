import 'dart:ffi';
import 'dart:typed_data';

class User {
  final int? id;

  String? username, email, password, notelp, borndate;
  Uint8List? dataImage;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.notelp,
      this.borndate,
      this.dataImage
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'notelp': notelp,
      'borndate': borndate
    };
  }

  User.fromMap(Map<String, dynamic> temp)
      : id = temp['id'],
        username = temp['username'],
        email = temp['email'],
        password = temp['password'],
        notelp = temp['notelp'],
        borndate = temp['borndate'];
}
