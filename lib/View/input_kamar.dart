import 'package:flutter/material.dart';
import 'package:ugdlayout2/entity/kamar.dart';
import 'package:ugdlayout2/database/sql_helper_kamar.dart';

class InputKamarPage extends StatefulWidget {
  const InputKamarPage({
    Key? key,
    required this.title,
    required this.id,
    required this.tipe,
    required this.harga,
    required this.kapasitas,
    this.status,
  }) : super(key: key);

  final String? title, tipe, status;
  final int? id, harga, kapasitas;

  @override
  State<InputKamarPage> createState() => _InputKamarPageState();
}

class _InputKamarPageState extends State<InputKamarPage> {
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
        title: Text("INPUT KAMAR"),
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
    final harga = int.parse(controllerHarga.text);
    final kapasitas = int.parse(controllerKapasitas.text);
    final status = controllerStatus.text;
    
    await SQLHelper.addKamar(tipe, harga, kapasitas, status);
  }

  Future<void> editKamar(int id) async {
    final tipe = controllerTipe.text;
    final harga = int.parse(controllerHarga.text);
    final kapasitas = int.parse(controllerKapasitas.text);
    final status = controllerStatus.text;

    await SQLHelper.editKamar(id, tipe, harga, kapasitas, status);
  }
}

