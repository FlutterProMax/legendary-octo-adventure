import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostsPage extends StatefulWidget {
  final List posts;
  final Map user;
  const PostsPage({
    super.key,
    required this.posts,
    required this.user
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Posts",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22
          ),
        ),
      ),

      body: SafeArea(
        child: ListView.builder( // Changed from GridView to ListView
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: widget.posts.length,
            itemBuilder: (context, index){
              final post = widget.posts[index];

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Added vertical margin
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/profile.png"),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "${widget.user["username"]}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.more_vert)
                        ],
                      ),
                    ),

                    // Post photo
                    Container(
                      height: 400,
                      width: double.infinity,
                      child: Image.asset(
                        "${post["photo"]}",
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Icons row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(CupertinoIcons.heart, size: 28),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                icon: Icon(CupertinoIcons.bubble_left, size: 28),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              SizedBox(width: 8),
                              IconButton(
                                icon: Icon(CupertinoIcons.arrowshape_turn_up_right, size: 28),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(CupertinoIcons.bookmark, size: 28),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ],
                      ),
                    ),

                    // Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "${post["text"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Date
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                      child: Text(
                        DateFormat('MMM d • HH:mm').format(post["createdAt"].toDate()),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}