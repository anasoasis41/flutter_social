import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/view/my_widgets/bar_items.dart';
import 'package:flutter_social/view/my_widgets/bottom_bar.dart';
import 'package:flutter_social/view/pages/feed_page.dart';
import 'package:flutter_social/view/pages/new_post_page.dart';
import 'package:flutter_social/view/pages/notif_page.dart';
import 'package:flutter_social/view/pages/profil_page.dart';
import 'package:flutter_social/view/pages/users_page.dart';


class MainAppController extends StatefulWidget {

  String uid;
  MainAppController(this.uid);

  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  StreamSubscription streamListener;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Créer une souscription au stream
    streamListener = FireHelper().fire_user.document(widget.uid).snapshots().listen((document) {
      setState(() {
        me = User(document);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Arrêter le stream
    streamListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (me == null)
        ? LoadingScaffold()
        : Scaffold(
      key: _globalKey,
      backgroundColor: base,
      bottomNavigationBar: BottomBar(
        items: [
          BarItem(icon: homeIcon, onPressed: (() => buttonSelected(0)), selected: (index == 0)),
          BarItem(icon: friendsIcon, onPressed: (() => buttonSelected(1)), selected: (index == 1)),
          Container(width: 0.0, height: 0.0,),
          BarItem(icon: notifIcon, onPressed: (() => buttonSelected(2)), selected: (index == 2)),
          BarItem(icon: profilIcon, onPressed: (() => buttonSelected(3)), selected: (index == 3))
        ],
      ),
      body: showPage(),
      floatingActionButton: FloatingActionButton(onPressed: write, child: writeIcon, backgroundColor: pointer,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  write() {
    _globalKey.currentState.showBottomSheet((builder) => NewPost());
  }

  buttonSelected(int index) {
    print(index);
    setState(() {
      this.index = index;
    });
  }

  Widget showPage() {
    switch (index) {
      case 0: return FeedPage(widget.uid);
      case 1: return UsersPage();
      case 2: return NotifPage();
      case 3: return ProfilPage(me);
    }
  }

}













