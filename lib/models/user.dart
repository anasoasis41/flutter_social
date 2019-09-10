

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_social/view/my_widgets/constants.dart';

class User {

  String uid;
  String name;
  String surname;
  String imageUrl;
  List<dynamic> followers;
  List<dynamic> following;
  DocumentReference ref;
  String documentId;

  User(DocumentSnapshot snapshot) {
    ref = snapshot.reference;
    documentId = snapshot.documentID;
    Map<String, dynamic> map;
    uid = map[keyUid];
    name = map[keyName];
    surname = map[keySurname];
    imageUrl = map[keyImageUrl];
    followers = map[keyFollowers];
    following = map[keyFollowing];
  }

  Map<String, dynamic> toMap() {
    return {
      keyUid: uid,
      keyName: name,
      keySurname: surname,
      keyImageUrl: imageUrl,
      keyFollowing: following,
      keyFollowers: followers
    };
  }

}