//goals icon and stat to display for selected player
import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';

class GoalsIcon extends StatelessWidget {

  final goals;

  GoalsIcon(this.goals);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
              Icons.sports_soccer,
              size: MediaQuery.of(context).size.width / 4.5,
              )
              ,
          Text(goals,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(GOALS.replaceAll(RegExp(':'), ''),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ],)
      
    );
  }
}