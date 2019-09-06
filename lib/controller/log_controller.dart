import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';


class LogController extends StatefulWidget {
  @override
  _LogControllerState createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          // Notification received
          overScroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height >= 650.0) ? MediaQuery.of(context).size.height : 650.0,
            decoration: MyGradient(startColor: Colors.red, endColor: Colors.blue, horizontal: true),
          ),
        ),
      ),
    );
  }
}
