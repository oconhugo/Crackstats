import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';
import '../ConnectDB.dart';

class NotificationPopUp {
  notificationType(notification, context) {
    if (notification[4] == "0") {
      return getAnnounNoti(notification, context);
    } else if (notification[4] == "1") {
      return getAddPlayerNoti(notification, context);
    } else {
      return getAddTeamNoti(notification, context);
    }
  }

  getAnnounNoti(notification, context) {
    return AlertDialog(
      title: Text(ANNOUNCEMENT),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(LEAGUETITLE + notification[6]),
            Text(notification[2]),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(OK),
            onPressed: () async {
              var conn = new ConnectDB();
              var response = await conn.removeNotification(notification[0]);
              print(response);
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  getAddPlayerNoti(notification, context) {
    return AlertDialog(
      title: Text(ADDPLAYERTITLE),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(notification[2] + ADDPLAYERMESSAGE),
            Text(TEAMTITLE + notification[5]),
            Text(LEAGUETITLE + notification[6]),
            Text(MESSAGETITLE + notification[1]),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(OK),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  getAddTeamNoti(notification, context) {
    return AlertDialog(
      title: Text(ADDTEAMSTITLE),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(notification[2] + ADDTEAMMESSAGE),
            Text(TEAMTITLE + notification[5]),
            Text(LEAGUETITLE + notification[6]),
            Text(MESSAGETITLE + notification[1]),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(OK),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  Future<void> showMyDialog(context, List<dynamic> notification) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return notificationType(notification, context);
      },
    );
  }
}
