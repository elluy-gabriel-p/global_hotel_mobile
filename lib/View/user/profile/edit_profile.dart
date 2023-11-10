import 'package:flutter/material.dart';
import 'package:ugdlayout2/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences.dart or the appropriate package for data storage.
import 'package:ugdlayout2/View/login.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool _isSecurePassword = true;

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
      dateController.text = date ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Mengarahkan pengguna ke halaman login
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginView()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Username Text Field
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your username' : null,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Email',
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your email' : null,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isSecurePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isSecurePassword = !_isSecurePassword;
                              });
                            },
                            icon: Icon(
                              _isSecurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong !";
                          }
                          if (value.length < 5) {
                            return 'Password minimal 5 digit';
                          }
                          return null;
                        },
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 16.0)),
                      TextFormField(
                        controller: notelpController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone Number',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) => value == ''
                            ? 'Please enter your Phone Number'
                            : null,
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 16.0)),
                      TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(
                          labelText: "Born Date",
                          prefixIcon: const Icon(Icons.date_range),
                          suffixIcon: const Icon(Icons.calendar_today,
                              color: Colors.blue),
                        ),
                        readOnly: true,
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2005));

                          if (date != null) {
                            String formatDate =
                                DateFormat('dd/MM/yyyy').format(date);
                            setState(() {
                              dateController.text = formatDate;
                            });
                          }
                        },
                        validator: (value) =>
                            value == '' ? 'Please enter your born date' : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ElevatedButton(
                            onPressed: () {
                              // Save the edited data and return to the ProfilePage.
                              saveEditedData();
                              Navigator.pop(context, true);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 65, 64, 64)),
                            ),
                            child: const Text('Save Changes')),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveEditedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final notelp = notelpController.text;
    final borndate = dateController.text;

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
