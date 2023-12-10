import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ugdlayout2/database/login_database.dart';
import 'package:ugdlayout2/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/View/auth/login.dart';
import 'package:ugdlayout2/repository/user_repository.dart';
import 'dart:io' as io;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepository userRepository = UserRepository();
  User data = User();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool _showPassword = false;
  Uint8List? imageProfile;
  bool _isEditing = false;
  int userId = 0;
  String b64 = "";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId') ?? 0;
      User res = await userRepository.find(userId);
      // print(res.dataImage);

      data = res;
      usernameController.text = res.username ?? '';
      emailController.text = res.email ?? '';
      passwordController.text = res.password ?? '';
      notelpController.text = res.notelp ?? '';
      dateController.text = res.borndate ?? '';
      // print(b64);
      imageProfile = convertStringToUint8List(res.dataImage ?? "");
      // print(imageProfile);
      setState(() {});
    } catch (e) {
      print('Error loading user data : $e');
    }
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  Future<void> updateProfileImage(String base64img) async {
    final result = await userRepository.DoUpdateImageProfile(userId, base64img);
  }

  void _editProfile() {
    setState(() {
      _isEditing = true;
    });
  }

  void _saveProfileChanges() async {
    try {
      final response = await userRepository.DoUpdateProfile(
          usernameController.text,
          emailController.text,
          passwordController.text,
          dateController.text,
          notelpController.text,
          data.id!);

      setState(() {
        _isEditing = false;
      });

      loadUserData();
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromARGB(217, 217, 217, 217),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.black),
              onPressed: () {
                // Navigate the user to the login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginView()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            child: Image.memory(base64.decode(b64)),
                            backgroundColor: Colors.grey[300],
                          ),
                          Positioned(
                            bottom: 0,
                            right: -10,
                            child: InkWell(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) {
                                          return Container(
                                            height: 100.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 20,
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Choose Profile Photo",
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    TextButton.icon(
                                                      onPressed: () {
                                                        _pickImageFromCamera();
                                                      },
                                                      icon: Icon(Icons.camera,
                                                          color: Colors.black),
                                                      label: Text(
                                                        "Camera",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    TextButton.icon(
                                                      onPressed: () {
                                                        _pickImageFromGallery();
                                                      },
                                                      icon: Icon(Icons.image,
                                                          color: Colors.black),
                                                      label: Text('Gallery',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
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
                          if (!_isEditing)
                            Column(
                              children: [
                                TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                  enabled: false,
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  enabled: false,
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  enabled: false,
                                  obscureText: !_showPassword,
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: notelpController,
                                  decoration: InputDecoration(
                                    labelText: 'No. Telp',
                                    prefixIcon: Icon(Icons.phone_android),
                                  ),
                                  enabled: false,
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    labelText: 'Tanggal Lahir',
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                  enabled: false,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: ElevatedButton(
                                    onPressed: _editProfile,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 65, 64, 64),
                                      ),
                                    ),
                                    child: const Text('Edit Profile'),
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !_showPassword,
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: notelpController,
                                  decoration: InputDecoration(
                                    labelText: 'No. Telp',
                                    prefixIcon: Icon(Icons.phone_android),
                                  ),
                                ),
                                SizedBox(height: 5),
                                TextFormField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    labelText: 'Tanggal Lahir',
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: ElevatedButton(
                                    onPressed: _saveProfileChanges,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 65, 64, 64),
                                      ),
                                    ),
                                    child: const Text('Save Changes'),
                                  ),
                                ),
                              ],
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
      ),
    );
  }

  void _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {});

    if (pickedFile != null) {
      final imageBytes = File(pickedFile.path).readAsBytesSync();
      b64 = base64.encode(imageBytes);
      await updateProfileImage(b64);
      // await loadUserData();
      setState(() {});

      print("Base64 String: $b64");
    }
    setState(() {});
  }

  void _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List imageBytes = File(pickedFile.path).readAsBytesSync();
      b64 = base64Encode(imageBytes);

      b64 = base64.encode(imageBytes);
      await updateProfileImage(b64);
      await loadUserData();
      // setState(() {});
      setState(() {});
    }
  }
}
