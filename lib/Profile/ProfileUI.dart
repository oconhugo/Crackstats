import 'package:crackstats/Profile/Notifications.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'ProfileMenuIcon.dart';
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
                /*leading: Builder(builder: (BuildContext context) {
                  return ProfileMenuIcon();
                })*/
                ),
            body: Center(
                child: Table(
              children: [
                TableRow(children: [PhotoWidget(infoMap['First_Name'])]),
                TableRow(children: [ProfileInfoWidget(infoMap)]),
              ],
            )),
            drawer: Drawer(
            child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container( 
              height: 100,
              child:DrawerHeader(
              child: Text('Menu',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              decoration: BoxDecoration(
              color: PRIMARYCOLOR,
              ))),
              ListTile(
              title: Text('Profile',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              onTap: () {
                null;
              },
              ),ListTile(
              title: Text('Leagues',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              onTap: () {
                null;
              },
              ),ListTile(
              title: Text('Teams',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              onTap: () {
                null;
              },
              ),
              ListTile(
              title: Text('Log Out',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.red[900]),textAlign: TextAlign.center,),
              onTap: () {
                null;
              },
              ),
          ],
        ),
      ),));
  }
}
