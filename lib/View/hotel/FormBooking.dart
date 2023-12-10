import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/View/Tubes/homeFix.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/repository/booking_repository.dart';
import 'package:ugdlayout2/repository/user_repository.dart';

class FormBooking extends StatefulWidget {
  const FormBooking(
      {Key? key,
      required this.id,
      required this.checkinDate,
      required this.checkoutDate,
      required this.jumlahOrang,
      required this.jumlahKamar,
      required this.harga});
  final int id;
  final DateTime checkinDate;
  final DateTime checkoutDate;
  final int jumlahOrang;
  final int jumlahKamar;
  final int harga;
  @override
  State<FormBooking> createState() => _FormBookingState();
}

class _FormBookingState extends State<FormBooking> {
  final UserRepository userRepository = UserRepository();
  final BookingRepository bookingRepository = BookingRepository();
  int userId = 0;
  int durasi = 1;
  User data = User();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _dateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId') ?? 0;
      print(userId);
      User res = await userRepository.find(userId);
      _nameController.text = res.username ?? '';
      _emailController.text = res.email ?? '';
      _phoneNumController.text = res.notelp ?? '';
      _dateInput.text = res.borndate ?? '';
      // print(res.dataImage);

      data = res;
      // b64 = res.dataImage ?? "";
      // print(b64);
      // imageProfile = convertStringToUint8List(res.dataImage ?? "");
      // print(imageProfile);
      Duration difference = widget.checkoutDate.difference(widget.checkinDate);
      durasi = difference.inDays;
      setState(() {});
    } catch (e) {
      print('Error loading user data : $e');
    }
  }

  InputDecoration get textFieldDecoration => InputDecoration(
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 241, 241),
      appBar: AppBar(
        title:
            Text('Lengkapi Identitas', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Identitas',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  controller: _nameController,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Userame',
                    hintText: 'Masukkan Username Anda',
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Use the name on your Government ID',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  controller: _emailController,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Email',
                    hintText: 'Masukkan Email Anda',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _phoneNumController,
                  keyboardType: TextInputType.phone,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Phone Number',
                    hintText: 'Masukkan Phone Number Anda',
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    readOnly: true,
                    controller: _dateInput,
                    decoration: textFieldDecoration.copyWith(
                      labelText: "Date of Birth",
                      hintText: 'Masukkan Tanggal Lahir Anda',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            alignment: Alignment.topLeft,
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rp${widget.harga * durasi}",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    await bookingRepository.DoBookingHotel(
                        widget.id,
                        userId,
                        widget.jumlahOrang,
                        widget.jumlahKamar,
                        formatDate(widget.checkinDate).toString(),
                        formatDate(widget.checkoutDate).toString(),
                        _phoneNumController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("SUkses Reservasi")));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeFix(),));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatDuration(Duration duration) {
  int days = duration.inDays;
  int hours = duration.inHours % 24;
  int minutes = duration.inMinutes % 60;

  return '$days days, $hours hours, $minutes minutes';
}
