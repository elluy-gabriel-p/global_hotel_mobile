import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugdlayout2/View/ugdAPI2/editKamar.dart';
import 'package:ugdlayout2/View/ugdAPI2/inputKamar.dart';
import 'package:ugdlayout2/database/kamar_Database.dart';
import 'package:ugdlayout2/entity/kamar.dart';
import 'package:ugdlayout2/View/ugdAPI2/inputKamar.dart';

class KamarPage2 extends StatefulWidget {
  KamarPage2({Key? key}) : super(key: key);

  @override
  _KamarPage2State createState() => _KamarPage2State();
}

class _KamarPage2State extends State<KamarPage2> {
  late Future<List<Kamar>> _listBarangFuture;

  @override
  void initState() {
    super.initState();
    _listBarangFuture = KamarClient.fetchAll();
  }

  void onAdd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const inputKamar(),
      ),
    ).then((value) {
      setState(() {
        _listBarangFuture = KamarClient.fetchAll();
      });
    });
  }

  void onDelete(int id, BuildContext context) async {
    try {
      await KamarClient.destroy(id);
      setState(() {
        _listBarangFuture = KamarClient.fetchAll();
      });
      showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  ListTile scrollViewItem(Kamar k, BuildContext context) => ListTile(
        title: Text(k.tipe),
        subtitle: Text(k.harga.toString()),
        onTap: () {
          print(k.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditKamarPage(kamar: k),
            ),
          ).then((value) {
            setState(() {
              _listBarangFuture = KamarClient.fetchAll();
            });
          });
        },
        trailing: IconButton(
          onPressed: () => onDelete(k.id, context),
          icon: const Icon(Icons.delete),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kamar"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onAdd(context),
      ),
      body: FutureBuilder<List<Kamar>>(
        future: _listBarangFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No data available"),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map((barang) => scrollViewItem(barang, context))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final ScaffoldMessengerState scaffoldMessenger =
      ScaffoldMessenger.of(context);
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
        label: 'hide',
        onPressed: scaffoldMessenger.hideCurrentSnackBar,
      ),
    ),
  );
}
