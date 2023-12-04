import 'package:flutter/material.dart';


class Room {
  final String name;
  final String type;

  Room(this.name, this.type);
}

class RoomListPage extends StatelessWidget {
   List<Room> rooms = [
    Room('Kamar 101', 'Single'),
    Room('Kamar 102', 'Double'),
    Room('Kamar 103', 'Suite'),
    // Tambahkan kamar lain sesuai kebutuhan
  ];

  void isiDataRoom(List<Room> list){
    rooms = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kamar'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(rooms[index].name),
            subtitle: Text('Tipe: ${rooms[index].type}'),
            onTap: () {
              // Aksi ketika item di tap
              print('Kamar ${rooms[index].name} dipilih');
            },
          );
        },
      ),
    );
  }
}



class RoomListPage2 extends StatelessWidget {
   List<Room> rooms = [
    
    // Tambahkan kamar lain sesuai kebutuhan
  ];

  void isiDataRoom(List<Room> list){
    rooms = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kamar'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(rooms[index].name),
            subtitle: Text('Tipe: ${rooms[index].type}'),
            onTap: () {
              // Aksi ketika item di tap
              print('Kamar ${rooms[index].name} dipilih');
            },
          );
        },
      ),
    );
  }
}
