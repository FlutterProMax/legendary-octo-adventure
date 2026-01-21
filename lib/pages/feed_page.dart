import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/chat_page.dart';
import 'package:instagram/pages/profile_page.dart';
import 'package:instagram/pages/reels_page.dart';
import 'package:instagram/pages/search_page.dart';
import 'package:instagram/widget/story_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        // text
        title: Text(
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold
          ),
          "Ustagram"
        ),
        // markazlashtirdik
        centerTitle: true,

        // + iconchasi (chapga)
        leading: Icon(
          Icons.add,
          size: 27,
        ),

        // like iconchasi (o'ngga)
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15
            ),
            child: Icon(
              Icons.favorite_outline,
              size: 28,
            ),
          )
        ],
      ),

      // body
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => StoryWidget(image: "assets/cr7.jpg")
                    )
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.redAccent,
                        Colors.brown,
                        Colors.orange,
                        Colors.orangeAccent,
                        Colors.yellowAccent
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        width: 4
                      )
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/cr7.jpg"
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => StoryWidget(image: "assets/messi.jpg")
                      )
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.redAccent,
                        Colors.brown,
                        Colors.orange,
                        Colors.orangeAccent,
                        Colors.yellowAccent
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.black,
                            width: 4
                        )
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/messi.jpg"
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => StoryWidget(image: "assets/neymar.jpg")
                      )
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.redAccent,
                        Colors.brown,
                        Colors.orange,
                        Colors.orangeAccent,
                        Colors.yellowAccent
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.black,
                            width: 4
                        )
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/neymar.jpg"
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => StoryWidget(image: "assets/bape.jpg")
                      )
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.redAccent,
                        Colors.brown,
                        Colors.orange,
                        Colors.orangeAccent,
                        Colors.yellowAccent
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Colors.black,
                            width: 4
                        )
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/bape.jpg"
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floating action butto

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // navigate to reels
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage()));
        },
        backgroundColor: Colors.black,
        shape: CircleBorder(),
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),

      // floating buttonni o'rtaga qo'yish
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        height: 60,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: (){
                  // stay at home
                },
                icon: Icon(
                  Icons.home,
                  size: 33,
                )
              ),
              IconButton(
                onPressed: (){
                  // navigate to reels
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ReelsPage()));
                },
                icon: Icon(
                  Icons.video_collection_outlined,
                  size: 28,
                )
              ),
              SizedBox(width: 40),
              IconButton(
                onPressed: (){
                  // navigate to search
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage()));
                },
                icon: Icon(
                  Icons.search,
                  size: 28,
                )
              ),
              IconButton(
                onPressed: (){
                  // navigate to profile
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
                },
                icon: Icon(
                  Icons.person,
                  size: 28,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
