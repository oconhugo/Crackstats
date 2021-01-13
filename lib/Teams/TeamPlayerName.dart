import 'package:crackstats/ConnectDB.dart';
import 'package:crackstats/Teams/PlayerStatsUI.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

class TeamPlayerName extends StatefulWidget {
  final String name;
  final String tempTeamName;
  final String temporalLeague;

  TeamPlayerName(this.name,this.tempTeamName,this.temporalLeague);

  @override
  _TeamPlayerNameState createState() => _TeamPlayerNameState(name,tempTeamName,temporalLeague);
}

class _TeamPlayerNameState extends State<TeamPlayerName> {
  String name;
  String teamName;
  String leagueName;
  String firstName;
  String lastName;

  _TeamPlayerNameState(this.name,this.teamName,this.leagueName){
    firstName="";
    lastName="";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: FlatButton(
            shape:
                RoundedRectangleBorder(side: BorderSide(color: PRIMARYCOLOR)),
            minWidth: MediaQuery.of(context).size.width / 1.13,
            onPressed: () {
              var dbStatsConnect = new ConnectDB();
              var dbPlayerStats = dbStatsConnect.retrievePlayerStats(firstName, lastName, leagueName, teamName);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerStatsUI(name,teamName),
                  ));
            },
            child: Text(name),
          ),
        )
      ],
    );
  }
}
