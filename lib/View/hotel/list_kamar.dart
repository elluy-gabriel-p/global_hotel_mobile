import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/hotel/FormBooking.dart';
import 'package:ugdlayout2/database/kamar_Database.dart';
import 'package:ugdlayout2/entity/hotel.dart';
import 'package:ugdlayout2/entity/kamar.dart';

class listKamarPage extends StatefulWidget {
  const listKamarPage(
      {super.key,
      required this.checkinDate,
      required this.checkoutDate,
      required this.jumlahOrang,
      required this.jumlahKamar});
  final DateTime checkinDate;
  final DateTime checkoutDate;
  final int jumlahOrang;
  final int jumlahKamar;

  @override
  State<listKamarPage> createState() => _listKamarPageState();
}

class _listKamarPageState extends State<listKamarPage> {
  late Future<List<Kamar>> _listBarangFuture;
  @override
  void initState() {
    super.initState();
    _listBarangFuture = KamarClient.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Pilih Kamar',
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
          body: FutureBuilder(
            future: _listBarangFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                color: Color.fromARGB(255, 238, 237, 237),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 1.5,
                                    spreadRadius: 0.5,
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Text(
                                              '${snapshot.data![index].tipe}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              'Non-Refundable',
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '-Harga untuk ${snapshot.data![index].kapasitas} Orang Dewasa',
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                            Text(
                                              '-1 Extra-large double bed',
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                            Text(
                                              '-Room size: 14x14',
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.coffee,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Text(
                                                  'Breakfast included',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 10.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.bathtub,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Text(
                                                  'Private Bathroom',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 10.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.wifi,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Text(
                                                  'Free WiFi',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 10.0),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons.ac_unit,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                Text(
                                                  'Air Conditioning',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 10.0),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Text('Harga 1 malam'),
                                        Text(
                                          'Rp. ${snapshot.data![index].harga}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue.shade500,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            FormBooking(
                                                              id: snapshot
                                                                  .data![index]
                                                                  .id,
                                                              checkinDate: widget
                                                                  .checkinDate,
                                                              checkoutDate: widget.checkoutDate,
                                                              jumlahKamar: widget.jumlahKamar,
                                                              jumlahOrang: widget.jumlahOrang,
                                                              harga: snapshot.data![index].harga,
                                                            )));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  side: BorderSide(
                                                    color: Colors.blue.shade500,
                                                  ),
                                                  primary: Color.fromARGB(
                                                      255, 238, 237, 237),
                                                  onPrimary:
                                                      Colors.blue.shade500,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0))),
                                              child: Text(
                                                'SELECT',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the radius as needed
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 1.5,
                                            spreadRadius: 0.5,
                                          ),
                                        ],
                                      ),
                                      // child: ClipRRect(
                                      //   borderRadius: BorderRadius.circular(
                                      //       10.0),
                                      //   child: Image.network(
                                      //     widget.hotel.imageUrl!,
                                      //     width: MediaQuery.of(context).size.width * 0.2,
                                      //     height: MediaQuery.of(context).size.height * 0.25,
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
              }
            },
          )),
    );
  }
}
