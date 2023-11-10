import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugdlayout2/database/sql_helper_kamar.dart';
import 'package:ugdlayout2/entity/kamar.dart';
import 'package:ugdlayout2/View/user/profile/profile.dart';

class KamarPage extends StatefulWidget {
  const KamarPage({Key? key, required this.title, this.dataImage})
      : super(key: key);

  final String title;
  final Uint8List? dataImage; // Ensure this line is present

  @override
  State<KamarPage> createState() => _KamarPageState();
}

class _KamarPageState extends State<KamarPage> {
  List<Map<String, dynamic>> kamar = [];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    final data = await SQLHelper.getKamar();
    setState(() {
      kamar = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? image = widget.dataImage; // Ensure this line is present

    return Scaffold(
      appBar: AppBar(
        title: Text("KAMAR"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KamarPage(
                    title: 'KAMAR',
                    dataImage: imageProfile, // Now imageProfile is accessible
                  ),
                ),
              ).then((_) => refresh());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: kamar.length,
        itemBuilder: (context, index) {
          return Slidable(
            child: ListTile(
              title: Text(kamar[index]['tipe']),
              subtitle: Text(
                "${kamar[index]['harga']} ${kamar[index]['kapasitas']} ${kamar[index]['status']}",
              ),
            ),
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: 'Update',
                color: Colors.blue,
                icon: Icons.update,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputKamarDetailsPage(
                        title: 'UPDATE KAMAR',
                        id: kamar[index]['id'],
                        tipe: kamar[index]['tipe'],
                        harga: kamar[index]['harga'],
                        kapasitas: kamar[index]['kapasitas'],
                        status: kamar[index]['status'],
                      ),
                    ),
                  ).then((_) => refresh());
                },
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () async {
                  await deleteKamar(kamar[index]['id']);
                },
              ),
              IconSlideAction(
                caption: 'Detail',
                color: Colors.green,
                icon: Icons.list,
                onTap: () {
                  if (image == null ||
                      kamar[index]['tipe'].isEmpty ||
                      kamar[index]['harga'].isEmpty ||
                      kamar[index]['kapasitas'].isEmpty ||
                      kamar[index]['status'].isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Warning'),
                        content: const Text('Please fill in all the fields.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputKamarDetailsPage(
                          title: 'Detail Kamar',
                          dataImage: widget.dataImage,
                          id: kamar[index]['id'],
                          tipe: kamar[index]['tipe'],
                          harga: kamar[index]['harga'],
                          kapasitas: kamar[index]['kapasitas'],
                          status: kamar[index]['status'],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> deleteKamar(int id) async {
    await SQLHelper.deleteKamar(id);
    refresh();
  }
}

class InputKamarDetailsPage extends StatefulWidget {
  const InputKamarDetailsPage({
    Key? key,
    required this.title,
    this.id,
    this.tipe,
    this.harga,
    this.kapasitas,
    this.status,
  }) : super(key: key);

  final String title;
  final int? id;
  final String? tipe, status;
  final int? harga, kapasitas;

  @override
  State<InputKamarDetailsPage> createState() => _InputKamarDetailsPageState();
}

class _InputKamarDetailsPageState extends State<InputKamarDetailsPage> {
  TextEditingController controllerTipe = TextEditingController();
  TextEditingController controllerHarga = TextEditingController();
  TextEditingController controllerKapasitas = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      controllerTipe.text = widget.tipe!;
      controllerHarga.text = widget.harga.toString();
      controllerKapasitas.text = widget.kapasitas.toString();
      controllerStatus.text = widget.status!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerTipe,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Tipe',
            ),
          ),
          SizedBox(height: 24),
          TextField(
            controller: controllerHarga,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Harga',
            ),
          ),
          SizedBox(height: 34),
          TextField(
            controller: controllerKapasitas,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Kapasitas',
            ),
          ),
          SizedBox(height: 44),
          TextField(
            controller: controllerStatus,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Status',
            ),
          ),
          SizedBox(height: 54),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              if (widget.id == null) {
                await addKamar();
              } else {
                await editKamar(widget.id!);
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> addKamar() async {
    final tipe = controllerTipe.text;
    final harga = int.tryParse(controllerHarga.text) ?? 0;
    final kapasitas = int.tryParse(controllerKapasitas.text) ?? 0;
    final status = controllerStatus.text;

    await SQLHelper.addKamar(tipe, harga, kapasitas, status);
  }

  Future<void> editKamar(int id) async {
    final tipe = controllerTipe.text;
    final harga = int.tryParse(controllerHarga.text) ?? 0;
    final kapasitas = int.tryParse(controllerKapasitas.text) ?? 0;
    final status = controllerStatus.text;

    await SQLHelper.editKamar(id, tipe, harga, kapasitas, status);
  }
}
