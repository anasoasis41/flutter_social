import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter/cupertino.dart';


class AlertHelper {

  Future<void> error(BuildContext context, String error) async {
    MyText title = MyText("Erreur", color: Colors.black );
    MyText subTitle = MyText(error, color: Colors.black );
    return showDialog(
        context: context,
      barrierDismissible: true,
      builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(title: title, content: subTitle, actions: <Widget>[close(ctx, "OK")])
              : AlertDialog(title: title, content: subTitle, actions: <Widget>[close(ctx, "OK")]);
      }
    );
  }

  FlatButton close(BuildContext context, String text) {
    return FlatButton(
      onPressed: ( () => Navigator.pop(context)),
      child: MyText(text, color: pointer),
    );
  }
}