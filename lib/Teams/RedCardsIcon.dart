//red cards icon and stat on the players stat page
import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';

class RedCardsIcon extends StatelessWidget {

  final redCards;

  RedCardsIcon(this.redCards);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
              Icons.style_rounded,
              color: RED,
              size: MediaQuery.of(context).size.width / 4.5,
              )
              ,
          Text(redCards.replaceAll(RegExp(':'), ''),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(REDCARDS,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ],)
      
    );
  }
}