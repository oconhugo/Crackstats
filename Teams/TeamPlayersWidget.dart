import 'package:flutter/material.dart';

class TeamPlayersWidget extends StatefulWidget {

  final String teamNameTemp;

  TeamPlayersWidget(this.teamNameTemp);

  @override
  _TeamPlayerWidgetState createState() => _TeamPlayerWidgetState(teamNameTemp);
}

class _TeamPlayerWidgetState extends State<TeamPlayersWidget> {

  String teamName;

  _TeamPlayerWidgetState(this.teamName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(teamName),
    );
  }
}