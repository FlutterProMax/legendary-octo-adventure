import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram/class/message_class.dart';
import 'package:instagram/class/post_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireBaseService{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;


  User? getCurrentUser(){
    return auth.currentUser;
  }

  Future<UserCredential> register(String email, String password, String dob, String fullName, String username) async {
    try{
      // ro'yhatdan o'tkazdik
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      // uid
      final uid = userCredential.user?.uid;

      // hamma ma'lumotlar saqlash
      await store.collection("Users")
        .doc(uid)
        .set({
          "uid" : uid,
          "email" : email,
          "fullname" : fullName,
          "dob" : dob,
          "username" : username,
          "password" : password,
          "photo" : "",
          "createdAt" : DateTime.now()
      });

      return userCredential;

    } on FirebaseAuthException catch(err){
      throw(err.message!);
    }
  }


  Future<UserCredential> login(String email, String password) async {
    try{

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      return userCredential;

    } on FirebaseAuthException catch(err){
      throw(err.message!);
    }
  }



  Future<void> createPost(PostClass post) async {
    try{
      // firebase'ga jo'natish

      final uid = getCurrentUser()?.uid;

      DocumentReference ref = store.collection("Posts").doc();

      await ref.set({
        "postId" : ref.id,
        "uid" : uid,
        "text" : post.text,
        "username" : post.username,
        "avatar" : post.avatar,
        "photo" : post.photo,
        "likes" : post.likes_count,
        "comments" : 0,
        "createdAt" : DateTime.now()
      });

    } on FirebaseException catch(error){
      throw(error.message!);
    }
  }


  Future<void> addComment(String postId, String text) async {
    final uid = getCurrentUser()!.uid;

    final userData = await store.collection("Users").doc(uid).get();

    await store
      .collection("Posts")
      .doc(postId)
      .collection("Comments")
      .add({
        "uid" : uid,
        "username" : userData["username"],
        "text" : text,
        "createdAt" : Timestamp.now()
    });

    await store.collection("Posts").doc(postId).update({
      "comments" : FieldValue.increment(1)
    });
  }


  Stream<QuerySnapshot> getComments(String postId) {
    return store
        .collection("Posts")
        .doc(postId)
        .collection("Comments")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }


  Stream<List<Map<String, dynamic>>> getAllPosts() {
    return FirebaseFirestore.instance
      .collection("Posts")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).toList());
  }


  Stream<List<Map<String, dynamic>>> getAllUsers() {
    return FirebaseFirestore.instance
      .collection("Users")
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => doc.data()).toList());
  }


  Future<void> sendMessage(String recieverID, String message) async {
    SharedPreferences service = await SharedPreferences.getInstance();

    final String currentUserId = getCurrentUser()!.uid;
    final String currentUserUsername = service.getString("username") ?? "example";
    final Timestamp currentTime = Timestamp.now();


    MessageClass messageClass = MessageClass(
        senderID: currentUserId,
        senderUsername: currentUserUsername,
        recieverID: recieverID,
        text: message,
        time: currentTime
    );

    List<String> IDs = [currentUserId, recieverID];
    IDs.sort();
    String chatId = IDs.join('_');

    await store
      .collection("Chats")
      .doc(chatId)
      .collection("Messages")
      .add(
        {
          ...messageClass.toMap(),
          "isRead" : false
        }
      );
  }


  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {

    List<String> IDs = [userID, otherUserID];
    IDs.sort();
    String chatId = IDs.join('_');

    return store
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .orderBy("time", descending: false)
        .snapshots();

  }


  Future<QuerySnapshot<Map<String, dynamic>>> getUser() async {
    final currentUser = getCurrentUser();

    if (currentUser == null) {
      throw Exception("No user logged in");
    }

    return await store
        .collection("Users")
        .where('uid', isEqualTo: currentUser.uid)
        .limit(1)
        .get();
  }


  Stream<QuerySnapshot> getMyPostsStream(String uid) {
    return store
        .collection('Posts')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }


  Future<void> updateUserProfile(String fullname, String username, String email, String dob) async {
    final uid = getCurrentUser()!.uid;
    
    try{
      // update qilish
      await store.collection("Users").doc(uid).update({
        "fullname" : fullname,
        "username" : username,
        "email" : email,
        "dob" : dob,
        "updatedAt" : DateTime.now()
      });
    } on FirebaseException catch(error){
      throw(error);
    }
  }


  Stream<int> getUnreadCount(String otherUserId){
    String myId = getCurrentUser()!.uid;

    List<String> IDs = [myId, otherUserId];
    IDs.sort();
    String chatId = IDs.join('_');
    
    return store
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .where("recieverID", isEqualTo: myId)
        .where("isRead", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }
  
  
  Future<void> toggleLike(String postId) async {
    final uid = getCurrentUser()!.uid;

    final likeRef = store
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .doc(uid);

    final data = await likeRef.get();

    // layk bosilganmi
    if(data.exists){
      await likeRef.delete();
    } else{
      await likeRef.set({
        "likedAt" : Timestamp.now()
      });
    }

  }


  Stream<bool> isPostLiked(String postId){
    final uid = getCurrentUser()!.uid;

    return store
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .doc(uid)
        .snapshots()
        .map((doc) => doc.exists);
  }


  Stream<int> getPostCount(String postId){
    return store
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }


  Stream<List<Map<String, dynamic>>> getChatListWithLatestMessage() {
    final currentUserId = getCurrentUser()!.uid;

    return store
        .collection("Users")
        .snapshots()
        .asyncMap((usersSnapshot) async {
      List<Map<String, dynamic>> usersWithLastMessage = [];

      for (var userDoc in usersSnapshot.docs) {
        var user = userDoc.data();

        if (user["uid"] == currentUserId) continue;

        List<String> IDs = [currentUserId, user["uid"]];
        IDs.sort();
        String chatId = IDs.join('_');

        var lastMessageSnapshot = await store
            .collection("Chats")
            .doc(chatId)
            .collection("Messages")
            .orderBy("time", descending: true)
            .limit(1)
            .get();

        DateTime? lastMessageTime;

        if (lastMessageSnapshot.docs.isNotEmpty) {
          lastMessageTime = (lastMessageSnapshot.docs.first.data()["time"] as Timestamp).toDate();
        }

        usersWithLastMessage.add({
          ...user,
          "lastMessageTime": lastMessageTime,
        });
      }

      usersWithLastMessage.sort((a, b) {
        DateTime? timeA = a["lastMessageTime"];
        DateTime? timeB = b["lastMessageTime"];

        if (timeA != null && timeB != null) {
          return timeB.compareTo(timeA);
        }
        else if (timeA != null) {
          return -1;
        }
        else if (timeB != null) {
          return 1;
        }
        else {
          return (a["username"] as String).compareTo(b["username"] as String);
        }
      });

      return usersWithLastMessage;
    });
  }


}