import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  final String otherUserId;
  final String otherUserName;

  const MessagePage({
    super.key,
    required this.otherUserId,
    required this.otherUserName
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AudioPlayer _player;
  bool _shouldScrollToBottom = true;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    markAsRead();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom(immediate: true);
    });
  }

  void _scrollToBottom({bool immediate = false}) {
    if (_scrollController.hasClients) {
      if (immediate) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    _shouldScrollToBottom = (maxScroll - currentScroll) < 100;
  }


  @override
  void dispose() {
    _player.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    _scrollController.addListener(_onScroll);
    super.dispose();
  }

  Future<void> markAsRead() async {
    String myId = FireBaseService().getCurrentUser()!.uid;
    List<String> IDs = [myId, widget.otherUserId];
    IDs.sort();
    String chatId = IDs.join('_');

    var unreadMessages = await FirebaseFirestore.instance
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .where("recieverID", isEqualTo: myId)
        .where("isRead", isEqualTo: false)
        .get();

    for(var m in unreadMessages.docs){
      m.reference.update({"isRead": true});
    }
  }

  Future<void> playAudio() async {
    try {
      await _player.setSource(AssetSource('audio.mp3'));
      await _player.resume();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text(
          widget.otherUserName,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _messageList()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                            hintText: "Send message",
                            prefixIcon: Icon(CupertinoIcons.smiley, size: 30),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                      )
                  ),
                  IconButton(
                      onPressed: () async {
                        if(_messageController.text.isNotEmpty){
                          FireBaseService().sendMessage(widget.otherUserId, _messageController.text);
                          playAudio();
                          _messageController.clear();
                          _scrollToBottom();
                        }
                      },
                      icon: Icon(Icons.send_sharp, size: 35)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messageList(){
    String senderID = FireBaseService().getCurrentUser()!.uid;

    return StreamBuilder(
        stream: FireBaseService().getMessages(senderID, widget.otherUserId),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text(
                "Not Messages Yet",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent
                ),
              ),
            );
          }

          final messages = snapshot.data!.docs;
          if (messages.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_shouldScrollToBottom) {
                _scrollToBottom();
              }
            });
          }

          return ListView(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            children: messages.map((doc) => messageDesign(doc)).toList(),
          );
        }
    );
  }

  Widget messageDesign(DocumentSnapshot doc) {
    Map<String, dynamic> messages = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = messages["senderID"] == FireBaseService().getCurrentUser()!.uid;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: isCurrentUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isCurrentUser ? Colors.green : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    messages["text"],
                    style: TextStyle(
                      fontSize: 16,
                      color: isCurrentUser ? Colors.white : Colors.black,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(messages["time"].toDate()),
                        style: TextStyle(
                          fontSize: 12,
                          color: isCurrentUser ? Colors.white70 : Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (isCurrentUser)
                        messages["isRead"] ?
                        Icon(Icons.done_all, size: 14, color: Colors.white70) :
                        Icon(CupertinoIcons.checkmark_alt, size: 14, color: Colors.white70),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}