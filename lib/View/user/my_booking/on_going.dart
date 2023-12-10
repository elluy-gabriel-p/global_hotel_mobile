// import 'package:flutter/material.dart';
// import 'package:ugdlayout2/View/user/my_booking/history.dart';
// import 'package:ugdlayout2/View/user/my_booking/check_in/scan_qr_page.dart';
// import 'package:ugdlayout2/repository/booking_repository.dart';

// class OnGoing extends StatefulWidget {
//   const OnGoing({super.key});

//   @override
//   State<OnGoing> createState() => _OnGoingState();
// }

// class _OnGoingState extends State<OnGoing> {
  
//   final BookingRepository bookingRepository = BookingRepository();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Booking'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => OnGoing(),
//                     ));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromARGB(255, 35, 140, 152),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text("On Going"),
//                 ),
//                 SizedBox(
//                   width: 20,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => History(),
//                     ));
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors
//                         .transparent, // Mengatur latar belakang menjadi transparan
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(
//                         color: Color.fromARGB(
//                             255, 35, 140, 152), // Warna garis tepi
//                         width: 2.0, // Lebar garis tepi
//                       ),
//                       borderRadius: BorderRadius.circular(
//                           20), // Mengatur sudut melengkung
//                     ),
//                   ),
//                   child: Text(
//                     "History",
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 35, 140, 152), // Warna teks
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16),
//               children: <Widget>[
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 3,
//                             blurRadius: 7,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Row(
//                             children: [
//                               // Garis vertikal putus-putus
//                               Expanded(
//                                 child: Container(
//                                   height: 1,
//                                   color: Colors.grey,
//                                   margin: EdgeInsets.symmetric(horizontal: 8.0),
//                                 ),
//                               ),
//                               // Teks "Booking List"
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Booking Detail',
//                                   style: TextStyle(
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               // Garis vertikal putus-putus
//                               Expanded(
//                                 child: Container(
//                                   height: 1,
//                                   color: Colors.grey,
//                                   margin: EdgeInsets.symmetric(horizontal: 8.0),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             '2 Nights',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 16.0,
//                           ),
//                           Text(
//                             'Tanggal Check In',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 16.0,
//                           ),
//                           Text(
//                             'Tanggal Check Out',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 16.0,
//                           ),
//                           Text(
//                             '2 person',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 16.0,
//                           ),
//                           Text(
//                             'Booking Id',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 16.0,
//                           ),
//                           Text(
//                             'Luxury Hotel',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Divider(
//                             color: Colors.grey, // Warna garis
//                             thickness: 1, // Ketebalan garis
//                             height: 20, // Tinggi garis
//                           ),
//                           Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     Navigator.of(context)
//                                         .push(MaterialPageRoute(
//                                       builder: (context) =>
//                                           BarcodeScannerPageView(),
//                                     ));
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: Color.fromARGB(255, 35, 140,
//                                         152), // Warna latar belakang
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           20), // BorderRadius di sini
//                                     ),
//                                   ),
//                                   child: Text("CHECK - IN"),
//                                 ),
//                                 SizedBox(
//                                   width:
//                                       20, // Jarak antara tombol pertama dan kedua
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Aksi yang akan dijalankan saat tombol kedua ditekan
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     primary: Colors.red, // Warna latar belakang
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(
//                                           20), // BorderRadius di sini
//                                     ),
//                                   ),
//                                   child: Text("CENCEL BOOKING"),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
