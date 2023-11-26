import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/ugdAPI2/kamarPage.dart';
import 'package:ugdlayout2/View/view_list.dart';
import 'package:ugdlayout2/View/view_grid.dart';
import 'package:ugdlayout2/View/kamar_page.dart';
import 'package:ugdlayout2/View/user/profile/profile.dart';
import 'package:ugdlayout2/View/user/my_booking/on_going.dart';
import 'package:ugdlayout2/View/review/review.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgedOptions = <Widget>[
    //*index 0
    ListAnggotaView(),

    //*index 1
    Homepage(),

    //*index 2
    // KamarPage(title: 'SQFLITE'),
    KamarPage2(),

    //*index 3
    ProfilePage(),

    //*index 4
    OnGoing(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'List',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_3x3,
            ),
            label: 'Grid',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bedroom_child_rounded,
            ),
            label: 'Kamar',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Profile',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
            ),
            label: 'My Booking',
            backgroundColor: Colors.yellow,
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
