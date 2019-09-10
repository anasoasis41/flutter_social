import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/util/fire_helper.dart';
import 'package:flutter_social/view/my_widgets/bar_items.dart';
import 'package:flutter_social/view/my_widgets/bottom_bar.dart';

class MainAppController extends StatefulWidget {

  String uid;
  MainAppController(this.uid);

  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  StreamSubscription streamListener;
  User user;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Créer une souscription au stream
    streamListener = FireHelper().fire_user.document(widget.uid).snapshots().listen((document) {
      setState(() {
        user = User(document);
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
    return (user == null)
        ? LoadingScaffold()
        : Scaffold(
      key: _globalKey,
      bottomNavigationBar: BottomBar(
        items: [
          BarItem(icon: Icon(Icons.android), onPressed: (() => buttonSelected(0)), selected: (index == 0)),
          BarItem(icon: Icon(Icons.android), onPressed: (() => buttonSelected(1)), selected: (index == 1)),
          BarItem(icon: Icon(Icons.android), onPressed: (() => buttonSelected(2)), selected: (index == 2))
        ],
      ),
      body: Center(
        child: MyText(user.name,color: baseAccent,),
      )
    );
  }

  buttonSelected(int index) {
    print(index);
    setState(() {
      this.index = index;
    });
  }
}













