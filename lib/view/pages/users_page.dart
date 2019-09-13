import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/view/my_widgets/profile_image.dart';


class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireHelper().fire_user.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> documents = snapshot.data.documents;
          return NestedScrollView(
            headerSliverBuilder: (BuildContext build, bool scrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: MyText("Liste d'utilisateurs", color: baseAccent,),
                    background: Image(image: eventImage, fit: BoxFit.cover,),
                  ),
                  expandedHeight: 150.0,
                )
              ];
            },
            body: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext ctx, int index) {
                User user = User(documents[index]);
                return ListTile(
                  leading: ProfileImage(urlString: user.imageUrl, onPressed: null,),
                  title: MyText("${user.surname} ${user.name}", color: baseAccent,),
                  trailing: FollowButton(user: user,),
                );
              },
            ),
          );
        } else {
          return LoadingCenter();
        }
      },
    );
  }
}
