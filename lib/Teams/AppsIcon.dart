//Appearances icon and stat to display on player selected page
import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';

class AppsIcon extends StatelessWidget {

  final apps;

  AppsIcon(this.apps);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
              Icons.person_pin,
              size: MediaQuery.of(context).size.width / 4.5,
              )
              ,
          Text(apps,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(APPS.replaceAll(RegExp(':'), ''),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ],)
    );
  }
}