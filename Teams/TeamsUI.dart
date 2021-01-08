import 'package:crackstats/Teams/AddTeamUI.dart';
import 'package:flutter/material.dart';
import '../SideMenu/SideBarMenu.dart';
import '../Constants.dart';
import './TeamsWidget.dart';

class TeamsUI extends StatefulWidget {
  @override
  _TeamsUIState createState() => _TeamsUIState();
}

class _TeamsUIState extends State<TeamsUI> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(TEAMSTITLE),
          backgroundColor: PRIMARYCOLOR,
          ),
        drawer: SideBarMenu(),
        body: TeamsWidget(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTeamUI()));
          },         
          icon: Icon(Icons.add),
          label: Text(CREATETEAM),
          backgroundColor: PRIMARYCOLOR,
        ),
      ),
    );
  }
}