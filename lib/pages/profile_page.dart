import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/pages/editprofile_page.dart';
import 'package:instagram/pages/login_page.dart';
import 'package:instagram/pages/posts_page.dart';
import 'package:instagram/pages/register_page.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Map<String, dynamic> user = {};
  String? uid;
  bool isLoading = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
    getPostsCount();
    getPhoto();
  }

  Future<void> getPostsCount() async {
    final posts = await FireBaseService().getMyPostsStream(FireBaseService().getCurrentUser()!.uid).first;

    setState(() {
      count = posts.docs.length;
    });
  }

  Future<void> _initializeData() async {
    // First, get the current user
    final currentUser = FireBaseService().getCurrentUser();

    if (currentUser != null) {
      setState(() {
        uid = currentUser.uid;
      });

      await getUser();
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getUser() async {
    if (uid == null) return;

    try {
      final snapshot = await FireBaseService().getUser();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          user = snapshot.docs.first.data();
        });
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          user["fullname"] ?? "Hello",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditprofilePage(user: user)
                )
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: BoxBorder.all(
                    color: Colors.grey.shade700,
                    width: 3
                  )
                ),
                child: Icon(
                  Icons.edit_outlined,
                  size: 23,
                ),
              ),
            ),
          )
        ],
      ),

      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20
          ),
          child: Column(
            children: [
              // username
              Text(
                user["username"] ?? "Hi",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // row (profile_photo, followers...
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 3
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : AssetImage(imagePath) as ImageProvider,
                    ),
                    Column(
                      children: [
                        Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "posts",
                          style: TextStyle(
                              fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "100",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "followers",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "100",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "following",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              // description

              // row (tugmachalar: edit & share profile)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                        side: BorderSide(
                          color: Colors.black12,
                          width: 2
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.grey.shade200,
                        fixedSize: Size(165, 50)
                      ),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditprofilePage(user: user)
                          )
                        );
                      },
                      child: Text(
                        "Edit profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        side: BorderSide(
                            color: Colors.black12,
                            width: 2
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.grey.shade200,
                        fixedSize: Size(165, 50)
                      ),
                      onPressed: (){
                        //
                      },
                      child: Text(
                        "Share profile",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // gridview
              StreamBuilder<QuerySnapshot>(
                stream: FireBaseService().getMyPostsStream(uid!),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No posts yet"));
                  }

                  final posts = snapshot.data!.docs;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      final post = posts[index].data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostsPage(posts: posts, user: user,)
                            )
                          );
                        },
                        child: Image.asset(
                          post["photo"],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
