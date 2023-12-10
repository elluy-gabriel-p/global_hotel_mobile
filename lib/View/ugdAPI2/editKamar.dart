import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/ugdAPI2/kamarPage.dart';
import 'package:ugdlayout2/database/kamar_Database.dart';
import 'package:ugdlayout2/entity/kamar.dart';
import 'package:ugdlayout2/repository/booking_repository.dart';

class EditKamarPage extends StatefulWidget {
  const EditKamarPage({super.key, required this.kamar});
  final Kamar kamar;

  @override
  State<EditKamarPage> createState() => _EditKamarPageState();
}

class _EditKamarPageState extends State<EditKamarPage> {
  final BookingRepository bookingRepository = BookingRepository();
  final _formKey = GlobalKey<FormState>();
  final tipeController = TextEditingController();
  final hargaController = TextEditingController();
  final kapasitasController = TextEditingController();
  final statusController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tipeController.text = widget.kamar.tipe;
    hargaController.text = widget.kamar.harga.toString();
    kapasitasController.text = widget.kamar.kapasitas.toString();
    statusController.text = widget.kamar.status.toString();
  }

  void onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await bookingRepository.DoUpdateKamar(Kamar(
          id: widget.kamar.id,
          tipe: tipeController.text,
          harga: int.parse(hargaController.text),
          kapasitas: int.parse(kapasitasController.text),
          status: statusController.text));

      showSnackBar(context, "Success", Colors.green);
      Navigator.pop(context);
    } catch (err) {
      showSnackBar(context, err.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan Tipe',
                        ),
                        controller: tipeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan harga',
                        ),
                        controller: hargaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan kapasitas',
                        ),
                        controller: kapasitasController,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Masukkan status',
                        ),
                        controller: statusController,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        child: Text("Edit"),
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}
