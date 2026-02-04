import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/pages/feed_page.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditprofilePage extends StatefulWidget {
  final Map<String, dynamic> user;
  const EditprofilePage({super.key, required this.user});

  @override
  State<EditprofilePage> createState() => _EditprofilePageState();
}

class _EditprofilePageState extends State<EditprofilePage> {
  String imagePath = "assets/profile.png";
  File? _imageFile;
  final ImagePicker picker = ImagePicker();

  // saqlangan rasmni olish
  Future<void> getPhoto() async {
    final miya = await SharedPreferences.getInstance();
    final savedPath = miya.getString("profile_photo");

    if (savedPath != null && savedPath.isNotEmpty) {
      if (savedPath.startsWith('assets/')) {
        setState(() {
          imagePath = savedPath;
          _imageFile = null;
        });
      } else {
        final file = File(savedPath);
        if (await file.exists()) {
          setState(() {
            _imageFile = file;
            imagePath = savedPath;
          });
        }
      }
    }
  }

  // funksiya -> camera
  Future<void> cameraDan() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    final miya = await SharedPreferences.getInstance();

    if (photo != null) {
      final file = File(photo.path);
      setState(() {
        _imageFile = file;
        imagePath = photo.path;
      });
      miya.setString("profile_photo", photo.path);
    }

    Navigator.pop(context);
  }

  // funksiya -> gallareya
  Future<void> gallareyaDan() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    final miya = await SharedPreferences.getInstance();

    if (photo != null) {
      final file = File(photo.path);
      setState(() {
        _imageFile = file;
        imagePath = photo.path;
      });
      miya.setString("profile_photo", photo.path);
    }

    Navigator.pop(context);
  }


  // Firebase servis chaqiramiz
  final service = FireBaseService();

  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _gmailController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fullnameController.text = widget.user["fullname"];
    _usernameController.text = widget.user["username"];
    _gmailController.text = widget.user["email"];
    _dobController.text = widget.user["dob"];

    getPhoto();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit profile",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 30
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // profile photo (circle avatar)
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.orangeAccent,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : AssetImage(imagePath) as ImageProvider,
                        ),
                        Positioned(
                            top: 80,
                            left: 88,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  shape: BoxShape.circle,
                                  border: BoxBorder.all(
                                      color: Colors.white,
                                      width: 3
                                  )
                              ),
                              child: IconButton(
                                  onPressed: (){
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context){
                                          return Container(
                                            height: 230,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 30,
                                                  horizontal: 30
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  // text
                                                  Text(
                                                    "Choose from Gallery or Camera",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 19,
                                                        color: Colors.deepOrange
                                                    ),
                                                  ),

                                                  // 2ta icon button
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            border: BoxBorder.all(
                                                                color: Colors.deepOrange,
                                                                width: 3
                                                            )
                                                        ),
                                                        child: IconButton(
                                                            onPressed: gallareyaDan,
                                                            icon: Icon(
                                                              CupertinoIcons.photo_fill,
                                                              size: 50,
                                                              color: Colors.orange,
                                                            )
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            border: BoxBorder.all(
                                                                color: Colors.deepOrange,
                                                                width: 3
                                                            )
                                                        ),
                                                        child: IconButton(
                                                            onPressed: cameraDan,
                                                            icon: Icon(
                                                              CupertinoIcons.photo_camera_solid,
                                                              size: 50,
                                                              color: Colors.orange,
                                                            )
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 30,
                                    color: Colors.white,
                                  )
                              ),
                            ),
                        ),
                      ],
                    ),

                    SizedBox(height: 50),

                    // 4ta textfield
                    TextField(
                      controller: _fullnameController,
                      decoration: InputDecoration(
                        labelText: "Fullname",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: _gmailController,
                      decoration: InputDecoration(
                          labelText: "Gmail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: _dobController,
                      decoration: InputDecoration(
                          labelText: "Dob",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),

                    SizedBox(height: 25),

                    // 2ta elevated button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(150, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(150, 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white
                          ),
                          onPressed: () async {
                            // o'zgarishni saqlash
                            try{
                              service.updateUserProfile(_fullnameController.text, _usernameController.text, _gmailController.text, _dobController.text);

                              SharedPreferences service2 = await SharedPreferences.getInstance();
                              service2.setString("username", _usernameController.text);
                              service2.setString("fullname", _fullnameController.text);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.black,
                                      content: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.center,
                                            "The changes have been saved",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                            ),
                                          ),

                                          Icon(
                                            CupertinoIcons.check_mark_circled_solid,
                                            color: Colors.green,
                                            size: 30,
                                          )
                                        ],
                                      )
                                  )
                              );

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FeedPage()
                                )
                              );

                            } catch(error){
                              throw(error);
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}