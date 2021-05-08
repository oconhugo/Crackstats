import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';
import '../LoadingSpinner.dart';
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
  List gamesList = [];
  List weekGames = [];
  List<bool> isVisibleList = [];
  var weekNum = [];
  var teamList;
  var maxWeek;

  _MyLeaguesScheduleState(this.userAdminLeagues);

  showSnackLeague() {
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(SELECTLEAGUE),
    ));
  }

  Future getGamesfromDB(weekNumber) async {
    var conndbGetWeeekGames = new ConnectDB();
    weekGames =
        await conndbGetWeeekGames.getWeekGames(weekNumber, leagueSelected);
    return weekGames;
  }

  getLeagueTeams() async {
    var conndbGetTeams = new ConnectDB();
    teamList = await conndbGetTeams.getLeagueTeams(leagueSelected);
    print(teamList);
  }

  getLeagueWeeks(league) async {
    var conndbGetWeeks = new ConnectDB();
    weekNum = await conndbGetWeeks.getLeagueWeeks(league);
    setState(() {});
    isVisibleList.length = weekNum.length;
    for (int i = 0; i < isVisibleList.length; i++) {
      isVisibleList[i] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
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
                getLeagueWeeks(leagueSelected);
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
      Center(
        child: Column(
          children: [
            ...(weekNum).map((valkey) {
              String tempWeekNum = valkey[0];
              var weeklistkey = (int.parse(valkey[0])) - 1;
              return Container(
                  child: Column(
                children: [
                  ElevatedButton(
                      child: Text(WEEK + " " + tempWeekNum),
                      onPressed: () {
                        setState(() {
                          isVisibleList[weeklistkey] =
                              !(isVisibleList[weeklistkey]);
                        });
                      }),
                  isVisibleList[weeklistkey]
                      ? FutureBuilder(
                          future: getGamesfromDB(valkey[0]),
                          builder: (context, snapshot) {
                            List games = List();
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              snapshot.data.forEach((value) {
                                games.add(value);
                              });
                              return Column(
                                children: [
                                  ...(games).map((valkey) {
                                    return ElevatedButton(
                                      child: Text(valkey[1] +
                                          " " +
                                          VS +
                                          " " +
                                          valkey[2]),
                                      onPressed: () {
                                        maxWeek = weekNum.length - 1;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddGameUI.prefilled(
                                                      leagueSelected,
                                                      teamList,
                                                      valkey[0],
                                                      maxWeek),
                                            ));
                                      },
                                    );
                                  })
                                ],
                              );
                            } else {
                              return LoadingSpinner();
                            }
                          })
                      : Text(""),
                ],
              ));
            }).toList(),
          ],
        ),
      ),
      ElevatedButton(
          child: Text(
            ADDGAME,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return PRIMARYCOLOR; // Use the component's default.
              },
            ),
          ),
          onPressed: () {
            if (isEnable) {
              maxWeek = weekNum.length - 1;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddGameUI(leagueSelected, teamList, maxWeek),
                  ));
            } else {
              showSnackLeague();
            }
          })
    ]));
  }
}
