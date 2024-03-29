//UI to display the team okayers widget and add player button
import 'package:flutter/material.dart';
import '../Constants.dart';
import 'TeamPlayersWidget.dart';
import 'AddPlayerUI.dart';

class TeamPlayersUI extends StatelessWidget {
  final String teamName;
  final List<dynamic> playerName;
  final String tempLeague;

  TeamPlayersUI(this.teamName, this.playerName, this.tempLeague);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PLAYERS),
        backgroundColor: PRIMARYCOLOR,
      ),
      body: SingleChildScrollView(
          child: TeamPlayersWidget(teamName, playerName, tempLeague)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPlayerUI(tempLeague, teamName)));
        },
        icon: Icon(Icons.add),
        label: Text(ADDPLAYER),
        backgroundColor: PRIMARYCOLOR,
      ),
    );
  }
}
