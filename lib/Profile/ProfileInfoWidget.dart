import 'package:crackstats/Register/RegisterInTxtWidget.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import 'ProfileInTxtWidget.dart';

class ProfileInfoWidget extends StatefulWidget {
  @override
  _ProfileInfoWidgetState createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  var json = {'name': 'Hugo', 'lastname': 'Ocon', 'dob': '1/1/2020'};
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...(json.keys).map((valkey) {
        return ProfileInTxtWidget(json, valkey);
      }).toList(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            color: PRIMARYCOLOR,
            textColor: WHITE,
            child: Text(SAVE),
            onPressed: () => {print(SAVE)},
          ),
          RaisedButton(
            color: RED,
            textColor: WHITE,
            child: Text(CANCEL),
            onPressed: () => {print(CANCEL)},
          ),
        ],
      )
    ]);
  }
}
