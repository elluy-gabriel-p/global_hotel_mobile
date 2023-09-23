import 'package:flutter/material.dart';

class ListAnggotaView extends StatefulWidget {
  const ListAnggotaView({super.key});

  @override
  State<ListAnggotaView> createState() => _ListViewState();
}

class _ListViewState extends State<ListAnggotaView> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '1'),
    Tab(text: '2'),
    Tab(text: '3'),
    Tab(text: '4'),
    Tab(text: '5'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 51, 48, 48),
          title: Text('List Anggota Kelompok',
              style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Tab 1
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            'image/potoTipp.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Nama : Tiffany'),
                        Text('Umur : 20'),
                        Text('Alamat : Prambanan'),
                        Text('NPM : 210711483'),
                        Text('Hobi : Ketawa ngakak'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content for Tab 2
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            'image/potoIqbal.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Nama : Iqbal'),
                        Text('Umur : 22'),
                        Text('Alamat : Seturan'),
                        Text('NPM : 210711485'),
                        Text('Hobi : Main bola'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content for Tab 3
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            'image/potoKevin.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Nama : Kevin'),
                        Text('Umur : 20'),
                        Text('Alamat : Babarsari'),
                        Text('NPM : 210711056'),
                        Text('Hobi : Menggambar'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content for Tab 4
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            'image/potoBona.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Nama : Bona'),
                        Text('Umur : 21'),
                        Text('Alamat : Nologaten'),
                        Text('NPM : 210711088'),
                        Text('Hobi : Balapan jangkrik'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content for Tab 5
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1.0),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            'image/potoElluy.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Nama : Elluy'),
                        Text('Umur : 20'),
                        Text('Alamat : Bener'),
                        Text('NPM : 210711306'),
                        Text('Hobi : Main basket'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
