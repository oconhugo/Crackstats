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
  String goals = "", apps = "", cards = "";
  List userStats;

  @override
  void initState() {
    super.initState();
    getUserLeagues();
    getAllLeagues();
  }

  void getUserLeagues() async {
    var connect = new ConnectDB();
    var x = await connect.retrieveLeagues();
    setState(() {
      globalUserLeagueList = x;
    });
  }

  void getAllLeagues() async {
    var connect = new ConnectDB();
    var tempAllLeagues = await connect.retrieveAllLeagues();
    setState(() {
      globalLeagueList = tempAllLeagues;
    });
  }

  _ProfileInfoWidgetState(this.userMap) {
    profileInfo = {
      FIRSTNAME: userMap['First_Name'],
      LASTNAME: userMap['Last_Name'],
      EMAIL: userMap['Email'],
      DATEOFBIRTH: userMap['DOB'],
      PASSWORD: userMap['Password']
    };
  }

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
                          return PRIMARYCOLOR; // Use the component's default.
                        },
                      ),
                    ),
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
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return RED; // Use the component's default.
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
