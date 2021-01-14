import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';

class YellowCardsIcon extends StatelessWidget {

  final yellowCards;

  YellowCardsIcon(this.yellowCards);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
              Icons.style_rounded,
              color: YELLOW,
              size: MediaQuery.of(context).size.width / 4.5,
              )
              ,
          Text(yellowCards,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(YELLOWCARDS,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ],)
      
    );
  }
}