import 'package:flutter/material.dart';

import '../Constants.dart';

class NotificationsUI extends StatefulWidget {
  final List<dynamic> usrNotifications;

  NotificationsUI(this.usrNotifications);

  @override
  _NotificationsUIState createState() =>
      _NotificationsUIState(usrNotifications);
}

class _NotificationsUIState extends State<NotificationsUI> {
  List<dynamic> userNotifications;

  _NotificationsUIState(this.userNotifications);

  Widget getNotificationType(String val){
    int x = int.parse(val);

    if(x==0){
      return Text(ANNOUNCEMENT, style: TextStyle(fontSize: 28));
    }
    else if(x==1){
      return Text(PLAYERNOTIFICATION, style: TextStyle(fontSize: 28));
    }
    else{
      return Text(TEAMNOTIFICATION, style: TextStyle(fontSize: 28));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      Container(
          height: 100,
          child: DrawerHeader(
              child: Text(
                NOTIFICATIONS,
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: WHITE),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: PRIMARYCOLOR,
              ))),
      ...(userNotifications).map((valkey) {
        return Card(
          child: ListTile(
          title: getNotificationType(valkey[4]),
          subtitle: Text(valkey[2], style: TextStyle(fontSize: 24)),
          onTap: () {},
        ));
      }).toList(),
    ]));
  }
}
