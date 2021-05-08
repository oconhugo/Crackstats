import 'package:flutter/material.dart';
import '../LoadingSpinner.dart';
import '../ConnectDB.dart';
import '../Constants.dart';

class LeaguesStats extends StatefulWidget {
  @override
  _LeaguesStatsState createState() => _LeaguesStatsState();
}

class _LeaguesStatsState extends State<LeaguesStats> {
  List allLeagues;
  String leagueSelected;
  bool isLeagueSelected = false;
  Map buttonSelected = {STANDING: false, GOALSCORERS: false, DISCIPLINE: false};

  bubbleSorting(statsArray, arrayNum) {
    //arrayNum = array index on which list is being sorted
    int arrLength = statsArray.length;
    for (int i = 0; i < arrLength - 1; i++) {
      for (int j = 0; j < arrLength - i - 1; j++) {
        if (int.parse(statsArray[j][arrayNum]) <
            int.parse(statsArray[j + 1][arrayNum])) {
          var temp = statsArray[j];
          statsArray[j] = statsArray[j + 1];
          statsArray[j + 1] = temp;
        }
      }
    }
  }

  Widget createStandings(gameStats) {
    bubbleSorting(gameStats, 6);
    int tablePosition = 0;
    return Column(
      children: [
        ...(gameStats).map((gameStat) {
          tablePosition = tablePosition + 1;
          return Card(
              child: ListTile(
                  title: Text(tablePosition.toString() + " " + gameStat[1],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    children: [
                      Text(GF + " " + gameStat[7] + "  "),
                      Text(GA + " " + gameStat[8] + "  "),
                      Text(GD +
                          " " +
                          (int.parse(gameStat[7]) - int.parse(gameStat[8]))
                              .toString() +
                          "  ")
                    ],
                  ),
                  trailing: Text(gameStat[6],
                      style: TextStyle(fontWeight: FontWeight.bold))));
        })
      ],
    );
  }

  Widget createScorerTable(scorersNames) {
    bubbleSorting(scorersNames, 2);
    int tablePosition = 0;
    return Column(
      children: [
        ...(scorersNames).map((scorer) {
          tablePosition = tablePosition + 1;
          if (tablePosition < 11) {
            return Card(
                child: ListTile(
                    title: Text(
                        tablePosition.toString() +
                            " " +
                            scorer[0] +
                            " " +
                            scorer[1],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(scorer[2],
                        style: TextStyle(fontWeight: FontWeight.bold))));
          }
        })
      ],
    );
  }

  Widget createDisciplineTable(playersNames) {
    bubbleSorting(playersNames, 2);
    int tablePosition = 0;
    return Column(
      children: [
        ...(playersNames).map((player) {
          tablePosition = tablePosition + 1;
          if (tablePosition < 11) {
            return Card(
                child: ListTile(
                    title: Text(player[0] + " " + player[1],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(
                        YELLOWRED + " " + player[2] + " (" + player[3] + ")",
                        style: TextStyle(fontWeight: FontWeight.bold))));
          }
        })
      ],
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
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return PRIMARYCOLOR; // Use the component's default.
                                        },
                                      ),
                                    ),
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
                                          future: ConnectDB().retrieveTeamStats(
                                              leagueSelected),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return createStandings(
                                                  snapshot.data);
                                            } else {
                                              return Text("");
                                            }
                                          })
                                      : Text(''),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return PRIMARYCOLOR; // Use the component's default.
                                        },
                                      ),
                                    ),
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
                                          future: ConnectDB()
                                              .retrieveLeagueScorers(
                                                  leagueSelected),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return createScorerTable(
                                                  snapshot.data);
                                            } else {
                                              return Text("");
                                            }
                                          })
                                      : Text(''),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return PRIMARYCOLOR; // Use the component's default.
                                        },
                                      ),
                                    ),
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
                                          future: ConnectDB()
                                              .retrievePlayerDisciplineStats(
                                                  leagueSelected),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              return createDisciplineTable(
                                                  snapshot.data);
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
