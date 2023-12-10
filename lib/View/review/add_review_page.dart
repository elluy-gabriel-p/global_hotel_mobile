import 'package:flutter/material.dart';
import 'package:ugdlayout2/repository/booking_repository.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key, required this.idKamar});
  final int idKamar;

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final BookingRepository bookingRepository = BookingRepository();
  TextEditingController komentarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Review")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: komentarController,
              decoration: InputDecoration(hintText: "Masukkan review"),
              minLines:
                  6, // any number you need (It works as the rows for the textarea)
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            ElevatedButton(
                onPressed: () async {
                  await bookingRepository.AddRoomReview(
                      widget.idKamar, komentarController.text);

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Berhasil menambahkan")));
                  Navigator.of(context).pop();
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
