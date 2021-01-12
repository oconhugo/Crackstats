import 'package:flutter/material.dart';
import '../Constants.dart';
import 'TeamPlayersWidget.dart';

class TeamPlayersUI extends StatelessWidget {
  final String teamName;
  final List playerName;

  TeamPlayersUI(this.teamName, this.playerName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PLAYERS),
        backgroundColor: PRIMARYCOLOR,
      ),
      body: TeamPlayersWidget(teamName, playerName),
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
