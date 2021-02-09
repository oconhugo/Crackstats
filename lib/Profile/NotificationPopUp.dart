import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';
import '../ConnectDB.dart';
import 'ProfileUI.dart';

class NotificationPopUp {
  Map infoMap;

  NotificationPopUp(this.infoMap);

  notificationType(notification, context) {
    if (notification[4] == "0") {
      return getAnnounNoti(notification, context);
    } else if (notification[4] == "2") {
      return getAddPlayerNoti(notification, context);
    } else {
      return getAddTeamNoti(notification, context);
    }
  }

  getAnnounNoti(notification, context) {
    return AlertDialog(
      title: Text(ANNOUNCEMENT,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              LEAGUETITLE + notification[6],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              notification[1],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(
              DELETE,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              var conn = new ConnectDB();
              var response = await conn.removeNotification(notification[0]);
              //Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUI(infoMap)));
            }),
        TextButton(
          child: Text(
            OK,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  getAddPlayerNoti(notification, context) {
    return AlertDialog(
      title: Text(ADDPLAYERTITLE,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              notification[2] + ADDPLAYERMESSAGE,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              TEAMTITLE + notification[5],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              LEAGUETITLE + notification[6],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              MESSAGETITLE + notification[1],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(
              ACCEPT,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              var dbconn = new ConnectDB();
              var acceptplayerresult =
                  await dbconn.acceptplayernotification(notification);
              print(acceptplayerresult);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUI(infoMap)));
            }),
        TextButton(
            child: Text(
              DECLINE,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              var dbconn = new ConnectDB();
              var declineplayerresult =
                  await dbconn.declineplayernotification(notification);
              print(declineplayerresult);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUI(infoMap)));
            }),
      ],
    );
  }

  getAddTeamNoti(notification, context) {
    return AlertDialog(
      title: Text(ADDTEAMSTITLE,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              notification[2] + ADDTEAMMESSAGE,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              TEAMTITLE + notification[5],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              LEAGUETITLE + notification[6],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              MESSAGETITLE + notification[1],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text(
              ACCEPT,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              var dbconn = new ConnectDB();
              var acceptteamresult =
                  await dbconn.acceptteamrequest(notification);
              print(acceptteamresult);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUI(infoMap)));
            }),
        TextButton(
            child: Text(
              DECLINE,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              var dbconn = new ConnectDB();
              var declineteamresult =
                  await dbconn.declineteamrequest(notification);
              print(declineteamresult);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUI(infoMap)));
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
