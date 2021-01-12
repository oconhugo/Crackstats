import 'package:crackstats/Teams/PlayerStatsUI.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

class TeamPlayerName extends StatefulWidget {
  final String name;

  TeamPlayerName(this.name);

  @override
  _TeamPlayerNameState createState() => _TeamPlayerNameState(name);
}

class _TeamPlayerNameState extends State<TeamPlayerName> {
  String name;

  _TeamPlayerNameState(this.name);

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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayerStatsUI(name),
                  ));
            },
            child: Text(name),
          ),
        )
      ],
    );
  }
}
