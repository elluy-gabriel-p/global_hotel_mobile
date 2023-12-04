import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selamat Datang di Homepage',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi yang ingin dilakukan ketika tombol ditekan
                print('Tombol ditekan!');
              },
              child: Text('Tekan Saya'),
            ),
          ],
        ),
      ),
    );
  }
}