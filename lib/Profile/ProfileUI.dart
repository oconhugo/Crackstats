import 'package:flutter/material.dart';
import 'PhotoWidget.dart';
import 'ProfileInfoWidget.dart';
import '../Constants.dart';
//import 'dart:convert'; //to convert json to maps and vice versa
//import 'package:path_provider/path_provider.dart'; //add path provider dart plugin on pubspec.yaml file

class ProfileUI extends StatelessWidget {
  //ProfileUI(this.userInfo);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Table(
      children: [
        TableRow(children: [PhotoWidget()]),
        TableRow(children: [ProfileInfoWidget()]),
      ],
    )));
  }
}
