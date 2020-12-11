import 'package:flutter/material.dart';
import '../SideMenu/SideBarMenu.dart';
import '../Constants.dart';

class LeaguesUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(LEAGUESTITLE),
          backgroundColor: PRIMARYCOLOR,
          ),
        drawer: SideBarMenu(),
        body: Text("Que tranza perro, este es el leagues ui"),
      ),
    );
  }
}