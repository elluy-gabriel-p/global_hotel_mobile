import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/view_list.dart';
import 'package:ugdlayout2/View/view_grid.dart';
import 'package:ugdlayout2/entity/user.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.loggedinUser});

  final User? loggedinUser;

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

  static const List<Widget> _widgedOptions = <Widget>[
    //*index 0
    ListAnggotaView(),

    //*index 1
    ListGrid(),
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
              label: 'List'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.grid_3x3,
              ),
              label: 'Grid'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      body: _widgedOptions.elementAt(_selectedIndex),
    );
  }
}
