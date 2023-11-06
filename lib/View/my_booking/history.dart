import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/my_booking/on_going.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Booking'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OnGoing(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 35, 140, 152),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("On Going"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => History(),
                    ));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Mengatur latar belakang menjadi transparan
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(
                            255, 35, 140, 152), // Warna garis tepi
                        width: 2.0, // Lebar garis tepi
                      ),
                      borderRadius: BorderRadius.circular(
                          20), // Mengatur sudut melengkung
                    ),
                  ),
                  child: const Text(
                    "History",
                    style: TextStyle(
                      color: Color.fromARGB(255, 35, 140, 152), // Warna teks
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                ),
                              ),
                              // Teks "Booking List"
                              const Padding(
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '2 Nights',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Tanggal Check In',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Tanggal Check Out',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            '2 person',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Booking Id',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Luxury Hotel',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            color: Colors.grey, // Warna garis
                            thickness: 1, // Ketebalan garis
                            height: 20, // Tinggi garis
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Aksi yang akan dijalankan saat tombol pertama ditekan
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255,
                                        30, 145, 182), // Warna latar belakang
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // BorderRadius di sini
                                    ),
                                  ),
                                  child: const Text("REVIEW"),
                                ),
                                const SizedBox(
                                  width:
                                      20, // Jarak antara tombol pertama dan kedua
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
