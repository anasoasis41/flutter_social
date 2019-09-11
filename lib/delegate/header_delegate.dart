import 'package:flutter/material.dart';
import 'package:flutter_social/models/user.dart';
import 'package:flutter_social/view/my_material.dart';


class MyHeader extends SliverPersistentHeaderDelegate {

  User user;
  VoidCallback callback;
  bool scrolled;

  MyHeader({ @required this.user, @required this.callback, @required this.scrolled});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(10.0),
      color: baseAccent,
    );
  }

  @override
  double get maxExtent => (scrolled) ? 150.0 : 200.0;

  @override
  double get minExtent => (scrolled) ? 150.0 : 200.0;

  @override
  bool shouldRebuild(MyHeader oldDelegate) => scrolled != oldDelegate.scrolled || user != oldDelegate.user;


}