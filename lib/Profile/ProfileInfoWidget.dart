import 'package:flutter/material.dart';
import '../Constants.dart';
import 'ProfileInTxtWidget.dart';
import '../ConnectDB.dart';
import 'ProfileUI.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

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
  String goals = "", apps = "", cards = "";
  List userStats;
  String initialPassword = "";

  @override
  void initState() {
    super.initState();
    getUserLeagues();
    getAllLeagues();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  String encryptPass(String pwd) {
    String temp = pwd.substring(0, 2) + SALT + pwd.substring(3, pwd.length);
    pwd = generateMd5(temp);
    return pwd;
  }

  //Get the leagues wich the user belong
  void getUserLeagues() async {
    var connect = new ConnectDB();
    var x = await connect.retrieveLeagues();
    setState(() {
      globalUserLeagueList = x;
    });
  }

  //Get all the leagues
  void getAllLeagues() async {
    var connect = new ConnectDB();
    var tempAllLeagues = await connect.retrieveAllLeagues();
    setState(() {
      globalLeagueList = tempAllLeagues;
    });
  }

  //Set the local variables
  _ProfileInfoWidgetState(this.userMap) {
    initialPassword = userMap['Password'];
    profileInfo = {
      FIRSTNAME: userMap['First_Name'],
      LASTNAME: userMap['Last_Name'],
      EMAIL: userMap['Email'],
      DATEOFBIRTH: userMap['DOB'],
      PASSWORD: userMap['Password']
    };
  }

  //Get the user stats
  void getUserStats() async {
    var conn = new ConnectDB();
    userStats = await conn.retrieveUserStats(leagueSelected);
    setState(() {
      goals = userStats[0].toString();
      apps = userStats[1].toString();
      cards = userStats[2].toString() + "/" + userStats[3].toString();
    });
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
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                    getUserStats();
                  });
                },
                items: globalUserLeagueList.map((list) {
                  return DropdownMenuItem<String>(
                    value: list,
                    child: Text(list),
                  );
                }).toList(),
              )),
          Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    GOALS + goals,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
                  Expanded(
                    child: Text(
                      APPS + apps,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      YELLOWREDS + cards,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              )),
          Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return PRIMARYCOLOR;
                        },
                      ),
                    ),
                    child: Text(SAVE),
                    onPressed: () async {
                      var conn = new ConnectDB();
                      var result;
                      if (initialPassword == profileInfo['Password']) {
                        result = await conn.updateCred(profileInfo);
                      } else {
                        profileInfo['Password'] =
                            encryptPass(profileInfo['Password']);
                        result = await conn.updateCred(profileInfo);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileUI(result)));
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return RED;
                        },
                      ),
                    ),
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
