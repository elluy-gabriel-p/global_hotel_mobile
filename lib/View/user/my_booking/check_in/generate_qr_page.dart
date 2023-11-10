import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class GenerateQRPage extends StatelessWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace 'Your QR Code Data Here' with the actual data you want to encode
    String qrCodeData = 'Your QR Code Data Here';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('QR Generate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(
                errorCorrectLevel: BarcodeQRCorrectionLevel.high,
              ),
              data: qrCodeData, // Pass the actual data here
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              qrCodeData,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
