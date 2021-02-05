import 'package:flutter/material.dart';
import '../Constants.dart';
import 'NotificationPopUp.dart';

class NotificationsUI extends StatefulWidget {
  final List<dynamic> usrNotifications;
  final Map information;

  NotificationsUI(this.usrNotifications,this.information);

  @override
  _NotificationsUIState createState() =>
      _NotificationsUIState(usrNotifications,information);
}

class _NotificationsUIState extends State<NotificationsUI> {
  List<dynamic> userNotifications;
  Map infoMap;

  _NotificationsUIState(this.userNotifications,this.infoMap);

  Widget getNotificationType(String val) {
    int x = int.parse(val);
    if (x == 0) {
      return Text(ANNOUNCEMENT, style: TextStyle(fontSize: 28));
    } else if (x == 2) {
      return Text(PLAYERNOTIFICATION, style: TextStyle(fontSize: 28));
    } else {
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
          onTap: () {
            var notificationPop = new NotificationPopUp(infoMap);
            notificationPop.showMyDialog(context, valkey);
          },
        ));
      }).toList(),
    ]));
  }
}
