import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/comment.dart';
import 'package:flutter_social/models/post.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/view/tiles/post_tile.dart';



class DetailPage extends StatelessWidget {

  User user;
  Post post;

  DetailPage(this.user, this.post);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: post.ref.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Post newPost = Post(snapshot.data);
          return ListView.builder(
              itemCount: newPost.comments.length + 1,
            itemBuilder: (BuildContext ctx, int index) {
                if (index == 0) {
                  return PostTile(post: newPost, user: user, detail: true,);
                } else {
                  Comment comment = Comment(post.comments[index - 1]);
                  return ListTile(title: MyText(comment.text),);
                }
            });
        } else {
          return LoadingCenter();
        }
      },
    );
  }
}