import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ugdlayout2/View/Tubes/homeContent.dart';
import 'package:ugdlayout2/View/Tubes/homeFix.dart';
import 'dart:io';
import 'package:ugdlayout2/database/login_database.dart';
import 'package:ugdlayout2/entity/hotel.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/widget/custom_text_form_field.dart';

class InputHotel extends StatefulWidget {
  final Hotel? hotel;

  const InputHotel({Key? key, this.hotel}) : super(key: key);

  @override
  State<InputHotel> createState() => _InputHotelState();
}

class _InputHotelState extends State<InputHotel> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerHarga = TextEditingController();
  TextEditingController controllerFasilitas = TextEditingController();
  final formKey = GlobalKey<FormState>();

  double _rating = 0.0;
  int updateId = 0;
  File? _imageFile;
  bool isUpdate = false;

  void initState() {
    super.initState();
    cekUpdate();
    if (widget.hotel != null) {
      Hotel hotel = widget.hotel!;
      setState(() {
        _rating = hotel.rating ?? 0;
        controllerNama.text = hotel.nama ?? '';
        controllerAlamat.text = hotel.alamat ?? '';
        controllerDeskripsi.text = hotel.deskripsi ?? '';
        controllerHarga.text = hotel.harga.toString();
        controllerFasilitas.text = hotel.fasilitas ?? '';
        updateId = hotel.id ?? 0;
      });

      setState(() {
        isUpdate = true;
      });
    }
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insert Hotel Success'),
          backgroundColor: Colors.green,
        ),
      );
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

  Future<void> updateData() async {
    try {
      print("A");
      Hotel hotel = Hotel(
        id: updateId,
        nama: controllerNama.text,
        alamat: controllerAlamat.text,
        deskripsi: controllerDeskripsi.text,
        harga: double.parse(controllerHarga.text),
        fasilitas: controllerFasilitas.text,
        gambar: null,
        rating: _rating,
      );
      print("AA");

      await HotelClient.update(hotel);
      print('Data Berhasil di Update');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Update Hotel Success'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> cekUpdate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('idUpdate')) {
        int idHotelUpdate = prefs.getInt('idUpdate') ?? 0;

        final hotel = await HotelClient.find(idHotelUpdate);

        setState(() {
          _rating = hotel.rating ?? 0;
          controllerNama.text = hotel.nama ?? '';
          controllerAlamat.text = hotel.alamat ?? '';
          controllerDeskripsi.text = hotel.deskripsi ?? '';
          controllerHarga.text = hotel.harga.toString();
          controllerFasilitas.text = hotel.fasilitas ?? '';
          updateId = hotel.id ?? 0;
        });

        setState(() {
          isUpdate = true;
        });
      }
    } catch (e) {
      print('Error di retrieve update data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Update Objek Wisata" : "Insert Data Hotel"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
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
                if (formKey.currentState!.validate()) {
                  if (isUpdate) {
                    await updateData();
                  } else {
                    await insertData();
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeFix(),
                    ),
                  );
                }
              },
              child: Text("Simpan Data"),
            ),
          ],
        ),
      ),
    );
  }
}
