import 'package:crackstats/Profile/NotificationsUI.dart';
import '../SideMenu/SideBarMenu.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'PhotoWidget.dart';
import 'ProfileInfoWidget.dart';

class ProfileUI extends StatelessWidget {
  final Map infoMap;

  ProfileUI(this.infoMap);

  //ProfileUI(this.userInfo);
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
                  icon: const Icon(Icons.notifications_none),
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
            TableRow(children: [PhotoWidget(infoMap['First_Name'])]),
            TableRow(children: [ProfileInfoWidget(infoMap)]),
          ],
        ))),
        drawer: SideBarMenu(),
        endDrawer: NotificationsUI(),
      ),
    );
  }
}
