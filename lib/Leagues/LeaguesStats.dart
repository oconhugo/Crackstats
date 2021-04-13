import 'package:flutter/material.dart';
import '../LoadingSpinner.dart';
import 'LeagueStatsButtons.dart';
import '../ConnectDB.dart';
import '../Constants.dart';
import 'dart:convert';

class LeaguesStats extends StatefulWidget {
  @override
  _LeaguesStatsState createState() => _LeaguesStatsState();
}

class _LeaguesStatsState extends State<LeaguesStats> {
  List allLeagues;
  String leagueSelected;
  bool isLeagueSelected = false;
  Map buttonSelected = {STANDING: false, GOALSCORERS: false, DISCIPLINE: false};

  Widget createTable() {
    return Column(
      children: [Text('')],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Column(children: [
                      FutureBuilder(
                          future: ConnectDB().retrieveAllLeagues(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
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
                          ? Center(
                              child: Column(
                                children: [
                                  RaisedButton(
                                    child: Text(STANDING),
                                    onPressed: () {
                                      setState(() {
                                        buttonSelected[STANDING] =
                                            !buttonSelected[STANDING];
                                      });
                                    },
                                  ),
                                  buttonSelected[STANDING]
                                      ? FutureBuilder(
                                          future: ConnectDB()
                                              .retrieveAllLeagueGames(
                                                  leagueSelected),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return createTable();
                                            } else {
                                              return LoadingSpinner();
                                            }
                                          })
                                      : Text(''),
                                  RaisedButton(
                                    child: Text(GOALSCORERS),
                                    onPressed: () {
                                      setState(() {
                                        buttonSelected[GOALSCORERS] =
                                            !buttonSelected[GOALSCORERS];
                                      });
                                    },
                                  ),
                                  buttonSelected[GOALSCORERS]
                                      ? FutureBuilder(
                                          future: null,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return Text("1");
                                            } else {
                                              return Text("");
                                            }
                                          })
                                      : Text(''),
                                  RaisedButton(
                                    child: Text(DISCIPLINE),
                                    onPressed: () {
                                      setState(() {
                                        buttonSelected[DISCIPLINE] =
                                            !buttonSelected[DISCIPLINE];
                                      });
                                    },
                                  ),
                                  buttonSelected[DISCIPLINE]
                                      ? FutureBuilder(
                                          future: null,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return Text("1");
                                            } else {
                                              return Text("");
                                            }
                                          })
                                      : Text(''),
                                ],
                              ),
                            )
                          : Text(""),
                    ])))));
  }
}
