import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ugdlayout2/component/passForm.dart';
import 'package:ugdlayout2/database/sql_helper_user.dart';
import 'package:ugdlayout2/View/login.dart';
import 'package:ugdlayout2/component/form_component.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:ugdlayout2/database/login_database.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(
      {super.key,
      required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.notelp,
      required this.borndate});

  final int? id;
  final String? username, password, email, notelp, borndate;
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

  var listUser = SQLHelper.getUser();

  void initState() {
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
                      radius: 13,
                      backgroundImage: AssetImage('image/globalHotelLogo.png'),
                    ),
                    SizedBox(height: 5),
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
                              if (value.toLowerCase() == 'anjing') {
                                return 'Tidak Boleh Menggunakan kata kasar';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 5),

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

                          SizedBox(height: 5),

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

                          SizedBox(height: 5),

                          TextFormField(
                            controller: notelpController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "No. Telepon",
                              prefixIcon: Icon(Icons.phone_android),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "No. Telepon tidak boleh kosong";
                              }
                              if (value.length > 20) {
                                return "Panjang no telepon tidak boleh lebih dari 20";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 5),
                          //select sex
                          Padding(
                            padding: const EdgeInsets.only(left: 5, top: 1),
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
                            padding: const EdgeInsets.only(left: 10, top: 1),
                            child: SizedBox(
                              width: 350,
                              child: TextFormField(
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
                                onTap: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2023));

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
                                validator: (value) {
                                  if (value == '') {
                                    return "Tanggal Lahir Tidak Boleh Kosong";
                                  }
                                  if (value == '--/--/----') {
                                    return "Format Tanggal Salah";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          //user agreement
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 2),
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (agreement == true) {
                                    bool registrationSuccessful = true;
                                    Map<String, dynamic> FormData = {};
                                    FormData['username'] =
                                        usernameController.text;
                                    FormData['password'] =
                                        passwordController.text;
                                    FormData['email'] = emailController.text;
                                    FormData['notelp'] = notelpController.text;
                                    FormData['borndate'] = dateinput.text;

                                    User user= User(username: usernameController.text,email: emailController.text ,password: passwordController.text, notelp: notelpController.text, borndate: dateinput.text);
                                    print(user.username);
                                    LoginClient.create(user);

                                    if (registrationSuccessful) {
                                      _showAlertDialog('Success',
                                          'Registrasi berhasil!', FormData);
                                      Fluttertoast.showToast(
                                          msg: "Register Success",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Colors.lightGreenAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      if (widget.id == null) {
                                        await addUser();
                                      }
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => LoginView()));
                                  } else {
                                    Map<String, dynamic> FormData = {};
                                    _showAlertDialog(
                                        'Failed',
                                        'Please check the user agreement',
                                        FormData);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Register Failed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
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

  Future<void> addUser() async {
    await SQLHelper.addUser(
      usernameController.text,
      emailController.text,
      passwordController.text,
      notelpController.text,
      dateinput.text,
    );
  }
}
