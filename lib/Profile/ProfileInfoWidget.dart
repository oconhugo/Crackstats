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
          Row(
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
          )
        ]);
  }
}
