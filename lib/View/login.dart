import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/register.dart';
import 'package:ugdlayout2/View/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugdlayout2/component/form_component.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool _isSecurePassword = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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

                          SizedBox(height: 20),

                          // Password Text Field
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
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

                          // Login Button
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (dataForm != null &&
                                    dataForm['username'] ==
                                        usernameController.text &&
                                    dataForm['password'] ==
                                        passwordController.text) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomeView(),
                                    ),
                                  );
                                  Fluttertoast.showToast(
                                      msg: "Login Success",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.lightGreenAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Login Failed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Password Salah'),
                                      content: TextButton(
                                        onPressed: () => pushRegister(context),
                                        child: const Text('Daftar Di sini !!'),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
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
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 65, 64, 64)),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 10),

                          // Register
                          Container(
                            child: TextButton(
                              onPressed: () {
                                Map<String, dynamic> formData = {};
                                formData['username'] = usernameController.text;
                                formData['password'] = passwordController.text;
                                pushRegister(context);
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
        builder: (_) => const RegisterView(),
      ),
    );
  }
}
