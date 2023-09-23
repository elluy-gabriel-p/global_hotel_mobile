import 'package:flutter/material.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:ugdlayout2/View/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Ganti ini sama cek import
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(
          builder: (context, ThemeModel themeNotifier, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:
                  themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
              home: LoginView(),
            );
          },
        ));
  }
}
