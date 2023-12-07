import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:io';
import 'package:ugdlayout2/database/login_database.dart';
import 'package:ugdlayout2/entity/hotel.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/widget/custom_text_form_field.dart';

class inputHotel extends StatefulWidget {
  const inputHotel({Key? key}) : super(key: key);

  @override
  State<inputHotel> createState() => _inputHotelState();
}

class _inputHotelState extends State<inputHotel> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerHarga = TextEditingController();
  TextEditingController controllerFasilitas = TextEditingController();

  double _rating = 0.0;
  double hargaInput = 0;
  String gambarPath = 'image/alam.jpg';
  String id = Uuid().v1();
  bool isUpdate = false;
  int updateId = 0;
  File? _imageFile;

  void initState() {
    super.initState();
  }

  Future<void> insertData() async {
    try {
      if (_imageFile != null) {}
      Hotel hotel = Hotel(
        nama: controllerNama.text,
        alamat: controllerAlamat.text,
        deskripsi: controllerDeskripsi.text,
        harga: double.parse(controllerHarga.text),
        fasilitas: controllerFasilitas.text,
        rating: _rating,
        gambar: null,
      );

      await HotelClient.create(hotel);
      print('Data Hotel Berhasil DiBuat!');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (returnedImage == null) return;
    final imageFile = File(returnedImage.path);

    setState(() {
      _imageFile = imageFile;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final returnedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);

    if (returnedImage == null) return;
    final imageFile = File(returnedImage.path);

    setState(() {
      _imageFile = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data Hotel"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          CustomTextFormField(
            controller: controllerNama,
            hintText: 'Nama',
            validator: (value) =>
                value == '' ? 'Nama tidak boleh kosong' : null,
          ),
          SizedBox(height: 12),
          Container(
            height: 200,
            child: CustomTextFormField(
              controller: controllerAlamat,
              hintText: 'Alamat',
              maxLines: 10,
              contentPadding: EdgeInsets.all(10),
              validator: (value) =>
                  value == '' ? 'Alamat tidak boleh kosong' : null,
            ),
          ),
          SizedBox(height: 12),
          CustomTextFormField(
            controller: controllerDeskripsi,
            hintText: 'Deskripsi',
            validator: (value) =>
                value == '' ? 'Deskripsi tidak boleh kosong' : null,
          ),
          SizedBox(height: 12),
          CustomTextFormField(
            controller: controllerHarga,
            keyboardType: TextInputType.number,
            validator: (value) =>
                value == '' ? 'Harga tidak boleh kosong' : null,
          ),
          SizedBox(height: 12),
          CustomTextFormField(
            controller: controllerFasilitas,
            hintText: 'Fasilitas',
            validator: (value) =>
                value == '' ? 'Fasilitas tidak boleh kosong' : null,
          ),
          // SizedBox(20),
          // Padding(
          //   padding: EdgeInsets.only(left: 10),
          //   child: Text(
          //     'Pick Image',
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.grey,
          //       fontFamily: 'Poppins',
          //     ),
          //   ),
          // ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: Text("Gallery"),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: _pickImageFromCamera,
                child: Text("Camera"),
              ),
            ],
          ),
          SizedBox(height: 24),
          _imageFile != null
              ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(_imageFile!),
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Rating: $_rating',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
          RatingBar.builder(
            initialRating: _rating,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 48,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              // if (isUpdate) {
              //   await updateData();
              // } else {
              //   await insertData();
              // }
              await insertData();
              Navigator.pop(context);
            },
            child: Text("Simpan Data"),
          ),
        ],
      ),
    );
  }
}
