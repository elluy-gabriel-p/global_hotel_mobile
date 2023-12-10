import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ugdlayout2/database/review_Database.dart';
import 'package:ugdlayout2/entity/review.dart';
import 'package:ugdlayout2/View/ugdAPI2/reviewPage.dart';

class inputReview extends StatefulWidget {
  const inputReview({super.key, this.id});
  final int? id;

  @override
  State<inputReview> createState() => _inputReviewState();
}

class _inputReviewState extends State<inputReview> {
  final _formKey = GlobalKey<FormState>();
  final contentController = TextEditingController();
  bool isLoading = false;

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Review review = await ReviewClient.find(widget.id);
      setState(() {
        isLoading = false;
        contentController.value = TextEditingValue(text: review.content);
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

      Review input = Review(
        id: widget.id ?? 0,
        content: contentController.text,
      );

      try {
        if (widget.id == null) {
          await ReviewClient.create(input);
        } else {
          await ReviewClient.update(input);
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
                          labelText: 'Masukkan ulasan',
                        ),
                        controller: contentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                                      ],
                )),
      ),
    );
  }
}
