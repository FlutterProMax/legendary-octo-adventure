import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseService{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

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
  
  
  Future<String> rasmYuklash(File file, String uid) async {
    try{
      final data = storage.ref()
          .child("profile_photos")
          .child("$uid.jpg");

      await data.putFile(file);

      // update
      await store.collection("Users")
        .doc(uid)
        .update({
          "photo" : data.fullPath
      });

      return await data.getDownloadURL();

    } on FirebaseException catch(e){
      throw(e.code);
    }
  }
}