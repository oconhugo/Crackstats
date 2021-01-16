import 'package:flutter/material.dart';

import '../Constants.dart';

class NotificationsUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      Container(
          height: 100,
          child: DrawerHeader(
              child: Text(
                NOTIFICATIONS,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: PRIMARYCOLOR,
              ))),
      //ListTile()
    ]));
  }
}
