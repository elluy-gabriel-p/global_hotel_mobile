import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/auth/login.dart';
import 'package:ugdlayout2/View/hotel/booking_history.dart';
import 'package:ugdlayout2/View/kamar_page.dart';
import 'package:ugdlayout2/View/review/review_list_page.dart';
import 'package:ugdlayout2/View/ugdAPI2/kamarPage.dart';
import 'package:ugdlayout2/View/user/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/repository/user_repository.dart';

class ProfileLandingPage extends StatefulWidget {
  const ProfileLandingPage({super.key});

  @override
  State<ProfileLandingPage> createState() => _ProfileLandingPageState();
}

class _ProfileLandingPageState extends State<ProfileLandingPage> {
  final UserRepository userRepository = UserRepository();
  int userId = 0;
  User data = User();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();

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
      usernameController.text = res.username ?? '';
      emailController.text = res.email ?? '';
      passwordController.text = res.password ?? '';
      notelpController.text = res.notelp ?? '';
      dateController.text = res.borndate ?? '';
      // print(res.dataImage);

      data = res;
      // b64 = res.dataImage ?? "";
      // print(b64);
      // imageProfile = convertStringToUint8List(res.dataImage ?? "");
      // print(imageProfile);
      setState(() {});
    } catch (e) {
      print('Error loading user data : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person),
              ),
              title: Text(usernameController.text),
              subtitle: Text(emailController.text),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ));
                },
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text("My Priorities"),
          SizedBox(
            height: 8,
          ),
          ListTile(
            title: Text("My Booking History"),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookingHistoryPage(),
                ));
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            title: Text("My Kamar"),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => KamarPage2()));
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ListTile(
            title: Text("My Review"),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReviewListPage(),
                ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
