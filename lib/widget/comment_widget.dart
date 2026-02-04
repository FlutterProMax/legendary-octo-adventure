import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CommentWidget extends StatefulWidget {
  final String postId;
  const CommentWidget({super.key, required this.postId});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {


  String imagePath = "assets/profile.png";
  File? _imageFile;

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


  final _commentController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 700,
      child: Column(
        children: [
          Text(
            "Comments",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: StreamBuilder(
              stream: FireBaseService().getComments(widget.postId),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: Text(
                      "No Comment",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  );
                }

                return ListView(
                  children: snapshot.data!.docs.map((doc){
                    var comment = doc.data() as Map<String, dynamic>;

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/profile.png"
                        ),
                      ),
                      title: Text(
                        comment["username"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        child: Text(
                          maxLines: 3,
                          comment["text"],
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600
                          ),
                          softWrap: true,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            )
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // rasm
                CircleAvatar(
                  radius: 20,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : AssetImage(imagePath) as ImageProvider,
                ),

                SizedBox(width: 5),

                // textfield
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Add a comment...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),
                  )
                ),

                SizedBox(width: 5),

                // button
                IconButton(
                  onPressed: (){
                    if(_commentController.text.isNotEmpty){
                      FireBaseService().addComment(widget.postId, _commentController.text);
                      _commentController.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.lightBlue,
                    size: 28,
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
