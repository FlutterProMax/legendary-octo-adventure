import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/chat_page.dart';
import 'package:instagram/pages/create_page.dart';
import 'package:instagram/pages/profile_page.dart';
import 'package:instagram/pages/recommendation_page.dart';
import 'package:instagram/pages/reels_page.dart';
import 'package:instagram/pages/search_page.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:instagram/widget/comment_widget.dart';
import 'package:instagram/widget/story_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _service = FireBaseService();

  Map<String, dynamic> user = {};

  Future<void> getUser() async {
    final snapshot = await FireBaseService().getUser();

    // ma'lumot kelsa
    if(snapshot.docs.isNotEmpty){
      SharedPreferences service = await SharedPreferences.getInstance();
      service.setString("username", user["username"]);
      service.setString("fullname", user["fullname"]);
      service.setBool("isAuthenticated", true);

      setState(() {
        user = snapshot.docs.first.data();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // text
        title: Text(
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          "Ustagram",
        ),
        // markazlashtirdik
        centerTitle: true,

        // + iconchasi (chapga)
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePage()),
            );
          },
          icon: Icon(
            Icons.add,
            size: 27,
          ),
        ),

        // like iconchasi (o'ngga)
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.favorite_outline,
              size: 28,
            ),
          )
        ],
      ),

      // body
      body: CustomScrollView(
        slivers: [
          // Stories Section
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8.0),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              StoryWidget(image: "assets/cr7.jpg"),
                        ),
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
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/cr7.jpg"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              StoryWidget(image: "assets/messi.jpg"),
                        ),
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
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/messi.jpg"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              StoryWidget(image: "assets/neymar.jpg"),
                        ),
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
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/neymar.jpg"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) =>
                              StoryWidget(image: "assets/bape.jpg"),
                        ),
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
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/bape.jpg"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Posts Section
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: StreamBuilder(
              stream: _service.getAllPosts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text("Xatolik..."),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                // 3️⃣ data yo‘q
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text("Hozircha xabar yo‘q")),
                  );
                }

                // 4️⃣ data bor
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final post = snapshot.data![index];
                      return Column(
                        children: [
                          // row (avatar, username, 3 nuqta)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.deepOrange.shade500,
                                      backgroundImage: AssetImage(
                                        post["avatar"]
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "@${post["username"]}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Icon(
                                  Icons.more_vert,
                                  size: 27,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 7),

                          // rasm
                          Image.asset(
                            width: double.infinity,
                            post["photo"],
                            fit: BoxFit.cover,
                          ),

                          SizedBox(height: 10),

                          // iconchalar rowi
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    StreamBuilder(
                                        stream: FireBaseService().isPostLiked(post["postId"]),
                                        builder: (context, snapshot){
                                          bool liked = snapshot.data ?? false;

                                          return IconButton(
                                              onPressed: (){
                                                FireBaseService().toggleLike(post["postId"]);
                                              },
                                              icon:liked ?
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 30,
                                              )
                                                  :
                                              Icon(
                                                Icons.favorite_border,
                                                color: Colors.black,
                                                size: 30,
                                              )
                                          );
                                        }
                                    ),


                                    StreamBuilder<int>(
                                      stream: FireBaseService().getPostCount(post["postId"]),
                                      builder: (context, snapshot){
                                        int count = snapshot.data ?? 0;

                                        return Text(
                                          "$count",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                          ),
                                        );
                                      }
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) => CommentWidget(postId: post["postId"])
                                        );
                                      },
                                      child: Icon(
                                        CupertinoIcons.chat_bubble,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      post["comments"].toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.arrowshape_turn_up_right,
                                      size: 30,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.report_gmailerrorred_outlined,
                                      size: 30,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Report",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // text
                                Text(
                                  post["text"],
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17
                                  ),
                                ),

                                SizedBox(height: 5),

                                // sana
                                Text(
                                  DateFormat('MMM d • HH:mm')
                                      .format(post["createdAt"].toDate()),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 30),
                        ],
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigate to reels
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ChatPage(user: user)));
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

        color: Colors.grey.shade300,
        height: 67,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // stay at home
                },
                icon: Icon(
                  Icons.home,
                  size: 33,
                ),
              ),
              IconButton(
                onPressed: () {
                  // navigate to reels
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ReelsPage()));
                },
                icon: Icon(
                  Icons.video_collection_outlined,
                  size: 28,
                ),
              ),
              SizedBox(width: 40),
              IconButton(
                onPressed: () {
                  // navigate to search
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute
                  //       (builder: (_) => SearchPage())
                  // );
                },
                icon: Icon(
                  Icons.search,
                  size: 28,
                ),
              ),
              IconButton(
                onPressed: () {
                  // navigate to profile
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ProfilePage()));
                },
                icon: Icon(
                  Icons.person,
                  size: 28,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}