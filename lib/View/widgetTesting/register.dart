import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ugdlayout2/View/login.dart';
import 'package:ugdlayout2/View/widgetTesting/login.dart';

enum Gender { male, female }

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => RegisterState();
}

class RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  Gender? selectedGender;
  TextEditingController dateBirthController = TextEditingController();
  bool accept = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              key: Key('emailField'),
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
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
                labelText: "password",
                prefixIcon: Icon(Icons.password),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username tidak boleh kosong";
                }
                return null;
              },
            ),
            TextFormField(
              key: Key('noTelpField'),
              controller: noTelpController,
              decoration: InputDecoration(
                labelText: "No.Telepon",
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username tidak boleh kosong";
                }
                return null;
              },
            ),
            RadioListTile<Gender>(
              title: const Text('Male'),
              value: Gender.male,
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            RadioListTile<Gender>(
              key: Key('femaleRadio'),
              title: const Text('Female'),
              value: Gender.female,
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            ElevatedButton(
                key: Key('registerButton'),
                onPressed: () {
                  register(usernameController.text, passwordController.text,emailController.text,noTelpController.text,selectedGender);
                },
                child: Text('Login')),
          ],
        ),
      ),
    );
  }

  void register(String username, String password, String email, String noTelp,
      Gender? gender) {
    if (username == '' ||
        password == '' ||
        email == '' ||
        noTelp == '' ||
        gender == null) {
      showSnackbar('Gagal Register', Colors.red);
    } else {
      showSnackbar('Berhasil Register', Colors.green);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Login();
      }));
    }
  }

  Future<bool> registerTesting(String username, String password, String email, String noTelp,
      String gender) async {
    if (username == '' ||
        password == '' ||
        email == '' ||
        noTelp == '' ||
        gender == '') {
      showSnackbar('Gagal Register', Colors.red);
      return false;
    } else {
      showSnackbar('Berhasil Register', Colors.green);
     
      return true;
    }
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
