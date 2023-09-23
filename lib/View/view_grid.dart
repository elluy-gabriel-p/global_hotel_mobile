import 'package:flutter/material.dart';
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
    return Consumer(builder: (context, ThemeModel themeNotifier, child){
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
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
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
