import 'package:flutter/material.dart';
import 'TeamPlayerName.dart';
import '../ConnectDB.dart';

class TeamPlayersWidget extends StatefulWidget {
  final String teamNameTemp;

  TeamPlayersWidget(this.teamNameTemp);

  @override
  _TeamPlayerWidgetState createState() => _TeamPlayerWidgetState(teamNameTemp);
}

class _TeamPlayerWidgetState extends State<TeamPlayersWidget> {
  String teamName;
  var playerName = ["f g", "d f"];
  var playerNameTemp;

  _TeamPlayerWidgetState(this.teamName) {
    getPlayers();
  }

  void getPlayers() async {
    var y = new ConnectDB();
    var temp = await y.retrieveTeamPlayers(teamName);
    setPlayerName(temp);
  }

  void setPlayerName(temp) {
    List playerNameTemp = List();
    for (int i = 0; i < temp.length; i++) {
      String tempName = temp[i][0] + " " + temp[i][1];
      playerNameTemp.add(tempName);
    }
    print(playerNameTemp);
  }

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
