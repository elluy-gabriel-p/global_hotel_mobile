import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ugdlayout2/View/pdf_view.dart';
import 'package:ugdlayout2/database/sql_helper_kamar.dart';
import 'package:ugdlayout2/entity/kamar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ugdlayout2/database/kamar_Database.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:uuid/uuid.dart';

class KamarPage extends StatefulWidget {
  const KamarPage({super.key, required this.title});

  final String title;

  @override
  State<KamarPage> createState() => _KamarPageState();
}

class _KamarPageState extends State<KamarPage> {
  List<Map<String, dynamic>> kamar = [];
  String tipe = "";
  int harga = 0;
  int kapasitas = 0;
  String status = "";
  String id = Uuid().v1();
  Uint8List? roomImage;

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
                  builder: (context) => InputKamarDetailsPage(
                    title: 'INPUT KAMAR',
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
            actionPane: const SlidableDrawerActionPane(),
            secondaryActions: [
              IconSlideAction(
                caption: 'PDF',
                color: Colors.deepOrange[700],
                icon: Icons.insert_drive_file,
                onTap: () async {
                  tipe = kamar[index]['tipe'];
                  harga = kamar[index]['harga'];
                  kapasitas = kamar[index]['kapasitas'];
                  status = kamar[index]['status'];
                  roomImage = kamar[index]['roomImage'];

                  // Continue with your existing code
                  setState(() {
                    const uuid = Uuid();
                    id = uuid.v1();
                  });
                  createPdf(tipe, harga, kapasitas, id, status, roomImage, context);
                },
              ),
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
                        roomImage: kamar[index]['roomImage'],
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
            ],
            child: ListTile(
              leading: kamar[index]['roomImage'] != null
                  ? Image.memory(
                      kamar[index]['roomImage'],
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 50, height: 50), // Customize container size
              title: Text(kamar[index]['tipe']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Harga",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 50), // Sesuaikan lebar sesuai kebutuhan
                      Expanded(
                        child: Text(
                          ": Rp. ${kamar[index]['harga']}",
                          style: TextStyle(
                            fontSize: 16, // Sesuaikan ukuran sesuai kebutuhan
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Kapasitas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 22), // Sesuaikan lebar sesuai kebutuhan
                      Expanded(
                        child: Text(
                          ": ${kamar[index]['kapasitas']}",
                          style: TextStyle(
                            fontSize: 16, // Sesuaikan ukuran sesuai kebutuhan
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 48), // Sesuaikan lebar sesuai kebutuhan
                      Expanded(
                        child: Text(
                          ": ${kamar[index]['status']}",
                          style: TextStyle(
                            fontSize: 16, // Sesuaikan ukuran sesuai kebutuhan
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
    this.roomImage,
  }) : super(key: key);

  final String title;
  final int? id;
  final String? tipe, status;
  final int? harga, kapasitas;
  final Uint8List? roomImage;

  @override
  State<InputKamarDetailsPage> createState() => _InputKamarDetailsPageState();
}

class _InputKamarDetailsPageState extends State<InputKamarDetailsPage> {
  TextEditingController controllerTipe = TextEditingController();
  TextEditingController controllerHarga = TextEditingController();
  TextEditingController controllerKapasitas = TextEditingController();
  TextEditingController controllerStatus = TextEditingController();

  Uint8List? _mutableRoomImage;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      controllerTipe.text = widget.tipe!;
      controllerHarga.text = widget.harga.toString();
      controllerKapasitas.text = widget.kapasitas.toString();
      controllerStatus.text = widget.status!;
      _mutableRoomImage = widget.roomImage ?? Uint8List(0);
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedImage == null) return;
    final imageFile = File(pickedImage.path);
    final imageBytes = await imageFile.readAsBytes();

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

    setState(() {
      _mutableRoomImage = imageBytes;
    });
  }

  Future<void> _showImagePickerModal() async {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: 100.0,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: <Widget>[
              Text(
                "Choose Room Image",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: _pickImageFromCamera,
                    icon: Icon(Icons.camera),
                    label: Text("Camera"),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickImageFromGallery,
                    icon: Icon(Icons.image),
                    label: Text('Gallery'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
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
          // Image picker button
          ElevatedButton.icon(
            onPressed: _showImagePickerModal,
            icon: Icon(Icons.add_a_photo),
            label: Text("Choose Room Image"),
          ),
          SizedBox(height: 16),

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
    final harga = int.tryParse(controllerHarga.text) ?? 0;
    final kapasitas = int.tryParse(controllerKapasitas.text) ?? 0;
    final status = controllerStatus.text;

    await SQLHelper.addKamar(tipe, harga, kapasitas, status, _mutableRoomImage);
  }

  Future<void> editKamar(int id) async {
    final tipe = controllerTipe.text;
    final harga = int.tryParse(controllerHarga.text) ?? 0;
    final kapasitas = int.tryParse(controllerKapasitas.text) ?? 0;
    final status = controllerStatus.text;

    await SQLHelper.editKamar(
        id, tipe, harga, kapasitas, status, _mutableRoomImage);
  }
}
