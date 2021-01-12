import 'package:flutter/material.dart';
import 'TeamPlayerName.dart';
import '../ConnectDB.dart';

class TeamPlayersWidget extends StatefulWidget {
  final String teamNameTemp;
  final List playerName;

  TeamPlayersWidget(this.teamNameTemp, this.playerName);

  @override
  _TeamPlayerWidgetState createState() =>
      _TeamPlayerWidgetState(teamNameTemp, playerName);
}

class _TeamPlayerWidgetState extends State<TeamPlayersWidget> {
  String teamName;
  var playerName;

  _TeamPlayerWidgetState(this.teamName, this.playerName);

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
              return TeamPlayerName(name);
            }).toList()
          ],
        ),
      ],
    );
  }
}
