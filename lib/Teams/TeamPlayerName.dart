import 'package:crackstats/ConnectDB.dart';
import 'package:crackstats/Teams/PlayerStatsUI.dart';
import 'package:flutter/material.dart';

class TeamPlayerName extends StatefulWidget {
  final String tempTeamName;
  final String temporalLeague;
  final List<dynamic> tempPlayerName;

  TeamPlayerName(this.tempTeamName, this.temporalLeague, this.tempPlayerName);

  @override
  _TeamPlayerNameState createState() =>
      _TeamPlayerNameState(tempTeamName, temporalLeague, tempPlayerName);
}

class _TeamPlayerNameState extends State<TeamPlayerName> {
  String teamName;
  String leagueName;
  String firstName;
  String lastName;
  var goals;
  var apps;
  var yellowCards;
  var redCards;

  _TeamPlayerNameState(this.teamName, this.leagueName, playerName) {
    firstName = playerName[0];
    lastName = playerName[1];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.13,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () async {
                var dbStatsConnect = new ConnectDB();
                var dbPlayerStats = await dbStatsConnect.retrievePlayerStats(
                    firstName, lastName, leagueName, teamName);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerStatsUI(
                          firstName + " " + lastName, teamName, dbPlayerStats),
                    ));
              },
              child: Text(firstName + " " + lastName),
            ),
          ),
        )
      ],
    );
  }
}
