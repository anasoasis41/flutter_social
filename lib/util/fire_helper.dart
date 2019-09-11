import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class FireHelper {

  // Auth
  final auth_instance = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String mail, String pwd) async {
    final FirebaseUser user = (await auth_instance.signInWithEmailAndPassword(email: mail, password: pwd)) as FirebaseUser;
    return user;
  }

  Future<AuthResult> createAccount(String mail, String pwd, String name, String surname) async {
    final AuthResult user = await auth_instance.createUserWithEmailAndPassword(email: mail, password: pwd);
    // Create user into DB
    String uid = user.user.uid;
    List<dynamic> followers = [];
    List<dynamic> following = [uid];
    Map<String, dynamic> map = {
      keyName: name,
      keySurname: surname,
      keyImageUrl: "",
      keyFollowers: followers,
      keyFollowing: following,
      keyUid: uid
    };
    addUser(uid, map);
    return user;
  }

  logout() => auth_instance.signOut();


  // Database
  static final data_instanse = Firestore.instance;
  final fire_user = data_instanse.collection("users");

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.document(uid).setData(map);
  }
  addPost(String uid, String text, File file) {
    int date = DateTime.now().millisecondsSinceEpoch.toInt();
    List<dynamic> likes = [];
    List<dynamic> comments = [];
    Map<String, dynamic> map = {
      keyUid: uid,
      keyLikes: likes,
      keyComments: comments,
      keyDate: date
    };
    if (text != null && text != "") {
      map[keyText] = text;
    }

    if (file != null) {
      StorageReference ref = storage_posts.child(uid).child(date.toString());
      addImage(file, ref).then((finalised) {
        String imageUrl = finalised;
        map[keyImageUrl] = imageUrl;
        fire_user.document(uid).collection("posts").document().setData(map);
      });
    } else {
      fire_user.document(uid).collection("posts").document().setData(map);
    }
  }


  // Storage
  static final storage_instance = FirebaseStorage.instance.ref();
  final storage_user = storage_instance.child("users");
  final storage_posts = storage_instance.child("posts");

  Future<String> addImage(File file, StorageReference ref) async {
    StorageUploadTask task = ref.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String urlString = await snapshot.ref.getDownloadURL();
    return urlString;
  }

}


















