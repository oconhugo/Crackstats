import 'package:flutter/material.dart';
import 'GoalsIcon.dart';
import 'AppsIcon.dart';
import 'YellowCardsIcon.dart';
import 'RedCardsIcon.dart';

class PlayerStatsWidget extends StatefulWidget {

  final String tempName;
  final String tempTeamName;
  final List tempStats;

  PlayerStatsWidget(this.tempName,this.tempTeamName,this.tempStats);

  @override
  _PlayerStatsWidgetState createState() => _PlayerStatsWidgetState(tempName,tempTeamName,tempStats);
}

class _PlayerStatsWidgetState extends State<PlayerStatsWidget> {

  String playerName;
  String teamName;
  var goals;
  var apps;
  var yellowCards;
  var redCards;

  _PlayerStatsWidgetState(this.playerName,this.teamName,playerStats){
    goals=playerStats[0];
    apps=playerStats[1];
    yellowCards=playerStats[2];
    redCards=playerStats[3];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
            playerName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
        ),
        Icon(
        Icons.account_circle_outlined,
        size: MediaQuery.of(context).size.width / 3,
       ),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Text(
            teamName,
            style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, fontSize: 26,decoration:TextDecoration.underline,),
            textAlign: TextAlign.left,
          ),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
        ),
        Table(         
                children: [
                TableRow(children: [GoalsIcon(goals),AppsIcon(apps)]),
                TableRow(children: [YellowCardsIcon(yellowCards),RedCardsIcon(redCards)]),
              ],            
        )
      ],
    );
  }
}