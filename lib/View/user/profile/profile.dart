import 'dart:io'; // Import the 'dart:io' library
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'package:ugdlayout2/database/login_database.dart'; // Import the LoginClient
import 'package:ugdlayout2/View/user/profile/edit_profile.dart';
import 'package:ugdlayout2/View/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User data = User();
  bool _isLoading = true;
  Uint8List? imageProfile; // Declare imageProfile

  TextEditingController usernameController =
      TextEditingController(); // Define the controller

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? loggedInUsername = prefs.getString('username');
      String? loggedInEmail = prefs.getString('email');

      setState(() {
        data = User(
          username: loggedInUsername,
          email: loggedInEmail,
          // Retrieve other user data properties and set them here
        );
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading user data: $e');
    }
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginView()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Stack(children: [
                          data.dataImage != null
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage: MemoryImage(data.dataImage!),
                                )
                              : CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.white30,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black38,
                                    size: 70,
                                  )),
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
                                                              icon: Icon(
                                                                  Icons.camera),
                                                              label: Text(
                                                                  "Camera")),
                                                          TextButton.icon(
                                                              onPressed: () {
                                                                _pickImageFromGallery();
                                                              },
                                                              icon: Icon(
                                                                  Icons.image),
                                                              label: Text(
                                                                  'Gallery'))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }));
                                        },
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.blue,
                                        )),
                                  ),
                                  decoration: BoxDecoration(),
                                ),
                              )),
                        ]),
                      ),
                      // Display user information
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
                            Text('Username: ${data.username}'),
                            SizedBox(height: 5),
                            Text('Email: ${data.email}'),
                            SizedBox(height: 5),
                            Text(
                                'Password: ${data.password}'), // Note: Avoid displaying passwords in the UI
                            SizedBox(height: 5),
                            Text('No. Telp: ${data.notelp}'),
                            SizedBox(height: 5),
                            Text('Tanggal Lahir: ${data.borndate}'),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()),
                            );
                            if (result != null && result) {
                              _loadUserData();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 65, 64, 64)),
                          ),
                          child: const Text('Edit Profile'),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 25);

    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    final imageBytes = await imageFile.readAsBytes();
    final username = usernameController.text;

    try {
      final result =
          await LoginClient.updateProfileImages(username, imageBytes);

      if (result.statusCode == 200) {
        setState(() {
          imageProfile = imageBytes;
          _loadUserData();
        });
      } else {
        print(
            'Failed to update profile image. Status code: ${result.statusCode}');
      }
    } catch (e) {
      print('Error updating profile image: $e');
    }
  }

  Future _pickImageFromCamera() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 25);

    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);
    final imageBytes = await imageFile.readAsBytes();
    final username = usernameController.text;

    try {
      final result =
          await LoginClient.updateProfileImages(username, imageBytes);

      if (result.statusCode == 200) {
        setState(() {
          imageProfile = imageBytes;
          _loadUserData(); // Assuming you have a method to load user data from the API
        });
      } else {
        // Handle the error, display a message, etc.
        print(
            'Failed to update profile image. Status code: ${result.statusCode}');
      }
    } catch (e) {
      // Handle exceptions, display an error message, etc.
      print('Error updating profile image: $e');
    }
  }
}
