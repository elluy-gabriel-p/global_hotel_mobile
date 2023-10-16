import 'package:flutter/material.dart';
import 'package:ugdlayout2/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences.dart or the appropriate package for data storage.

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController borndateController = TextEditingController();

  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load the user's data and set it in the respective controllers.
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? noTelp = prefs.getString('noTelp');
    String? date = prefs.getString('tanggalLahir');

    setState(() {
      usernameController.text = username ?? '';
      emailController.text = email ?? '';
      passwordController.text = password ?? '';
      notelpController.text = noTelp != null ? noTelp.toString() : '';
      borndateController.text = date ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
              obscureText: !_showPassword,
            ),
            TextFormField(
              controller: notelpController,
              decoration: InputDecoration(
                labelText: 'No. Telp',
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),
            TextFormField(
              controller: borndateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save the edited data and return to the ProfilePage.
          saveEditedData();
          Navigator.pop(context, true);
        },
        child: Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<void> saveEditedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final notelp = notelpController.text;
    final borndate = borndateController.text;

    // Save the edited data to SharedPreferences.
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('noTelp', notelp);
    await prefs.setString('tanggalLahir', borndate);

    // Update the SQLite database with the edited data.
    final db = await SQLHelper.db();
    await db.rawUpdate(
      'UPDATE user SET username = ?, email = ?, password = ?, notelp = ?, borndate = ? WHERE id = ?',
      [
        username,
        email,
        password,
        notelp,
        borndate,
        1
      ], // Replace '1' with the actual user ID
    );

    // Return 'true' to indicate changes were made.
    Navigator.pop(context, true);
  }
}
