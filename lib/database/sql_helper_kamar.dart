import 'package:sqflite/sqflite.dart' as sql;
import 'dart:typed_data';
class SQLHelper {
  //create db
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
      CREATE TABLE kamar(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        tipe TEXT,
        harga INTEGER,
        kapasitas INTEGER,
        status TEXT,
        roomImage BLOB
        )
    """);
  }

  //upload room image
  static Future<int> updateRoomImages(
      String tipe, Uint8List roomImage) async {
    final db = await SQLHelper.db();
    final data = {'roomImage': roomImage};
    return db
        .update('kamar', data, where: 'tipe = ?', whereArgs: [tipe]);
  }

  //call db
  static Future<sql.Database> db() async {
    return sql.openDatabase('kamar.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await SQLHelper.createTable(database);
    });
  }

  // insert kamar
  static Future<int> addKamar(
    String tipe,
    int harga,
    int kapasitas,
    String status,
    Uint8List? roomImage,
  ) async {
    final db = await SQLHelper.db();
    final data = {
      'tipe': tipe,
      'harga': harga,
      'kapasitas': kapasitas,
      'status': status,
      'roomImage': roomImage, // Add this line to include the room image
    };
    return await db.insert('kamar', data);
  }

  //read Kamar
  static Future<List<Map<String, dynamic>>> getKamar() async {
    final db = await SQLHelper.db();
    return db.query('kamar');
  }

  //update kamar
  static Future<int> editKamar(
    int id, String tipe, int harga, int kapasitas, String status, Uint8List? roomImage) async {
    final db = await SQLHelper.db();
    final data = {
      'tipe': tipe,
      'harga': harga,
      'kapasitas': kapasitas,
      'status': status,
      'roomImage': roomImage,
    };
    return await db.update('kamar', data, where: 'id = ?', whereArgs: [id]);
  }


  //delete kamar
  static Future<int> deleteKamar(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('kamar', where: 'id = $id');
  }
}
