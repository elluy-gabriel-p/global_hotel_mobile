import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ugdlayout2/View/Tubes/serviceView.dart';

class SuccessBooking extends StatefulWidget {
  const SuccessBooking({Key? key}) : super(key: key);

  @override
  State<SuccessBooking> createState() => _SuccessBookingState();
}

class _SuccessBookingState extends State<SuccessBooking> {
  final TextEditingController bookingIdController = TextEditingController();
  final TextEditingController bookingDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  width: double.infinity,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 213, 225, 233),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/success.json', height: 300),
                      SizedBox(height: 10.0),
                      Text(
                        'Booking Successful!',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    height: 250,
                    width: 350.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 350.0,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 209, 211, 213),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -20,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -20,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Luxury Hotel',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Divider(
                                color: const Color.fromARGB(255, 134, 141, 148),
                                height: 20,
                                thickness: 2,
                                indent: 5,
                                endIndent: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 20.0,
                                  top: 20.0,
                                  right: 20.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            '1 Person',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                      height: 50,
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Booking ID',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[800],
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          TextFormField(
                                            controller: bookingIdController,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                      height: 50,
                                      width: 2,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Date',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[800],
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          TextFormField(
                                            controller: bookingDateController,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const ServiceView(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: const Color.fromARGB(
                                          255, 70, 87, 106),
                                      onPrimary: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15.0,
                                        horizontal: 30.0,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    child: Text(
                                      'Service Hotel',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 20),
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     // Handle second button press
                                  //   },
                                  //   style: ElevatedButton.styleFrom(
                                  //     primary: Colors.green,
                                  //     onPrimary: Colors.white,
                                  //     padding: EdgeInsets.symmetric(
                                  //       vertical: 15.0,
                                  //       horizontal: 30.0,
                                  //     ),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //     ),
                                  //   ),
                                  //   child: Text(
                                  //     'Button 2',
                                  //     style: TextStyle(
                                  //       fontSize: 15.0,
                                  //       fontWeight: FontWeight.bold,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
