import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/Tubes/homeFix.dart';
import 'package:ugdlayout2/View/user/my_booking/history.dart';

class Success extends StatefulWidget {
  const Success({super.key,  required this.id, required this.checkin, required this.checkout, required this.jumlahOrang, required this.durasi, required this.tipe});
  final int id;
  final String checkin;
  final String checkout;
  final int jumlahOrang;
  final int durasi;
  final String tipe;

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Color.fromARGB(255, 35, 140, 152), // Background color
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      size: 200.0, // Adjust the size as needed
                      color: Colors.white, // Icon color
                    ),
                    Text(
                      'Check-in Success !',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  // Garis vertikal putus-putus
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                    ),
                                  ),
                                  // Teks "Booking List"
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Booking Detail',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // Garis vertikal putus-putus
                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${widget.durasi} Nights',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                'Tanggal Check In: ${widget.checkin}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                'Tanggal Check Out: ${widget.checkout}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                ': ${widget.jumlahOrang} person',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                'Booking Id: ${widget.id}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                '${widget.tipe}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Add a button at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeFix(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 65, 64, 64), // Button color
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
