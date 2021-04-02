import 'package:flutter/material.dart';
import '../Constants.dart';
import '../LoadingSpinner.dart';
import '../ConnectDB.dart';

class LeaguesSchedule extends StatefulWidget {
  @override
  _LeaguesScheduleState createState() => _LeaguesScheduleState();
}

class _LeaguesScheduleState extends State<LeaguesSchedule> {
  String leagueSelected;
  List allLeagues;
  bool isLeagueSelected = false;
  Map weeksSelected;

  setWeeksSelectedVal(weeks) {
    weeksSelected =
        Map.fromIterable(weeks, key: (v) => v[0], value: (v) => false);
    print(weeksSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(children: [
                  FutureBuilder(
                      future: ConnectDB().retrieveAllLeagues(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          allLeagues = snapshot.data;
                          return DropdownButton<String>(
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
                                leagueSelected = newValue;
                                isLeagueSelected = true;
                              });
                            },
                            items: allLeagues.map((league) {
                              return DropdownMenuItem<String>(
                                value: league,
                                child: Text(league),
                              );
                            }).toList(),
                          );
                        } else {
                          return LoadingSpinner();
                        }
                      }),
                  isLeagueSelected
                      ? Container(
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: ConnectDB()
                                      .getLeagueWeeks(leagueSelected),
                                  builder: (context, snapshot) {
                                    List weeks = snapshot.data;
                                    setWeeksSelectedVal(weeks);
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Column(
                                        children: [
                                          ...(weeks).map((value) {
                                            return RaisedButton(
                                                child:
                                                    Text(WEEK + " " + value[0]),
                                                onPressed: () =>
                                                    print(value[0]));
                                          })
                                        ],
                                      );
                                    } else {
                                      return LoadingSpinner();
                                    }
                                  })
                            ],
                          ),
                        )
                      : Text(""),
                ]))));
  }
}
