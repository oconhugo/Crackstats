import 'package:crackstats/Profile/Notifications.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import './ProfileAppBar.dart';
import 'PhotoWidget.dart';
import 'ProfileInfoWidget.dart';

//import 'dart:convert'; //to convert json to maps and vice versa
//import 'package:path_provider/path_provider.dart'; //add path provider dart plugin on pubspec.yaml file

class ProfileUI extends StatelessWidget {
  final Map infoMap;

  ProfileUI(this.infoMap);

  //ProfileUI(this.userInfo);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: PRIMARYCOLOR,
                actions: [Notifications()],
                leading: Builder(builder: (BuildContext context) {
                  return ProfileAppBar();
                })),
            body: Center(
                child: Table(
              children: [
                TableRow(children: [PhotoWidget(infoMap['First_Name'])]),
                TableRow(children: [ProfileInfoWidget(infoMap)]),
              ],
            ))));
  }
}
