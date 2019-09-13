import 'dart:io';

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
import 'package:flutter_social/view/my_widgets/my_textfield.dart';
import 'package:image_picker/image_picker.dart';


class ProfilPage extends StatefulWidget {

  final User user;

  ProfilPage(this.user);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  bool _isMe = false;
  ScrollController controller;
  TextEditingController _name;
  TextEditingController _surname;
  TextEditingController _desc;
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
    _name = TextEditingController();
    _surname = TextEditingController();
    _desc = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    _name.dispose();
    _surname.dispose();
    _desc.dispose();
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
                    child: Center(child: ProfileImage(urlString: widget.user.imageUrl, size: 75.0, onPressed: changeUser,),),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: MyHeader(user: widget.user, callback: changeFields, scrolled: _showTitle),
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

  void changeFields() {
    AlertHelper().changeUserAlert(context, name: _name, surname: _surname, desc: _desc);
  }

  void changeUser() {
    showModalBottomSheet(context: context, builder: (BuildContext ctx) {
      return Container(
        color: Colors.transparent,
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.all(7.5),
          child: Container(
            color: base,
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyText("Modification de la photo de profil"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(icon: camIcon, onPressed: (() {
                      takePicture(ImageSource.camera);
                      Navigator.pop(ctx);
                    })
                    ),
                    IconButton(icon: libraryIcon, onPressed: (() {
                      takePicture(ImageSource.gallery);
                      Navigator.pop(ctx);
                    }))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> takePicture(ImageSource source) async {
    File file = await ImagePicker.pickImage(source: source);
    FireHelper().modifyPicture(file);
  }

  validate() {

  }
}
























