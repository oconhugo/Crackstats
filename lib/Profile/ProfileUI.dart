import 'package:crackstats/Profile/NotificationsUI.dart';
import '../SideMenu/SideBarMenu.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'PhotoWidget.dart';
import 'ProfileInfoWidget.dart';
import '../ConnectDB.dart';

class ProfileUI extends StatefulWidget {
  final Map infoMap;

  ProfileUI(this.infoMap) {}

  @override
  _ProfileUIState createState() => _ProfileUIState(infoMap);
}

class _ProfileUIState extends State<ProfileUI> {
  List<dynamic> userNotifications;
  Map informationMap;

  _ProfileUIState(this.informationMap) {
    getNotifications();
  }

  bool isNotifications = false;

  void getNotifications() async {
    var connector = new ConnectDB();
    userNotifications = await connector.getUserNotifications();
    setState(() {
      if (userNotifications != null && userNotifications.isNotEmpty) {
        isNotifications = true;
      } else {
        isNotifications = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(PROFILETITLE),
          backgroundColor: PRIMARYCOLOR,
          actions: [
            Builder(
              builder: (context) => IconButton(
                  icon: (isNotifications)
                      ? const Icon(
                          Icons.notifications,
                          color: YELLOW,
                        )
                      : const Icon(Icons.notifications_none),
                  iconSize: kToolbarHeight - 15,
                  tooltip: NOTIFICATIONS,
                  onPressed: () => Scaffold.of(context).openEndDrawer()),
            ),
          ],
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Table(
          children: [
            TableRow(children: [PhotoWidget(widget.infoMap['First_Name'])]),
            TableRow(children: [ProfileInfoWidget(widget.infoMap)]),
          ],
        ))),
        drawer: SideBarMenu(),
        endDrawer: NotificationsUI(userNotifications,informationMap),
      ),
    );
  }
}
