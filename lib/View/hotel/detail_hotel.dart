import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ugdlayout2/View/hotel/detail_hotel.dart';
import 'package:ugdlayout2/View/hotel/list_kamar.dart';
import 'package:ugdlayout2/entity/hotel.dart';

class HotelDetPage extends StatefulWidget {
  const HotelDetPage({super.key, required this.hotel});
  final Hotel hotel;
  @override
  State<HotelDetPage> createState() => _HotelDetPageState();
}

class _HotelDetPageState extends State<HotelDetPage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int selectedGuests = 1;
  int selectedRooms = 1;

  void _showDateTimePicker(bool isCheckIn) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );

    if (picked != null) {
      setState(() {
        checkInDate = picked.start;
        checkOutDate = picked.end;
      });
    }
  }

  void _showGuestsAndRoomsModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (selectedGuests > 1) {
                        selectedGuests--;

                        setState(() {});
                      }
                    },
                  ),
                  Text('$selectedGuests'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      selectedGuests++;

                      setState(() {});
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Rooms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (selectedRooms > 1) {
                        setState(() {
                          selectedRooms--;
                        });
                      }
                    },
                  ),
                  Text('$selectedRooms'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        selectedRooms++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Apply'),
              ),
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
        centerTitle: true,
        title: Text(
          '${widget.hotel.nama}',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // This line will navigate back
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              // width: MediaQuery.of(context).size.width,
              child: Image.network(
                'https://source.unsplash.com/random/?room,hotel',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.hotel.nama}',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      width:
                          8.0), // Adjust the spacing between hotel name and harga spesial
                  Text(
                    'Harga ${widget.hotel.harga}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.star, color: Colors.yellow, size: 24),
                  Text("${widget.hotel.rating}",
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Check-in & Check-out section
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 24),
                        SizedBox(width: 3.0),
                        GestureDetector(
                          onTap: () => _showDateTimePicker(true),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                checkInDate == null
                                    ? Text(
                                        'Check in & Check out',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        '${formatDate(checkInDate!)} -\n${formatDate(checkOutDate!)}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                SizedBox(height: 4.0),
                                // Container(
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Padding(
                                //         padding: const EdgeInsets.all(2.0),
                                //         child: Text(
                                //           checkInDate != null &&
                                //                   checkOutDate != null
                                //               ? '${checkInDate!.day} ${_getMonthName(checkInDate!.month)}, ${_getWeekdayName(checkInDate!.weekday)} - ${checkOutDate!.day} ${_getMonthName(checkOutDate!.month)}, ${_getWeekdayName(checkOutDate!.weekday)},'
                                //               : 'Select Dates',
                                //           style: TextStyle(
                                //             fontSize: 10,
                                //             fontWeight: FontWeight.bold,
                                //             color: Colors.blue,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Guest & Rooms section
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.people, size: 24),
                        SizedBox(width: 3.0),
                        GestureDetector(
                          onTap: () => _showGuestsAndRoomsModal(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Guest & Rooms',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          '$selectedGuests Guest / $selectedRooms Room',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'About the Hotel',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left, // Menambahkan textAlign ke kiri
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.hotel.deskripsi)),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => listKamarPage(
                    checkinDate: checkInDate!,
                    checkoutDate: checkOutDate!,
                    jumlahOrang: selectedGuests,
                    jumlahKamar: selectedRooms,

                  ),));
                },
                child: Text("Book Hotel"))

            // Harga Normal section
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (_) => listKamar(
            //                       hotel: widget.hotel,
            //                     )));
            //       },
            //       style: ElevatedButton.styleFrom(
            //         primary: Colors.blue[900], // Dark blue background color
            //       ),
            //       child: Text(
            //         'BOOK',
            //         style: TextStyle(fontSize: 18),
            //       ),
            //     ),
            //   ),
            // ),

            // ... existing code ...
          ],
        ),
      ),
    );
  }
}

class HotelDetailPage extends StatefulWidget {
  final Hotel hotel;

  HotelDetailPage({required this.hotel});

  @override
  _HotelDetailPageState createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int selectedGuests = 1;
  int selectedRooms = 1;

  void _showDateTimePicker(bool isCheckIn) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );

    if (selectedDate != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = selectedDate;
        } else {
          checkOutDate = selectedDate;
        }
      });
    }
  }

  void _showGuestsAndRoomsModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (selectedGuests > 1) {
                        setState(() {
                          selectedGuests--;
                        });
                      }
                    },
                  ),
                  Text('$selectedGuests'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        selectedGuests++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Rooms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (selectedRooms > 1) {
                        setState(() {
                          selectedRooms--;
                        });
                      }
                    },
                  ),
                  Text('$selectedRooms'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        selectedRooms++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Apply'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text(
    //       '${widget.hotel.nama}',
    //       style: TextStyle(color: Colors.black),
    //     ),
    //     backgroundColor: Color.fromARGB(217, 217, 217, 217),
    //     leading: IconButton(
    //       icon: Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.of(context).pop(); // This line will navigate back
    //       },
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         Container(
    //           // width: MediaQuery.of(context).size.width,
    //           child: Image.network(
    //             'https://source.unsplash.com/random/?room,hotel',
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 '${widget.hotel.nama}',
    //                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(
    //                   width:
    //                       8.0), // Adjust the spacing between hotel name and harga spesial
    //               Text(
    //                 'Harga\n1.2 Juta',
    //                 style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.blueAccent),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Row(
    //             children: <Widget>[
    //               Icon(Icons.star, color: Colors.yellow, size: 24),
    //               Text(' 4.8', style: TextStyle(fontSize: 18)),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           margin: EdgeInsets.symmetric(vertical: 10.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               // Check-in & Check-out section
    //               Container(
    //                 padding: EdgeInsets.all(10.0),
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey[200],
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     Icon(Icons.calendar_today, size: 24),
    //                     SizedBox(width: 3.0),
    //                     GestureDetector(
    //                       onTap: () => _showDateTimePicker(true),
    //                       child: Container(
    //                         padding: EdgeInsets.symmetric(
    //                             vertical: 5, horizontal: 2),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'Check in & Check out',
    //                               style: TextStyle(
    //                                 fontSize: 15,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                             SizedBox(height: 4.0),
    //                             Container(
    //                               child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Padding(
    //                                     padding: const EdgeInsets.all(2.0),
    //                                     child: Text(
    //                                       checkInDate != null &&
    //                                               checkOutDate != null
    //                                           ? '${checkInDate!.day} ${_getMonthName(checkInDate!.month)}, ${_getWeekdayName(checkInDate!.weekday)} - ${checkOutDate!.day} ${_getMonthName(checkOutDate!.month)}, ${_getWeekdayName(checkOutDate!.weekday)},'
    //                                           : 'Select Dates',
    //                                       style: TextStyle(
    //                                         fontSize: 10,
    //                                         fontWeight: FontWeight.bold,
    //                                         color: Colors.blue,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),

    //               // Guest & Rooms section
    //               Container(
    //                 padding: EdgeInsets.all(10.0),
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey[200],
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     Icon(Icons.people, size: 24),
    //                     SizedBox(width: 3.0),
    //                     GestureDetector(
    //                       onTap: () => _showGuestsAndRoomsModal(),
    //                       child: Container(
    //                         padding: EdgeInsets.symmetric(
    //                             vertical: 5, horizontal: 2),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Text(
    //                               'Guest & Rooms',
    //                               style: TextStyle(
    //                                 fontSize: 15,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                             SizedBox(height: 4.0),
    //                             Container(
    //                               child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Padding(
    //                                     padding: const EdgeInsets.all(2.0),
    //                                     child: Text(
    //                                       '$selectedGuests Guest / $selectedRooms Room',
    //                                       style: TextStyle(
    //                                         fontSize: 10,
    //                                         fontWeight: FontWeight.bold,
    //                                         color: Colors.blue,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             'About the Hotel',
    //             style: TextStyle(
    //               fontSize: 18,
    //               fontWeight: FontWeight.bold,
    //             ),
    //             textAlign: TextAlign.left, // Menambahkan textAlign ke kiri
    //           ),
    //         ),

    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //               'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
    //         ),

    //         // Harga Normal section
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             width: double.infinity,
    //             child: ElevatedButton(
    //               onPressed: () {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (_) => listKamar(
    //                               hotel: widget.hotel,
    //                             )));
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 primary: Colors.blue[900], // Dark blue background color
    //               ),
    //               child: Text(
    //                 'BOOK',
    //                 style: TextStyle(fontSize: 18),
    //               ),
    //             ),
    //           ),
    //         ),

    //         // ... existing code ...
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Text('hello'),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return monthNames[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdayNames = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    return weekdayNames[weekday - 1];
  }
}
String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
