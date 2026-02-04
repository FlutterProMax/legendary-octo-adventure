import 'dart:ui';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/class/post_class.dart';
import 'package:instagram/pages/feed_page.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {

  final _textController = TextEditingController();
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Post",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Center(
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 25
              ),
              child: Column(
                children: [

                  // eslatma
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: BoxBorder.fromBorderSide(
                        BorderSide(
                          color: Colors.red,
                          width: 2
                        ),
                      )
                    ),
                    child: Row(
                      children: [
                        // iconcha
                        Icon(
                          CupertinoIcons.info,
                          size: 28,
                          color: Colors.redAccent,
                        ),

                        SizedBox(width: 5),

                        // text
                        Text(
                          "For now you cannot upload photo",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
        
                  // rasm
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: Image.asset(
                  //     height: 300,
                  //     width: double.infinity,
                  //     fit: BoxFit.cover,
                  //     "assets/ruschaekan.jpg"
                  //   ),
                  // ),

                  SizedBox(height: 25),

                  // text
                  TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Write a post...',
                      // labelText: "Caption",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(350, 50),
                      side: BorderSide(
                        color: Colors.blue,
                        width: 2
                      )
                    ),
                    onPressed: () async {
                      // random rasm olish
                      List<String> rasmlar = [
                        "assets/bape.jpg",
                        "assets/cr7.jpg",
                        "assets/neymar.jpg",
                        "assets/messi.jpg",
                        "assets/ruschaekan.jpg"
                      ];

                      int tasadifiy_raqam = _random.nextInt(rasmlar.length);

                      // firebase'ga ulash

                      // SharedPref'da usernam olish
                      SharedPreferences service = await SharedPreferences.getInstance();
                      String username = service.getString("username") ?? "@example";

                      if(_textController.text.isNotEmpty){
                        PostClass post = PostClass(
                            photo: rasmlar[tasadifiy_raqam],
                            text: _textController.text,
                            username: username,
                            avatar: "assets/profile.png",
                            likes_count: 0,
                            comments_count: 0
                        );

                        FireBaseService _fService = FireBaseService();
                        _fService.createPost(post);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedPage()
                          )
                        );
                      }
                    },
                    child: Text(
                      "Share with people on Ustagram",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  )
              ],
              ),
          ),
        ),
      ),
    );
  }
}
