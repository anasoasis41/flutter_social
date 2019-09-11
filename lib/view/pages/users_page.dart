import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';


class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: MyText("Liste des utilisteurs"));
  }
}
