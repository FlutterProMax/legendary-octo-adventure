import 'package:cloud_firestore/cloud_firestore.dart';

class MessageClass{
  final String senderID;
  final String senderUsername;
  final String recieverID;
  final String text;
  final Timestamp time;

  MessageClass({
    required this.senderID,
    required this.senderUsername,
    required this.recieverID,
    required this.text,
    required this.time,
  });

  Map<String, dynamic> toMap(){
    return {
      "senderID" : senderID,
      "senderUsername" : senderUsername,
      "recieverID" : recieverID,
      "text" : text,
      "time" : time
    };
  }
}