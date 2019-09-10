import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/util/fire_helper.dart';

class MainAppController extends StatefulWidget {

  String uid;
  MainAppController(this.uid);

  @override
  _MainAppControllerState createState() => _MainAppControllerState();
}

class _MainAppControllerState extends State<MainAppController> {

  StreamSubscription streamListener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Créer une souscription au stream
    streamListener = FireHelper().fire_user.document(widget.uid).snapshots().listen((document) {
      print(document.data);
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
    return LoadingScaffold();
  }
}
