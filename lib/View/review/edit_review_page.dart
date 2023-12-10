import 'package:flutter/material.dart';
import 'package:ugdlayout2/repository/booking_repository.dart';

class EditReviewPage extends StatefulWidget {
  const EditReviewPage({super.key, required this.id, required this.komentar});
  final int id;
  final String komentar;

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  final BookingRepository bookingRepository = BookingRepository();
  TextEditingController komentarController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    komentarController.text = widget.komentar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Review")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: komentarController,
              minLines:
                  6, // any number you need (It works as the rows for the textarea)
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            ElevatedButton(
                onPressed: () async {
                  await bookingRepository.EditRoomReview(
                      widget.id, komentarController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Sukses edit komentae")));
                  Navigator.of(context).pop();
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
