import 'package:flutter/material.dart';
import '../Constants.dart';
import 'ProfileInTxtWidget.dart';
import '../ConnectDB.dart';
import 'ProfileUI.dart';

class ProfileInfoWidget extends StatefulWidget {
  final Map inputMap;

  ProfileInfoWidget(this.inputMap);

  @override
  _ProfileInfoWidgetState createState() => _ProfileInfoWidgetState(inputMap);
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  Map userMap;
  var profileInfo;
  var leagueSelected;
  var leaguesDropdown = [
    DropdownMenuItem(
      child: Text('League 1'),
      value: MALE,
    ),
  ];

  _ProfileInfoWidgetState(this.userMap) {
    profileInfo = {
      FIRSTNAME: userMap['First_Name'],
      LASTNAME: userMap['Last_Name'],
      EMAIL: userMap['Email'],
      DATEOFBIRTH: userMap['DOB'],
      PASSWORD: userMap['Password']
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...(profileInfo.keys).map((valkey) {
            return ProfileInTxtWidget(profileInfo, valkey);
          }).toList(),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
              width: MediaQuery.of(context).size.width / 2,
              child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(LEAGUES),
                  value: leagueSelected,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 24,
                  style: TextStyle(color: PRIMARYCOLOR),
                  underline: Container(
                    height: 2,
                    color: PRIMARYCOLOR,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      leagueSelected = newValue;
                    });
                  },
                  items: leaguesDropdown)),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
            //width: MediaQuery.of(context).size.width / 2,
            child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Text(
                GOALS,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Expanded(child: Text(
                APPS,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ),
              Expanded(child: 
              Text(
              YELLOWREDS,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.left,
              ),)
            ],
          )),
          /*Container(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
          width: MediaQuery.of(context).size.width / 2,
          child:
          Text(
            YELLOWREDS,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.left,
          )),*/
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: PRIMARYCOLOR,
                textColor: WHITE,
                child: Text(SAVE),
                onPressed: () async {
                  var conn = new ConnectDB();
                  var result = await conn.updateCred(profileInfo);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileUI(result)));
                },
              ),
              RaisedButton(
                color: RED,
                textColor: WHITE,
                child: Text(CANCEL),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileUI(userMap)));
                },
              ),
            ],
          ))
        ]);
  }
}
