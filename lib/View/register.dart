import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:ugdlayout2/component/passForm.dart';
import 'package:ugdlayout2/view/login.dart';
import 'package:ugdlayout2/component/form_component.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

//enum sex
enum listGender { pria, wanita }

class _RegisterViewState extends State<RegisterView> {
  TextEditingController dateinput = TextEditingController();
  @override
  final _formKey = GlobalKey<FormState>();
  listGender? gender;
  bool agreement = false;
  bool _isSecurePassword = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();

  void initState() {
    dateinput.text = "--/--/----";
    super.initState();
  }

  void _showAlertDialog(
      String title, String message, Map<String, dynamic> FormData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          backgroundColor: Colors.orange[100],
          contentPadding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LoginView(data: FormData)));
              },
              child: Text('OK'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(),
            side: BorderSide(
              color: Color.fromARGB(255, 249, 117, 1),
              width: 1.0,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('image/globalHotelLogo.png'),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: themeNotifier.isDark ? Colors.black : Colors.white,
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
                              if (value.toLowerCase() == 'anjing') {
                                return 'Tidak Boleh Menggunakan kata kasar';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

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
                              if (!value.contains('@')) {
                                return 'Email harus menggunakan @';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

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

                          SizedBox(height: 20),

                          TextFormField(
                            controller: notelpController,
                            decoration: InputDecoration(
                              labelText: "No. Telepon",
                              prefixIcon: Icon(Icons.phone_android),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "No. Telepon tidak boleh kosong";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),
                          //select sex
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 5),
                            child: Row(
                              children: [
                                Text('Gender :'),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('Pria'),
                                    value: listGender.pria,
                                    groupValue: gender,
                                    onChanged: (val) {
                                      setState(() {
                                        gender = val;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text('Wanita'),
                                    value: listGender.wanita,
                                    groupValue: gender,
                                    onChanged: (val) {
                                      setState(() {
                                        gender = val;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: SizedBox(
                              width: 350,
                              child: TextField(
                                controller: dateinput,
                                decoration: InputDecoration(
                                  labelText: "Date of Birth",
                                  contentPadding: EdgeInsets.all(10.0),
                                  filled: true,
                                  icon: Icon(Icons.calendar_today),
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.black45),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2005));

                                  if (date != null) {
                                    print(date);
                                    String formatDate =
                                        DateFormat('dd/MM/yyyy').format(date);
                                    print(formatDate);
                                    setState(() {
                                      dateinput.text = formatDate;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          //user agreement
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Column(
                              children: [
                                CheckboxListTile(
                                  title: Text('Accept Agreement'),
                                  value: agreement,
                                  onChanged: (value) {
                                    setState(() {
                                      agreement = value!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (agreement == true) {
                                    bool registrationSuccessful = true;
                                    Map<String, dynamic> FormData = {};
                                    FormData['username'] =  usernameController.text;
                                    FormData['password'] = passwordController.text;
                                    FormData['email'] = emailController.text;
                                    FormData['notelp'] = notelpController.text;
                                    if (registrationSuccessful) {
                                      _showAlertDialog('Success',
                                          'Registrasi berhasil!', FormData);
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => LoginView(
                                                  data: FormData,
                                                )));
                                  } else {
                                    Map<String, dynamic> FormData = {};
                                    _showAlertDialog(
                                        'Failed',
                                        'Please check the user agreement',
                                        FormData);
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 65, 64, 64)),
                              ),
                              child: const Text('Register'))
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
}
