import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';


// User Global
User me;

const Color white = const Color(0xFFFFFFFF);
const Color base = const Color(0xFFBDBDBD);
const Color baseAccent = const Color(0xFF616161);
const Color pointer = const Color(0xFFF44336);

// Images
AssetImage logoImage = AssetImage("assets/mylogo.jpg");
AssetImage eventImage = AssetImage("assets/event.jpg");
AssetImage homeImage = AssetImage("assets/home.jpg");
AssetImage profileImage = AssetImage("assets/profile.jpg");

// Icons
Icon homeIcon = Icon(Icons.home);
Icon friendsIcon = Icon(Icons.group);
Icon notifIcon = Icon(Icons.notifications);
Icon profilIcon = Icon(Icons.account_circle);
Icon writeIcon = Icon(Icons.border_color);
Icon sendIcon = Icon(Icons.send);
Icon camIcon = Icon(Icons.camera_enhance);
Icon libraryIcon = Icon(Icons.photo_library);
Icon likeEmpty = Icon(Icons.favorite_border);
Icon likeFull = Icon(Icons.favorite);
Icon msgIcon = Icon(Icons.message);
Icon settings = Icon(Icons.settings);

// Keys
String keyName = "name";
String keySurname = "surname";
String keyImageUrl = "imageUrl";
String keyFollowers = "followers";
String keyFollowing = "following";
String keyUid = "uid";
String keyPostId = "postId";
String keyText = "text";
String keyDate = "date";
String keyLikes = "likes";
String keyComments = "comments";
String keyDescription = "description";
String keyType = "type";
String keyRef = "ref";
String keySeen = "seen";