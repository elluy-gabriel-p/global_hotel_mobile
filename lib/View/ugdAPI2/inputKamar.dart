import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugdlayout2/database/kamar_Database.dart';
import 'package:ugdlayout2/entity/kamar.dart';
import 'package:ugdlayout2/View/ugdAPI2/kamarPage.dart';

class inputKamar extends StatefulWidget {
  const inputKamar({super.key, this.id});
  final int? id;

  @override
  State<inputKamar> createState() => _inputKamarState();
}

class _inputKamarState extends State<inputKamar> {
  final _formKey = GlobalKey<FormState>();
  final tipeController = TextEditingController();
  final hargaController = TextEditingController();
  final kapasitasController = TextEditingController();
  final statusController = TextEditingController();
  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Kamar kamar = await KamarClient.find(widget.id);
      setState(() {
        isLoading = false;
        tipeController.value = TextEditingValue(text: kamar.tipe);
        hargaController.value = TextEditingValue(text: kamar.harga.toString());
        kapasitasController.value =
            TextEditingValue(text: kamar.kapasitas.toString());
        statusController.value = TextEditingValue(text: kamar.status);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      if (!_formKey.currentState!.validate()) return;

      Kamar input = Kamar(
        id: widget.id ?? 0,
        tipe: tipeController.text,
        harga: int.parse(hargaController.text),
        kapasitas: int.parse(kapasitasController.text),
        status: statusController.text,
      );

      try {
        if (widget.id == null) {
          await KamarClient.create(input);
        } else {
          await KamarClient.update(input);
        }

        showSnackBar(context, "Success", Colors.green);
        Navigator.pop(context);
      } catch (err) {
        showSnackBar(context, err.toString(), Colors.red);
        Navigator.pop(context);
      }
    }

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
                        child: Text(
                          widget.id == null ? 'Tambah' : 'Edit',
                        ),
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}
