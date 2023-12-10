import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ugdlayout2/View/user/my_booking/check_in/scan_qr_page.dart';
import 'package:ugdlayout2/repository/booking_repository.dart';

class BookingListPage extends StatefulWidget {
  const BookingListPage({super.key});

  @override
  State<BookingListPage> createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage> {
  final BookingRepository bookingRepository = BookingRepository();
  int durasi = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking list")),
      body: FutureBuilder(
        future: bookingRepository.GetBookingHotelList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Container(
                height: 400.0,
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(16.0),
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
                                '${getDifference(snapshot.data![index].tglCheckIn, snapshot.data![index].tglCheckOut)} Nights',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                'Tanggal Check In: ${formatDate(snapshot.data![index].tglCheckIn)}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                'Tanggal Check Out: ${formatDate(snapshot.data![index].tglCheckOut)}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                "Jumlah orang: ${snapshot.data![index].jumlahOrang.toString()}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                'Booking Id: ${snapshot.data![index].id.toString()}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                snapshot.data![index].tipe,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(
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
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              BarcodeScannerPageView(
                                                  id: snapshot.data![index].id,
                                                  checkin: formatDate(snapshot.data![index].tglCheckIn),
                                                  checkout: formatDate(snapshot.data![index].tglCheckOut) ,
                                                  durasi: getDifference(snapshot.data![index].tglCheckIn, snapshot.data![index].tglCheckOut),
                                                  jumlahOrang: snapshot.data![index].jumlahOrang,
                                                  tipe: snapshot.data![index].tipe,
                                                  ),
                                        ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 35, 140,
                                            152), // Warna latar belakang
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), // BorderRadius di sini
                                        ),
                                      ),
                                      child: Text("CHECK - IN"),
                                    ),
                                    SizedBox(
                                      width:
                                          20, // Jarak antara tombol pertama dan kedua
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await bookingRepository
                                            .DoCancelBookingHotel(
                                                snapshot.data![index].id);
                                        setState(() {});

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Berhasil delete")));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Colors.red, // Warna latar belakang
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), // BorderRadius di sini
                                        ),
                                      ),
                                      child: Text("CENCEL BOOKING"),
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
            );
          }
        },
      ),
    );
  }
}

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

int getDifference(DateTime checkin, DateTime checkout) {
  Duration difference = checkout.difference(checkin);
  final durasi = difference.inDays;
  return durasi;
}

String formatDuration(Duration duration) {
  int days = duration.inDays;
  int hours = duration.inHours % 24;
  int minutes = duration.inMinutes % 60;

  return '$days days, $hours hours, $minutes minutes';
}
