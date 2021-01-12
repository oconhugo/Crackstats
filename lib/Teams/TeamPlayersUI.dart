import 'package:flutter/material.dart';
import '../Constants.dart';
import '../SideMenu/SideBarMenu.dart';
import 'TeamPlayersWidget.dart';

class TeamPlayersUI extends StatelessWidget {
  final String teamName;

  TeamPlayersUI(this.teamName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PLAYERS),
        backgroundColor: PRIMARYCOLOR,
      ),
      drawer: SideBarMenu(),
      body: TeamPlayersWidget(teamName),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Navigator.push(context,
          //    MaterialPageRoute(builder: (context) => AddPlayer()));
        },
        icon: Icon(Icons.add),
        label: Text(ADDPLAYER),
        backgroundColor: PRIMARYCOLOR,
      ),
    );
  }
}
