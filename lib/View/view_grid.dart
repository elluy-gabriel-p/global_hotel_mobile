import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/maps.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:provider/provider.dart';

class ListGrid extends StatefulWidget {
  const ListGrid({super.key});

  @override
  State<ListGrid> createState() => _listGridState();
}

class _listGridState extends State<ListGrid> {
  var size = 180.0;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          themeNotifier.isDark
              ? themeNotifier.isDark = false
              : themeNotifier.isDark = true;
        }),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                  margin: EdgeInsets.all(8),
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/hotel.jpg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                  margin: EdgeInsets.all(8),
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/1.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                  margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/2.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                 margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/3.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),

                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                  margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage('image/5.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                   
                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                   margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/6.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),

                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                 margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/7.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                   
                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                  margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                     image: DecorationImage(
                        image: AssetImage('image/7.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                    
                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                   margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/8.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                    
                  ),
                ),
                Container(
                  child: InkResponse(
                    onTap: () {
                      setState(() {
                        size == 180 ? size = size * 2 : size = 180.0;
                      });
                    },
                  ),
                  margin: EdgeInsets.all(8),
                  width: 180.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('image/9.jpeg'), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                   
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Arahkan ke halaman peta (contoh: Google Maps)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Maps(); // Gantilah dengan widget halaman peta yang sesuai
                        },
                      ),
                    );
                  },
                  child: Text("Buka Peta"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
