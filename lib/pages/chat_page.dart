import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/message_page.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic> user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  String username = "example";
  String searchText = "";

  Future<void> getUsername() async {
    SharedPreferences service = await SharedPreferences.getInstance();
    setState(() {
      username = service.getString("username") ?? "example";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          username,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value){
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                      CupertinoIcons.search
                  ),
                  hintText: "Search user...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)
                  )
              ),
            ),

            SizedBox(height: 20),

            Text(
              " People on Ustagram:",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500
              ),
            ),

            SizedBox(height: 20),

            Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: FireBaseService().getChatListWithLatestMessage(),
                    builder: (context, snapshot){
                      if(!snapshot.hasData){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<Map<String, dynamic>> allUsers = snapshot.data!;

                      List<Map<String, dynamic>> filteredUsers = allUsers.where((user) {
                        if (searchText.isEmpty) return true;

                        String username = user["username"]?.toString().toLowerCase() ?? "";
                        String fullname = user["fullname"]?.toString().toLowerCase() ?? "";

                        return username.contains(searchText) ||
                            fullname.contains(searchText);
                      }).toList();

                      return ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index){
                            var user = filteredUsers[index];

                            bool isCurrentUser = user["uid"] == FireBaseService().getCurrentUser()!.uid;

                            if(isCurrentUser == false){
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.orange,
                                          backgroundImage: AssetImage(
                                              "assets/profile.png"
                                          ),
                                        ),
                                        title: Text(
                                          user["username"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17
                                          ),
                                        ),
                                        subtitle: Text(
                                          user["fullname"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey
                                          ),
                                        ),

                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MessagePage(
                                                      otherUserId: user["uid"],
                                                      otherUserName: user["username"]
                                                  )
                                              )
                                          );
                                        },
                                      ),

                                      Positioned(
                                        child: StreamBuilder<int>(
                                            stream: FireBaseService().getUnreadCount(user["uid"]),
                                            builder: (context, snapshot) {
                                              if(!snapshot.hasData || snapshot.data == 0){
                                                return Container();
                                              }

                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle
                                                ),
                                                child: Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                padding: EdgeInsets.all(5),
                                              );
                                            }
                                        ),
                                        right: 15,
                                        top: 15,
                                      ),

                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              );
                            }
                            return Container();
                          }
                      );
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}