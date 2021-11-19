//UI to add a game to a league
import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';
import 'dart:convert';
import 'package:collection/collection.dart';

class AddGameUI extends StatefulWidget {
  final String tempLeague;
  final List tempTeamList;
  var id;
  var maxWeek;
  
  AddGameUI(this.tempLeague, this.tempTeamList, this.maxWeek);

  AddGameUI.prefilled(
      this.tempLeague, this.tempTeamList, this.id, this.maxWeek);

  @override
  _AddGameUIState createState() =>
      _AddGameUIState(tempLeague, tempTeamList, id, maxWeek);
}

class _AddGameUIState extends State<AddGameUI> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String league;
  var weekNumber = '1';
  String localTeam;
  String visitorTeam;
  String venue = "";
  bool localContainsValue = false;
  bool visitorContainsValue = false;
  List teamList;
  String playerSelected;
  List localPlayersList = [];
  List localScorersList = [];
  List visitorScorersList = [];
  List visitorPlayersList = [];
  List localYellowsList = [];
  List visitorYellowsList = [];
  List localRedsList = [];
  List visitorRedsList = [];
  List localAppsList = [];
  List visitorAppsList = [];
  List localAppsIDS = [];
  List visitorAppsIDS = [];

  Map localAppearance = {};
  Map visitorAppearance = {};
  Map localPlayerKeys = {};
  Map visitorPlayerKeys = {};

  List prevLocalApps = [];
  List prevVisitorApps = [];

  String date = "";
  String time = "";
  var localScore = 0;
  var visitorScore = 0;
  var localYellowCards = 0;
  var visitorYellowCards = 0;
  var localRedCards = 0;
  var visitorRedCards = 0;
  var id;
  bool isUpdating = false;
  bool isnotComplete = true;
  bool isGamePlayed = false;
  int maxWeek = 0;

  DateTime selectedDate = DateTime.now();
  String gameDate;


  Widget displayDate() {
    return Text("Date: " + "${selectedDate.toLocal()}".split(' ')[0]);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = selectedDate.month.toString().padLeft(2,'0') +
                        "-" +
                        selectedDate.day.toString().padLeft(2,'0')+
                        "-" +
                        selectedDate.year.toString().padLeft(2,'0');
                        
      });
  }

//if ID is null, new game is going to be added
//if ID is not null, game is going to be edited
  _AddGameUIState(this.league, this.teamList, this.id, this.maxWeek) {
    maxWeek+=2;    
    if (id != null) {
      fillInfo();
    } else {
      isnotComplete = false;
    }
  }

  Function eq = const ListEquality().equals;

  //function used to Convert Map to Json 
  Map<String, dynamic> toJson(list) {
    return {
      "Scorers": list,
    };
  }

  //if game already existed, fill game info into the UI
  fillInfo() async {
    var dbGetMatchInfo = await ConnectDB().getMatchInfo(id);
    weekNumber = dbGetMatchInfo[3];
    date = dbGetMatchInfo[4];
    String dateNoFormat = date;
    var dateArr = dateNoFormat.split('-');
    String formattedDate = dateArr[2]+dateArr[0]+dateArr[1];
    selectedDate = DateTime.parse(formattedDate);
    time = dbGetMatchInfo[12];
    venue = dbGetMatchInfo[5];
    localScore = json.decode(dbGetMatchInfo[6]).length;
    List localScorers = json.decode(dbGetMatchInfo[6]);
    visitorScore = json.decode(dbGetMatchInfo[7]).length;
    List visitorScorers = json.decode(dbGetMatchInfo[7]);
    localYellowCards = json.decode(dbGetMatchInfo[8]).length;
    List localYellows = json.decode(dbGetMatchInfo[8]);
    visitorYellowCards = json.decode(dbGetMatchInfo[10]).length;
    List visitorYellows = json.decode(dbGetMatchInfo[10]);
    localRedCards = json.decode(dbGetMatchInfo[9]).length;
    List localReds = json.decode(dbGetMatchInfo[9]);
    visitorRedCards = json.decode(dbGetMatchInfo[11]).length;
    List visitorReds = json.decode(dbGetMatchInfo[11]);
    localTeam = dbGetMatchInfo[1];
    visitorTeam = dbGetMatchInfo[2];
    List localAppList = json.decode(dbGetMatchInfo[14]);
    List visitorAppList = json.decode(dbGetMatchInfo[15]);
    var newMatch = dbGetMatchInfo[16];

    fillNewMatch(newMatch);
    await fillDropDowns(localScorers, visitorScorers, localYellows,
        visitorYellows, localReds, visitorReds);
    fillApps(localAppList, localAppearance);
    fillApps(visitorAppList, visitorAppearance);
    prevLocalApps = localAppList;
    prevVisitorApps = visitorAppList;

    isnotComplete = false;
  }

  //indicate if match is new or we are just editing existing match
  fillNewMatch(val) {
    if (val == '1') {
      isGamePlayed = true;
    } else {
      isGamePlayed = false;
    }
  }

  //create map, mapping all players to true/false according if they participated in the match
  fillApps(appearanceList, app) {
    app.forEach((key, value) {
      appearanceList.forEach((key2) {
        if (key[2] == key2) {
          app[key] = true;
        }
      });
    });

    setState(() {
      isUpdating = true;
      localContainsValue = true;
      visitorContainsValue = true;
    });
  }

  //Fill the dropdown fields on the UI
  fillDropDowns(localScorers, visitorScorers, localYellowCards,
      visitorYellowCards, localRedCards, visitorRedCards) async {
    await getLocalTeamPlayers(localTeam);
    modifyList(localPlayerKeys, localScorers, localScorersList);
    await getVisitorTeamPlayers(visitorTeam);
    modifyList(visitorPlayerKeys, visitorScorers, visitorScorersList);
    //fill cards dropdowns
    modifyList(localPlayerKeys, localYellowCards, localYellowsList);
    modifyList(visitorPlayerKeys, visitorYellowCards, visitorYellowsList);
    modifyList(localPlayerKeys, localRedCards, localRedsList);
    modifyList(visitorPlayerKeys, visitorRedCards, visitorRedsList);
  }

  //get player name from player map into target list according to the id list on values argumemt
  modifyList(keys, values, target) {
    values.forEach((key) {
      target.add(key);
    });
  }

  //get local players that participated in game into a list
  getLocalAppsList() {
    localAppearance.forEach((name, value) {
      if (value == true) {
        List tempList = [name[0], name[1]];
        var usdKey = localPlayerKeys.keys.firstWhere(
            (k) => eq(localPlayerKeys[k], (tempList)),
            orElse: () => null);
        localAppsList.add(usdKey);
      }
    });
  }

  //get visitor players that participated in game into a list
  getVisitorAppsList() {
    visitorAppearance.forEach((name, value) {
      if (value == true) {
        List tempList = [name[0], name[1]];
        var usdKey = visitorPlayerKeys.keys.firstWhere(
            (k) => eq(visitorPlayerKeys[k], (tempList)),
            orElse: () => null);
        visitorAppsList.add(usdKey);
      }
    });
  }

  //get all local team players into map with their id
  getLocalTeamPlayers(team) async {
    localPlayersList = await new ConnectDB().getTeamPlayers(team, league);
    localPlayerKeys = Map.fromIterable(localPlayersList,
        key: (v) => v[2], value: (v) => [v[0], v[1]]);
    localAppearance =
        Map.fromIterable(localPlayersList, key: (v) => v, value: (v) => false);
  }

  //get visitor team players into map with their id
  getVisitorTeamPlayers(team) async {
    visitorPlayersList = await new ConnectDB().getTeamPlayers(team, league);
    visitorPlayerKeys = Map.fromIterable(visitorPlayersList,
        key: (v) => v[2], value: (v) => [v[0], v[1]]);
    visitorAppearance = Map.fromIterable(visitorPlayersList,
        key: (v) => v, value: (v) => false);
  }

  //function to clear list
  Widget showEmptyValue(list, value) {
    print(list);
    setState(() {
      list.clear();
    });

    return Text(value);
  }

  //funtion to generate multiple dropdowns dynamically
  List<Widget> getDropdown(
      number, playerList, List<dynamic> playersList, hint, isLocal) {
    List<Widget> localList = [];
    playerList.length = number;

    for (int i = 0; i < number; i++) {
      localList.add(
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          width: MediaQuery.of(context).size.width / 1.5,
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(hint),
            value: playerList[i],
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
                playerList[i] = newValue;
              });
            },
            items: isLocal
                ? playersList.map((list) {
                    List tempList = [list[0], list[1]];
                    var usdKey = localPlayerKeys.keys.firstWhere(
                        (k) => eq(localPlayerKeys[k], (tempList)),
                        orElse: () => null);
                    String playerName = list[0] + " " + list[1];
                    return DropdownMenuItem<String>(
                      value: usdKey,
                      child: Text(playerName),
                    );
                  }).toList()
                : playersList.map((list) {
                    List tempList = [list[0], list[1]];
                    var usdKey = visitorPlayerKeys.keys.firstWhere(
                        (k) => eq(visitorPlayerKeys[k], (tempList)),
                        orElse: () => null);
                    String playerName = list[0] + " " + list[1];
                    return DropdownMenuItem<String>(
                      value: usdKey,
                      child: Text(playerName),
                    );
                  }).toList(),
          ),
        ),
      );
    }

    return localList;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
          appBar: AppBar(
            backgroundColor: PRIMARYCOLOR,
            title: Text(ADDGAME),
          ),
          body: SingleChildScrollView(
              child: Wrap(
            spacing: MediaQuery.of(context).size.width / 8,
            runSpacing: 10,
            direction: Axis.horizontal,
            children: <Widget>[
              Visibility(
                  maintainSize: isnotComplete,
                  maintainAnimation: isnotComplete,
                  maintainState: isnotComplete,
                  visible: isnotComplete,
                  child: Container(
                      margin: EdgeInsets.only(top: 50, bottom: 30),
                      child: LinearProgressIndicator())),
              //Week Number
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (1),
                child: TextField(
                  controller: TextEditingController()..text = weekNumber,
                  decoration: InputDecoration(
                    hintText: WEEKNUMBER,
                  ),
                  onChanged: (value) {
                    weekNumber = value;
                  },
                ),
              ),
              //Date
              Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0)),
              child: ListTile(
                  title: displayDate(),
                  onTap: () {
                    selectDate(context);
                    
                  })),
              /*Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (1),
                child: TextField(
                  controller: TextEditingController()..text = date,
                  decoration: InputDecoration(
                    hintText: DATEWITHFORMAT,
                  ),
                  //keyboardType: TextInputType.number,
                  onChanged: (value) {
                    date = value;
                  },
                ),
              ),*/
              //Time
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (1),
                child: TextField(
                  controller: TextEditingController()..text = time,
                  decoration: InputDecoration(
                    hintText: TIMEWITHFORMAT,
                  ),
                  onChanged: (value) {
                    time = value;
                  },
                ),
              ),
              //Venue
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (1),
                child: TextField(
                  controller: TextEditingController()..text = venue,
                  decoration: InputDecoration(
                    hintText: VENUE,
                  ),
                  onChanged: (value) {
                    venue = value;
                  },
                ),
              ),

              //Local Team Dropdown
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(LOCALTEAM),
                  value: localTeam,
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
                      localContainsValue = true;
                      localTeam = newValue;
                      getLocalTeamPlayers(localTeam);
                    });
                  },
                  items: teamList.map((list) {
                    return DropdownMenuItem<String>(
                      value: list[0],
                      child: Text(list[0]),
                    );
                  }).toList(),
                ),
              ),
              //Visitor Team Dropdown
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(VISITORTEAM),
                  value: visitorTeam,
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
                      visitorContainsValue = true;
                      visitorTeam = newValue;
                      getVisitorTeamPlayers(visitorTeam);
                    });
                  },
                  items: teamList.map((list) {
                    return DropdownMenuItem<String>(
                      value: list[0],
                      child: Text(list[0]),
                    );
                  }).toList(),
                ),
              ),
              //Local Score
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: TextField(
                  controller: TextEditingController()
                    ..text = localScore.toString(),
                  decoration: InputDecoration(
                    hintText: SCORETEXT,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    localScore = int.parse(value);
                  },
                ),
              ),
              //Visitor Score
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: TextField(
                  controller: TextEditingController()
                    ..text = visitorScore.toString(),
                  decoration: InputDecoration(
                    hintText: SCORETEXT,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    visitorScore = int.parse(value);
                  },
                ),
              ),
              //Local scorer dropdown
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: Column(
                    children: localScore > 0
                        ? getDropdown(localScore, localScorersList,
                            localPlayersList, LOCALTEAMSCORERTXT, true)
                        : [showEmptyValue(localScorersList, NOLOCALGOALS)]),
              ),
              //Visitor scorer Dropdown
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: Column(
                    children: visitorScore > 0
                        ? getDropdown(visitorScore, visitorScorersList,
                            visitorPlayersList, VISITORTEAMSCORERTXT, false)
                        : [showEmptyValue(visitorScorersList, NOVISITORGOALS)]),
              ),
              //Local yellow cards
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: TextField(
                  controller: TextEditingController()
                    ..text = localYellowCards.toString(),
                  decoration: InputDecoration(
                    hintText: YELLOWCARDSNUM,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    localYellowCards = int.parse(value);
                  },
                ),
              ),
              //Visitor yellow cards
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: TextField(
                  controller: TextEditingController()
                    ..text = visitorYellowCards.toString(),
                  decoration: InputDecoration(
                    hintText: YELLOWCARDSNUM,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    visitorYellowCards = int.parse(value);
                  },
                ),
              ),
              //Local yellow cards dropdown
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: Column(
                    children: localYellowCards > 0
                        ? getDropdown(localYellowCards, localYellowsList,
                            localPlayersList, LOCALYELLOWSTXT, true)
                        : [showEmptyValue(localYellowsList, NOLOCALYELLOWS)]),
              ),
              //visitor yellow cards dropdown
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: Column(
                    children: visitorYellowCards > 0
                        ? getDropdown(visitorYellowCards, visitorYellowsList,
                            visitorPlayersList, VISITORYELLOWSTXT, false)
                        : [showEmptyValue(visitorYellowsList, NOVISITORYELLOWS)]),
              ),
              //Local red cards
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: TextField(
                  controller: TextEditingController()
                    ..text = localRedCards.toString(),
                  decoration: InputDecoration(
                    hintText: REDCARDSNUM,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    localRedCards = int.parse(value);
                  },
                ),
              ),
              //Visitor red cards
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: TextField(
                  controller: TextEditingController()
                    ..text = visitorRedCards.toString(),
                  decoration: InputDecoration(
                    hintText: REDCARDSNUM,
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    visitorRedCards = int.parse(value);
                  },
                ),
              ),
              //Local red cards dropdown
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: Column(
                    children: localRedCards > 0
                        ? getDropdown(localRedCards, localRedsList,
                            localPlayersList, LOCALREDTXT, true)
                        : [showEmptyValue(localRedsList, NOLOCALREDCARDS)]),
              ),
              //visitor red cards dropdown
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 25),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: Column(
                    children: visitorRedCards > 0
                        ? getDropdown(visitorRedCards, visitorRedsList,
                            visitorPlayersList, VISITORREDTXT, false)
                        : [showEmptyValue(visitorRedsList, NOVISITORREDCARDS)]),
              ),
              //Text local players appearance
              Center(child: Text(PARTICIPATEDPLAYERS)),
              //Local checkbox
              Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  width: MediaQuery.of(context).size.width * (3.5 / 8),
                  child: Column(
                    children: [
                      ...(localAppearance.keys).map((valkey) {
                        String tempName = valkey[0] + " " + valkey[1];
                        return CheckboxListTile(
                          title: Text(tempName),
                          value: localAppearance[valkey],
                          onChanged: (bool value) {
                            setState(() {
                              localAppearance[valkey] = value;
                            });
                          },
                        );
                      }).toList(),
                    ],
                  )),
              //Visitor checkbox
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                width: MediaQuery.of(context).size.width * (3.5 / 8),
                child: Column(
                  children: [
                    ...(visitorAppearance.keys).map((valkey) {
                      String tempName = valkey[0] + " " + valkey[1];
                      return CheckboxListTile(
                        title: Text(tempName),
                        value: visitorAppearance[valkey],
                        onChanged: (bool value) {
                          setState(() {
                            visitorAppearance[valkey] = value;
                          });
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
              //checkbox
              Container(
                  child: CheckboxListTile(
                title: Text(NEWMATCH),
                value: isGamePlayed,
                onChanged: (bool val) {
                  setState(() {
                    isGamePlayed = val;
                  });
                },
              )),
              Center(
                child: ElevatedButton(
                    child: Text(SUBMIT),
                    onPressed: () async {
                      var gamePlayed;
                      //maxWeek = maxWeek + 1;
                      if (isGamePlayed) {
                        gamePlayed = '1';
                      } else {
                        gamePlayed = '0';
                      }
                      if (int.parse(weekNumber) > maxWeek ||
                          int.parse(weekNumber) == 0) {
                        final snackBar = SnackBar(
                            content: Text(SELECTVALIDWEEK + maxWeek.toString()));
                        scaffoldMessengerKey.currentState.showSnackBar(snackBar);
                      } else {
                        if (localContainsValue && visitorContainsValue) {
                          getLocalAppsList();
                          getVisitorAppsList();
                          var tempConnectDB = new ConnectDB();
                          if (isUpdating == false) {
                            await tempConnectDB.sendMatch(
                              localTeam,
                              visitorTeam,
                              weekNumber,
                              date,
                              venue,
                              jsonEncode(localScorersList),
                              jsonEncode(visitorScorersList),
                              jsonEncode(localYellowsList),
                              jsonEncode(visitorYellowsList),
                              jsonEncode(localRedsList),
                              jsonEncode(visitorRedsList),
                              time,
                              league,
                              jsonEncode(localAppsList),
                              jsonEncode(visitorAppsList),
                              gamePlayed,
                            );
                          } else {
                            await tempConnectDB.updateMatch(
                              localTeam,
                              visitorTeam,
                              weekNumber,
                              date,
                              venue,
                              jsonEncode(localScorersList),
                              jsonEncode(visitorScorersList),
                              jsonEncode(localYellowsList),
                              jsonEncode(visitorYellowsList),
                              jsonEncode(localRedsList),
                              jsonEncode(visitorRedsList),
                              time,
                              league,
                              jsonEncode(localAppsList),
                              jsonEncode(visitorAppsList),
                              id,
                              gamePlayed,
                            );
                          }
                          Navigator.of(context).pop();
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(MATCHADDED),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(OK),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          final snackBar = SnackBar(content: Text(SELECTTEAMS));
                          scaffoldMessengerKey.currentState.showSnackBar(snackBar);
                        }
                      }
                    }),
              )
            ],
          ))),
    );
  }
}
