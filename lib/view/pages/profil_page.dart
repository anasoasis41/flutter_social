import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/util/alert_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/delegate/header_delegate.dart';
import 'package:flutter_social/view/my_widgets/profile_image.dart';
import 'package:flutter_social/view/tiles/post_tile.dart';


class ProfilPage extends StatefulWidget {

  final User user;

  ProfilPage(this.user);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  bool _isMe = false;
  ScrollController controller;
  double expanded = 200.0;
  bool get _showTitle {
    return controller.hasClients && controller.offset > expanded - kToolbarHeight;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isMe = (widget.user.uid == me.uid);
    controller = ScrollController()..addListener(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireHelper().postsFrom(widget.user.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return LoadingCenter();
        } else {
          List<DocumentSnapshot> documents = snapshot.data.documents;
          return CustomScrollView(
            controller: controller,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: expanded,
                actions: <Widget>[
                  (_isMe)
                      ? IconButton(icon: settings, color: pointer, onPressed: () => AlertHelper().disconnect(context))
                      : MyText("Suivre ou ne plus suivre")
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle ? MyText(widget.user.surname + " " + widget.user.name) : MyText(""),
                  background: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: profileImage, fit: BoxFit.cover)),
                    child: Center(child: ProfileImage(urlString: widget.user.imageUrl, size: 75.0, onPressed: null,),),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MyHeader(user: widget.user, callback: null, scrolled: _showTitle),
              ),
              SliverList(delegate: SliverChildBuilderDelegate((BuildContext context, index) {
                if (index == documents.length)
                  return ListTile(title: MyText("Fin de liste"),);
                if (index > documents.length)
                  return null;
                Post post = Post(documents[index]);
                return PostTile(post: post, user: widget.user);
              }),
              )
            ],
          );
        }
      },
    );
  }
}
























