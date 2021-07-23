
//UI to display the stats widget for selected player
import 'package:flutter/material.dart';
import 'PlayerStatsWidget.dart';
import '../Constants.dart';

class PlayerStatsUI extends StatelessWidget {
  final String name;
  final String teamTempName;
  final List playerStats;

  PlayerStatsUI(this.name,this.teamTempName,this.playerStats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PLAYERSTATSTITLE),
        backgroundColor: PRIMARYCOLOR,
      ),
      body: Center(
        child: PlayerStatsWidget(name,teamTempName,playerStats),
    ));
  }
}
