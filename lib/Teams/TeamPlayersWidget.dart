import 'package:flutter/material.dart';
import 'TeamPlayerName.dart';

class TeamPlayersWidget extends StatefulWidget {
  final String teamNameTemp;
  final List playerName;
  final String tempLeague;

  TeamPlayersWidget(this.teamNameTemp, this.playerName,this.tempLeague);

  @override
  _TeamPlayerWidgetState createState() =>
      _TeamPlayerWidgetState(teamNameTemp, playerName,tempLeague);
}

class _TeamPlayerWidgetState extends State<TeamPlayersWidget> {
  String teamName;
  var playerName;
  String leagueSel;

  _TeamPlayerWidgetState(this.teamName, this.playerName,this.leagueSel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Text(
          teamName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          textAlign: TextAlign.center,
        )),
        Column(
          children: [
            ...(playerName).map((name) {
              return TeamPlayerName(name,teamName,leagueSel);
            }).toList()
          ],
        ),
      ],
    );
  }
}
