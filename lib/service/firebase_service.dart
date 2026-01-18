import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';

class FireBaseService{

  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<UserCredential> register(String email, String password) async {
    try{

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

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


}