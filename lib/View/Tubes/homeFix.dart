import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ugdlayout2/View/user/profile/profile.dart';
import 'package:ugdlayout2/View/Tubes/successBooking.dart';
import 'package:ugdlayout2/View/Tubes/homeContent.dart';

class HomeFix extends StatefulWidget {
  const HomeFix({super.key});

  @override
  State<HomeFix> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeFix> {
  int _selectedIndex = 1;

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 500),
            tabBackgroundColor: Colors.grey.shade800,
            tabs: [
              GButton(
                icon: Icons.description,
                text: 'Booking',
              ),
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      body: _widgedOptions.elementAt(_selectedIndex),
    );
  }
}
