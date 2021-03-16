import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';
import 'AddGameUI.dart';

class MyLeaguesSchedule extends StatefulWidget {
  final List usrAdmList;

  MyLeaguesSchedule(this.usrAdmList);

  @override
  _MyLeaguesScheduleState createState() => _MyLeaguesScheduleState(usrAdmList);
}

class _MyLeaguesScheduleState extends State<MyLeaguesSchedule> {
  String leagueSelected;
  bool isEnable = false;
  List userAdminLeagues;
  var teamList;
  _MyLeaguesScheduleState(this.userAdminLeagues);

  showSnackLeague() {
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(SELECTLEAGUE),
    ));
  }

  getLeagueTeams() async {
    var conndbGetTeams = new ConnectDB();
    teamList = await conndbGetTeams.getLeagueTeams(leagueSelected);
    print(teamList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          width: MediaQuery.of(context).size.width / 1.5,
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(MYLEAGUESTITLE),
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
                isEnable = true;
                leagueSelected = newValue;
                getLeagueTeams();
              });
            },
            items: userAdminLeagues.map((list) {
              return DropdownMenuItem<String>(
                value: list,
                child: Text(list),
              );
            }).toList(),
          ),
        ),
      ),
      RaisedButton(
          child: Text(
            ADDGAME,
          ),
          textColor: WHITE,
          color: PRIMARYCOLOR,
          disabledColor: Colors.grey,
          onPressed: () {
            if (isEnable) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddGameUI(leagueSelected, teamList),
                  ));
            } else {
              showSnackLeague();
            }
          })
    ]);
  }
}
