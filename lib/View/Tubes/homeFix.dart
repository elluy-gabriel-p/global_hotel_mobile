import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/ugdAPI2/kamarPage.dart';
import 'package:ugdlayout2/View/view_list.dart';
import 'package:ugdlayout2/View/view_grid.dart';
import 'package:ugdlayout2/View/kamar_page.dart';
import 'package:ugdlayout2/View/user/profile/profile.dart';
import 'package:ugdlayout2/View/user/my_booking/on_going.dart';
import 'package:ugdlayout2/View/ugdAPI2/kamarPage.dart';
import 'package:ugdlayout2/View/home.dart';
import 'package:ugdlayout2/View/Tubes/homeContent.dart';
import 'package:ugdlayout2/View/Tubes/cancelBooking.dart';
import 'package:ugdlayout2/View/Tubes/successBooking.dart';

class HomeFix extends StatefulWidget {
  const HomeFix({super.key});

  @override
  State<HomeFix> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeFix> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgedOptions = <Widget>[
    //*index 1
    SuccessBooking(),

    //*index 2
    HomeContent(),

    //*index 3
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
            ),
            label: 'Booking',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Profile',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      body: _widgedOptions.elementAt(_selectedIndex),
    );
  }
}
