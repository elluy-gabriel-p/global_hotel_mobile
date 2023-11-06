import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ugdlayout2/database/sql_helper_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/View/camera/camera.dart';
import 'package:ugdlayout2/entity/user.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User data = User();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  bool _showPassword = false;
  int idUser = 0;
  Uint8List? imageProfile = null;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dataUser = await SQLHelper.getUser();

    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    String? noTelp = prefs.getString('noTelp');
    String? date = prefs.getString('tanggalLahir');

    setState(() {
      final user = dataUser.where((element) => element['username']== username);

      data=User(id: user.first['id'], username: user.first['username'], email: user.first['email'], password: user.first['password'], notelp: user.first['noTelp'], borndate: user.first['borndate'], dataImage: user.first['profileImage']);

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraView(id: idUser)),
                    );
                  },
                  child: Stack(
                  children:[
                    data.dataImage !=null 
                    ?
                    CircleAvatar(
                      radius:70,
                      backgroundImage: MemoryImage(data.dataImage!),
                    )
                    :CircleAvatar(
                      radius:70,
                      backgroundColor: Colors.white30 ,
                      child: Icon(
                        Icons.person,
                        color: Colors.black38,
                        size: 70,
                      )
                    ),
                    Positioned(
                      bottom: 0,
                      right: -10,
                      child:InkWell(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context, 
                                  builder: ((builder){
                                    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  _pickImageFromCamera();
                }, 
                icon: Icon(Icons.camera), 
                label: Text("Camera")
              ),
              TextButton.icon(
                onPressed: () {
                  _pickImageFromGallery();
                }, 
                icon: Icon(Icons.image), 
                label: Text('Gallery')
                )
            ],
          )
        ],
      ),
    );
                                  })
                                );
                              }, 
                              icon: Icon(Icons.add_a_photo, color: Colors.blue,)
                            ),
                          ),
                          decoration: BoxDecoration(
                          ),
                        ),
                      )
                    ),
                  ] 
                ),
                ),
              ],
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              enabled: false,
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
              enabled: false,
            ),
            TextFormField(
              controller: notelpController,
              decoration: InputDecoration(
                labelText: 'No. Telp',
                prefixIcon: Icon(Icons.phone_android),
              ),
              enabled: false,
            ),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              enabled: false,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfilePage()),
          );
          if (result != null && result) {
            loadUserData(); // Update the UI if changes were made.
          }
        },
        child: Icon(Icons.edit),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (returnedImage == null) return;
    final imageFile = File(returnedImage.path);
    final imageBytes = await imageFile.readAsBytes();
    final username= usernameController.text;

    final result = await SQLHelper.updateProfileImages(username, imageBytes);

    if (result > 0) {
      setState(() {
        imageProfile = imageBytes;
        loadUserData();
      });
    }
    
  }

  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 25);

   
    if (returnedImage == null) return;
    final imageFile = File(returnedImage.path);
    final imageBytes = await imageFile.readAsBytes();
    final username= usernameController.text;

    final result = await SQLHelper.updateProfileImages(username, imageBytes);

    if (result > 0) {
      setState(() {
        imageProfile = imageBytes;
        loadUserData();
      });
    }
  }
}

