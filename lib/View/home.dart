import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/view_list.dart';
import 'package:ugdlayout2/View/view_grid.dart';

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

  static const List<Widget> _widgedOptions = <Widget>[
    //*index 0
    Center(child: Image(image: NetworkImage('https://picsum.photos/200/300'))),
    /*ini bawaan gd yak yg dpt bagian home ganti ae*/

    //*index 1
    ListAnggotaView(),

    //*index 2
    ListGrid(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
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
