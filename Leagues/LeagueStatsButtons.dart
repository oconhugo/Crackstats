import 'package:flutter/material.dart';
import '../Constants.dart';

class LeagueStatsButtons extends StatefulWidget {
  @override
  _LeagueStatsButtonsState createState() => _LeagueStatsButtonsState();
}

class _LeagueStatsButtonsState extends State<LeagueStatsButtons> {
  @override
  Widget build(BuildContext context) {
    return Center( child:
      Column(
      children: [
        RaisedButton(
            color: PRIMARYCOLOR,
            textColor: WHITE,
            child: Text(STANDING),
            onPressed: () {
              
            },
        ),
        RaisedButton(
            color: PRIMARYCOLOR,
            textColor: WHITE,
            child: Text(GOALSCORERS),
            onPressed: () {
              
            },),
            RaisedButton(
            color: PRIMARYCOLOR,
            textColor: WHITE,
            child: Text(DISCIPLINE),
            onPressed: () {
              
            },),
      ],
    ));
  }
}