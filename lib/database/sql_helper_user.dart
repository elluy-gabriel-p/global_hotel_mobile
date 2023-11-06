import 'dart:typed_data';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:ugdlayout2/entity/user.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        """
      CREATE TABLE user(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      username TEXT,
      email TEXT,
      password TEXT,
      notelp TEXT,
      borndate TEXT,
      profileImage BLOB
      )
      """);
  }

  //update profile images
  static Future<int> updateProfileImages(
    String username, Uint8List profileImage) async {
    final db = await SQLHelper.db();
    final data = {
      'profileImage': profileImage
    };
    return db.update('user', data, where: 'username = ?', whereArgs: [username]);
  }

  //cal db
  static Future<sql.Database> db() async {
    return sql.openDatabase('user.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

//insert Employee
  static Future<int?> addUser(String username, String email, String password,
      String notelp, String borndate) async {
    final db = await SQLHelper.db();

    // Periksa apakah email sudah ada dalam database
    final List<Map<String, dynamic>> existingEmail = await db.query(
      'user',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingEmail.isNotEmpty) {
      // Email sudah ada dalam database, kembalikan null untuk menandakan error
      Fluttertoast.showToast(
          msg: "Register Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return null;
    }

    final data = {
      'username': username,
      'email': email,
      'password': password,
      'notelp': notelp,
      'borndate': borndate
    };
    return await db.insert('user', data);
  }



//read Employee
  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return db.query('user');
  }



//update Employee
  static Future<int> editUser(int id, String username, String email,
      String password, String notelp, String borndate) async {
    final db = await SQLHelper.db();
    final data = {
      'username': username,
      'email': email,
      'password': password,
      'notelp': notelp,
      'borndate': borndate
    };
    return await db.update('user', data, where: "id = $id");
  }

//Delete Employee
  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('user', where: "id = $id");
  }

  static Future<User?> forLogin(String username, String password) async {
    final db = await SQLHelper.db();
    var temp = await db.rawQuery(
      "Select * From $User Where username = '$username' and password = '$password'",
    );

    if (temp.length > 0) {
      return User.fromMap(temp[0]);
    }
    return null;
  }

  static Future<int> insertImage(int userId, Uint8List image) async {
    final db = await SQLHelper.db();

    return await db.update(
      'user',
      {'imageProfile': image},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  static Future<Uint8List?> getImageProfile(int userId) async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> result = await db.query(
      'user',
      columns: ['imageProfile'],
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty && result.first['imageProfile'] != null) {
      return result.first['imageProfile'] as Uint8List;
    } else if (result.first['imageProfile'] == null) {
      return null;
    } else {
      return null;
    }
  }
}
