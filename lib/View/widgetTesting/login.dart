import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ugdlayout2/View/home.dart';
import 'package:ugdlayout2/View/widgetTesting/homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              key: Key('userField'),
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              key: Key('passField'),
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.password),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password tidak boleh kosong";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                key: Key('loginButton'),
                onPressed: () {
                  login(usernameController.text, passwordController.text);
                },
                child: Text('Login')),
          ],
        ),
      ),
    );
  }

  bool login(String username, String password) {
    // Implementasi logika login
    // Contoh: Anda dapat menambahkan kondisi login di sini
    // Ganti dengan logika login sesuai kebutuhan
    bool status;
    if (username == '1' && password == '1') {
      showSnackbar('Login Berhasil', Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
      status = true;
    } else {
      showSnackbar('Login gagal. Periksa username dan password.', Colors.red);
      status = false;
    }
    return status;
  }

  Future<bool> loginTesting(String username, String password) async {
    bool status;
    if (username == '1' && password == '1') {
      showSnackbar('Login Berhasil', Colors.green);
      status = true;
    } else {
      showSnackbar('Login Gagal', Colors.red);
      status = false;
    }
    return status;
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }
}
