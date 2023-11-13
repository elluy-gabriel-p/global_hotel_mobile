import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ugdlayout2/database/sql_helper_kamar.dart';
import 'package:image_picker/image_picker.dart';

class InputKamarPage extends StatefulWidget {
  const InputKamarPage({
    Key? key,
    required this.title,
    required this.id,
    required this.tipe,
    required this.harga,
    required this.kapasitas,
    this.status,
    required this.roomImage,
  }) : super(key: key);

  final String? title, tipe, status;
  final int? id, harga, kapasitas;
  final Uint8List? roomImage;

  @override
  State<InputKamarPage> createState() => _InputKamarPageState();
}

class _InputKamarPageState extends State<InputKamarPage> {
  TextEditingController controllerTipe = TextEditingController();
  TextEditingController controllerHarga = TextEditingController();
  TextEditingController controllerKapasitas = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();

  // Use a mutable variable to hold the image
  Uint8List? _mutableRoomImage;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      controllerTipe.text = widget.tipe!;
      controllerHarga.text = widget.harga.toString();
      controllerKapasitas.text = widget.kapasitas.toString();
      controllerStatus.text = widget.status!;
    }
    // Initialize the mutable image variable with the provided image
    _mutableRoomImage = widget.roomImage;
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedImage == null) return;
    final imageFile = File(pickedImage.path);
    final imageBytes = await imageFile.readAsBytes();

    // Update the mutable image variable
    setState(() {
      _mutableRoomImage = imageBytes;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);

    if (pickedImage == null) return;
    final imageFile = File(pickedImage.path);
    final imageBytes = await imageFile.readAsBytes();

    // Update the mutable image variable
    setState(() {
      _mutableRoomImage = imageBytes;
    });
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
            onPressed: _pickImageFromGallery,
            child: Text('Pick Image from Gallery'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _pickImageFromCamera,
            child: Text('Take a Picture'),
          ),
          SizedBox(height: 16),
          // Display the picked image if available
          if (_mutableRoomImage != null)
            Image.memory(
              _mutableRoomImage!,
              height: 100,
              width: 100,
            ),
          SizedBox(height: 16),
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
          ),
        ],
      ),
    );
  }

  Future<void> addKamar() async {
    final tipe = controllerTipe.text;
    final harga = int.parse(controllerHarga.text);
    final kapasitas = int.parse(controllerKapasitas.text);
    final status = controllerStatus.text;

    await SQLHelper.addKamar(tipe, harga, kapasitas, status, _mutableRoomImage);
  }

  Future<void> editKamar(int id) async {
    final tipe = controllerTipe.text;
    final harga = int.parse(controllerHarga.text);
    final kapasitas = int.parse(controllerKapasitas.text);
    final status = controllerStatus.text;

    await SQLHelper.editKamar(id, tipe, harga, kapasitas, status, _mutableRoomImage);
  }
}
