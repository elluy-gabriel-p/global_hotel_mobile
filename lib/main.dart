import 'package:flutter/material.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:ugdlayout2/View/login.dart';
import 'package:provider/provider.dart';
import 'package:sensors/sensors.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyBrightnessControlApp(),
    );
  }
}

class MyBrightnessControlApp extends StatefulWidget {
  @override
  _MyBrightnessControlAppState createState() => _MyBrightnessControlAppState();
}

class _MyBrightnessControlAppState extends State<MyBrightnessControlApp> {
  bool isUserActive = false;
  double currentBrightness = 1.0;
  Timer? inactivityTimer;

  @override
  void initState() {
    super.initState();

    // Prevent the screen from turning off
    Wakelock.enable();

    // Initialize the gyroscope sensor stream
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // You can customize this logic based on the gyroscope data
      if (event.x.abs() > 0.2 || event.y.abs() > 0.2 || event.z.abs() > 0.2) {
        // User is active
        isUserActive = true;
        setScreenBrightness(1.0); // Set to full brightness
        // Restart the inactivity timer
        if (inactivityTimer != null && inactivityTimer!.isActive) {
          inactivityTimer!.cancel();
        }
      } else {
        // User is inactive
        isUserActive = false;
        // Start the inactivity timer
        if (inactivityTimer == null || !inactivityTimer!.isActive) {
          inactivityTimer = Timer(const Duration(seconds: 10), () {
            setScreenBrightness(0.2); // Set to a lower brightness
          });
        }
      }
    });
  }

  // Function to set the screen brightness
  Future<void> setScreenBrightness(double brightness) async {
    try {
      ScreenBrightness screenBrightness = ScreenBrightness();
      await screenBrightness.setScreenBrightness(brightness);
      currentBrightness = brightness;
    } catch (e) {
      // Handle errors if setting brightness fails
    }
  }

  @override
  void dispose() {
    Wakelock.disable(); // Release wakelock
    if (inactivityTimer != null && inactivityTimer!.isActive) {
      inactivityTimer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      builder: (context, child) {
        return Consumer(builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
            home: LoginView(),
          );
        });
      },
    );
  }
}
