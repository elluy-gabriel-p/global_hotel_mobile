import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugdlayout2/database/login_database.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/View/home.dart';
import 'package:ugdlayout2/View/Tubes/homeFix.dart';
import 'package:ugdlayout2/View/register.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/View/login.dart';

class ForgotPassView extends StatefulWidget {
  final Map? data;

  const ForgotPassView({Key? key, this.data}) : super(key: key);

  @override
  _ForgotPassViewState createState() => _ForgotPassViewState();
}

class _ForgotPassViewState extends State<ForgotPassView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSecurePassword = true;

  Future<void> setUserData(userVelue) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('userId', userVelue.id);
    pref.setString('username', userVelue.username);
    pref.setString('email', userVelue.email);
    pref.setString('password', userVelue.password);
    pref.setString('noTelp', userVelue.notelp);
    pref.setString('tanggalLahir', userVelue.borndate);
  }

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          themeNotifier.isDark
              ? themeNotifier.isDark = false
              : themeNotifier.isDark = true;
        }),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('image/globalHotelLogo.png'),
                    ),

                    SizedBox(height: 20),

                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color:
                            themeNotifier.isDark ? Colors.black : Colors.white,
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
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

                          // Password Text Field
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isSecurePassword,
                            decoration: InputDecoration(
                              labelText: "New Password",
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
                              return null;
                            },
                          ),

                          SizedBox(height: 20),
                          // Login Button
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  User? fPass =
                                      await LoginClient.updatePassword(
                                    emailController.text,
                                    passwordController.text,
                                  );

                                  if (fPass != null) {
                                    Fluttertoast.showToast(
                                      msg: "Update Pass Success",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.lightGreenAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );

                                    setUserData(fPass);

                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => LoginView(),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Update Pass Failed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );

                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text('Email Salah'),
                                        content: TextButton(
                                          onPressed: () =>
                                              pushRegister(context),
                                          child:
                                              const Text('Daftar Di sini !!'),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print('Error updating password: $e');
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 65, 64, 64)),
                            ),
                            child: const Text(
                              'Update Password',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 10),

                          // Register
                          Container(
                            child: TextButton(
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegisterView(
                                      id: null,
                                      username: null,
                                      email: null,
                                      password: null,
                                      notelp: null,
                                      borndate: null,
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Belum punya akun ?'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegisterView(
          id: null,
          username: null,
          password: null,
          email: null,
          notelp: null,
          borndate: null,
        ),
      ),
    );
  }
}
