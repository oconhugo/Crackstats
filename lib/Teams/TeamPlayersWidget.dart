//Widget that displays the players from selected league as buttons to be clicked
import 'package:flutter/material.dart';
import 'TeamPlayerName.dart';

class TeamPlayersWidget extends StatefulWidget {
  final String teamNameTemp;
  final String tempLeague;
  final List<dynamic> tempPlayerNames;

  TeamPlayersWidget(this.teamNameTemp, this.tempPlayerNames,this.tempLeague);

  @override
  _TeamPlayerWidgetState createState() =>
      _TeamPlayerWidgetState(teamNameTemp, tempPlayerNames,tempLeague);
}

class _TeamPlayerWidgetState extends State<TeamPlayersWidget> {
  String teamName;
  String leagueSel;
  var playerNames;

  _TeamPlayerWidgetState(this.teamName, this.playerNames,this.leagueSel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
      child:
      Column(
      children: [
        Center( 
          child: Text(
          teamName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          textAlign: TextAlign.center,
        )),
        Column(
          children: [
            ...(playerNames).map((name) {
              return TeamPlayerName(teamName,leagueSel,name);
            }).toList()
          ],
        ),
      ],
    ));
  }
}
