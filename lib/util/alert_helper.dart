import 'package:flutter/material.dart';
import 'package:flutter_social/util/fire_helper.dart';
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

  Future<void> disconnect(BuildContext context) async {
    MyText title = MyText("Voulez-vous vous déconnecter ?", color: base,);
    return showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(title: title, actions: <Widget>[close(ctx, "Non"), disconnectBtn(ctx)],)
              : AlertDialog(title: title,actions: <Widget>[close(ctx, "Non"), disconnectBtn(ctx)],);
      }
    );
  }

  void changeUser(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext ctx) {
      return Container(
        color: base,
      );
    });
  }

  FlatButton disconnectBtn(BuildContext context) {
    return FlatButton(
      onPressed: () {
        FireHelper().logout();
        Navigator.pop(context);
      },
      child: MyText("Oui", color: Colors.blue,),
    );
  }

  FlatButton close(BuildContext context, String text) {
    return FlatButton(
      onPressed: ( () => Navigator.pop(context)),
      child: MyText(text, color: pointer),
    );
  }
}