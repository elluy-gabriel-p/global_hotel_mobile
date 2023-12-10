import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/View/auth/register.dart';
import 'package:ugdlayout2/View/Tubes/homeFix.dart';
import 'package:ugdlayout2/View/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ugdlayout2/View/user/profile/profile.dart';
import 'package:ugdlayout2/component/form_component.dart';
import 'package:ugdlayout2/database/sql_helper_user.dart';
import 'package:ugdlayout2/repository/user_repository.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'package:provider/provider.dart';
import 'package:ugdlayout2/database/login_database.dart';
import 'package:ugdlayout2/View/forgotPass.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

User user = User();

class _LoginViewState extends State<LoginView> {
  final UserRepository userRepository = UserRepository();
  TextEditingController usernameController = TextEditingController();
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
        body: SingleChildScrollView(
          child: SafeArea(
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
        
                            // Add the "Forgot Password" button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassView()));
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
        
                            // Login Button
                            ElevatedButton(
                              onPressed: () async {
                                // User? logUser = await SQLHelper.forLogin(
                                //   usernameController.text,
                                //   passwordController.text,
                                // );
                                // User? logUser = await LoginClient.login(
                                //     usernameController.text,
                                //     passwordController.text);
        
                                // setUserData(logUser);
        
                                if (_formKey.currentState!.validate()) {
                                  final result = await userRepository.DoLogin(
                                      usernameController.text,
                                      passwordController.text);
        
                                  if (result.status == true) {
                                    setUserData(result.user);
                                    Fluttertoast.showToast(
                                      msg: "Login Success",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.lightGreenAccent,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
        
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const HomeFix(),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Login Failed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
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
                                          borndate: null),
                                    ),
                                  );
                                },
                                child: const Text('Belum punya akun ?'),
                              ),
                            ),
                            // ElevatedButton(onPressed: () async {
                            //   User data = await LoginClient.login('riksi', '12345678');
                            //   print(data.username);
                            // }, child: Container())
                          ],
                        ),
                      ),
                    ],
                  ),
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
            borndate: null),
      ),
    );
  }

  Future<void> forLogin() async {
    await SQLHelper.forLogin(usernameController.text, passwordController.text);
  }
}
