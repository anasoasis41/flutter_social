import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';


class FeedPage extends StatefulWidget {

  User user;
  FeedPage(this.user);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: MyText("Fil d'actualité"));
  }
}
