import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugdlayout2/View/user/my_booking/check_in/scanner_error_widget.dart';
import 'package:ugdlayout2/View/user/my_booking/check_in/success.dart';

class BarcodeScannerPageView extends StatefulWidget {
  const BarcodeScannerPageView({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerPageView> createState() => _BarcodeScannerPageViewState();
}

class _BarcodeScannerPageViewState extends State<BarcodeScannerPageView>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcodeCapture;
  bool checkIn = false;

  @override
  void initState() {
    super.initState();
    // Load check-in status from shared preferences
    loadCheckInStatus();
  }

  // Load check-in status from shared preferences
  Future<void> loadCheckInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      checkIn = prefs.getBool('checkIn') ?? false;
    });
  }

  // Save check-in status to shared preferences
  Future<void> saveCheckInStatus(bool isCheckedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkIn', isCheckedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: [
          cameraView(),
          Container(),
        ],
      ),
    );
  }

  Widget cameraView() {
    return Builder(
      builder: (context) {
        return Stack(
          children: [
            MobileScanner(
              startDelay: true,
              controller: MobileScannerController(torchEnabled: false),
              fit: BoxFit.contain,
              errorBuilder: (context, error, child) {
                return ScannerErrorWidget(error: error);
              },
              onDetect: (capture) => setBarcodeCapture(capture),
            ),
            Align(
              alignment: const Alignment(0, 0.9),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                color: Colors.black.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          onCheckInPressed();
                        },
                        child: const Text("Scan QR Code"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void setBarcodeCapture(BarcodeCapture capture) {
    setState(() {
      barcodeCapture = capture;
    });
  }

  void onCheckInPressed() {
    if (barcodeCapture == null) {
      // No QR code detected
      showToast('No QR code detected');
    } else {
      final qrCode = barcodeCapture!.barcodes.first.rawValue;

      if (qrCode == 'Global Hotel') {
        if (checkIn) {
          showToast('Already Checked In');
        } else {
          // Valid QR code, and not checked in yet
          checkIn = true;
          saveCheckInStatus(true); // Save check-in status
          showToast('Check-In Successful');
          // Navigate to the success page
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Success(),
          ));
        }
      } else {
        // Invalid QR code
        showToast('Invalid QR code');
      }
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
    );
  }
}
