import 'package:flutter/material.dart';
import 'package:flutter_social/view/my_material.dart';
import 'package:flutter_social/view/my_widgets/menu_two_items.dart';
import 'package:flutter_social/util/alert_helper.dart';


class LogController extends StatefulWidget {
  @override
  _LogControllerState createState() => _LogControllerState();
}

class _LogControllerState extends State<LogController> {

  PageController _pageController;
  TextEditingController _mail;
  TextEditingController _pwd;
  TextEditingController _name;
  TextEditingController _surname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _mail = TextEditingController();
    _pwd = TextEditingController();
    _name = TextEditingController();
    _surname = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _mail.dispose();
    _pwd.dispose();
    _name.dispose();
    _surname.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          // Notification received
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: InkWell(
            onTap: (() => hideKeyboard() ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: (MediaQuery.of(context).size.height >= 650.0) ? MediaQuery.of(context).size.height : 650.0,
              decoration: MyGradient(startColor: base, endColor: baseAccent),
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    PaddingWith(widget: Image(image: logoImage, height: 100,)),
                    PaddingWith(widget: Menu2Items(item1: "Connexion", item2: "Création",pageController: _pageController), top: 20.0, bottom: 20.0),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        children: <Widget>[logView(0), logView(1)],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget logView(int index) {
    return Column(
      children: <Widget>[
        PaddingWith(
          widget: Card(
            elevation: 7.5,
            color: white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: listItems((index == 0)),
              ),
            ),
          ),
          top: 15.0, bottom: 15.0,
        ),
        PaddingWith(
          top: 15.0, bottom: 15.0,
          widget: Card(
            elevation: 7.5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
            child: Container(
              width: 300.0,
              height: 50.0,
              decoration: MyGradient(startColor: baseAccent, endColor: base, radius: 25.0, horizontal: true),
              child: FlatButton(
                onPressed: () {
                  signIn((index == 0));
                },
                child: MyText((index == 0) ? "Se connecter" : "Créer un compte"),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<Widget> listItems(bool exists) {
    List<Widget> list = [];
    if (!exists) {
      list.add(MyTextField(controller: _surname, hint: "Entrer votre prénom"));
      list.add(MyTextField(controller: _name, hint: "Entrer votre nom"));
    }
    list.add(MyTextField(controller: _mail, hint: "Entrer votre addresse mail"));
    list.add(MyTextField(controller: _pwd, hint: "Entrer votre mot de passe", obscure: true,));

    return list;
  }

  signIn(bool exists) {
    hideKeyboard();
    if (_mail.text != null && _mail.text != "" ) {
      if (_pwd.text != null && _pwd.text != "" ) {
        if (exists) {
          // Connexion avec mail et password
          AlertHelper().error(context, "Tout est OK");
        } else {
          // Verifier nom et prenom puis inscription
          if (_name.text != null && _name.text != "" ) {
            if (_surname.text != null && _surname.text != "") {
              // Inscription
              AlertHelper().error(context, "Tout est OK");
            } else {
              // Alerte pas prénom
              AlertHelper().error(context, "Aucun prénom");
            }
          } else {
            // Alerte pas de nom
            AlertHelper().error(context, "Aucun nom");
          }
        }
      } else {
        // Alerte pas de password
        AlertHelper().error(context, "Aucun Mot de passe");
      }
    } else {
      // Alerte Pas de Mail
      AlertHelper().error(context, "Aucune adresse mail");
    }

  }

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

}













