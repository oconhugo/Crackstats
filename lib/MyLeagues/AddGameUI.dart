import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';

class AddGameUI extends StatefulWidget {
  String tempLeague;
  List tempTeamList;

  AddGameUI(this.tempLeague, this.tempTeamList);

  @override
  _AddGameUIState createState() => _AddGameUIState(tempLeague, tempTeamList);
}

class _AddGameUIState extends State<AddGameUI> {
  String league;
  String localTeam;
  String visitorTeam;
  String venue;
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
  Map localAppearance = {};
  Map visitorAppearance = {};
  String date;
  String time;
  var localScore = 0;
  var visitorScore = 0;
  var localYellowCards = 0;
  var visitorYellowCards = 0;
  var localRedCards = 0;
  var visitorRedCards = 0;
  bool testVal=false;

  _AddGameUIState(this.league, this.teamList);

  getLocalTeamPlayers(team) async {
    localPlayersList = await new ConnectDB().getTeamPlayers(team, league);
    setState(() {});
    localAppearance = Map.fromIterable(localPlayersList, key: (v) => v, value: (v) => false);
  }

  getVisitorTeamPlayers(team) async {
    visitorPlayersList = await new ConnectDB().getTeamPlayers(team, league);
    setState(() {});
    visitorAppearance = Map.fromIterable(visitorPlayersList, key: (v) => v, value: (v) => false);
  }

  Widget showEmptyValue(list, value) {
    list = [];
    return Text(value);
  }

  List<Widget> getDropdown(
      number, playerList, List<dynamic> playersList, hint) {
    List<Widget> localList = List<Widget>();
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
            items: playersList.map((list) {
              String playerName = list[0] + " " + list[1];
              return DropdownMenuItem<String>(
                value: playerName,
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
    return Scaffold(
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
            //Date
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              width: MediaQuery.of(context).size.width * (1),
              child: TextField(
                decoration: InputDecoration(
                  hintText: DATEWITHFORMAT,
                ),
                onChanged: (value) {
                  date = value;
                },
              ),
            ),
            //Time
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              width: MediaQuery.of(context).size.width * (1),
              child: TextField(
                decoration: InputDecoration(
                  hintText: TIMEWITHFORMAT,
                ),
                onChanged: (value) {
                  time = value;
                },
              ),
            ),
            //Time
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              width: MediaQuery.of(context).size.width * (1),
              child: TextField(
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
                decoration: InputDecoration(
                  hintText: SCORETEXT,
                ),
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
                decoration: InputDecoration(
                  hintText: SCORETEXT,
                ),
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
                          localPlayersList, LOCALTEAMSCORERTXT)
                      : [showEmptyValue(localScorersList, NOLOCALGOALS)]),
            ),
            //Visitor scorer Dropdown
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              width: MediaQuery.of(context).size.width * (3.5 / 8),
              child: Column(
                  children: visitorScore > 0
                      ? getDropdown(visitorScore, visitorScorersList,
                          visitorPlayersList, VISITORTEAMSCORERTXT)
                      : [showEmptyValue(visitorScorersList, NOVISITORGOALS)]),
            ),
            //Local yellow cards
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              width: MediaQuery.of(context).size.width * (3.5 / 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: YELLOWCARDSNUM,
                ),
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
                decoration: InputDecoration(
                  hintText: YELLOWCARDSNUM,
                ),
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
                          localPlayersList, LOCALYELLOWSTXT)
                      : [showEmptyValue(localYellowsList, NOLOCALYELLOWS)]),
            ),
            //visitor yellow cards dropdown
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              width: MediaQuery.of(context).size.width * (3.5 / 8),
              child: Column(
                  children: visitorYellowCards > 0
                      ? getDropdown(visitorYellowCards, visitorYellowsList,
                          visitorPlayersList, VISITORYELLOWSTXT)
                      : [showEmptyValue(visitorYellowCards, NOVISITORYELLOWS)]),
            ),
            //Local red cards
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              width: MediaQuery.of(context).size.width * (3.5 / 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: REDCARDSNUM,
                ),
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
                decoration: InputDecoration(
                  hintText: REDCARDSNUM,
                ),
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
                          localPlayersList, LOCALREDTXT)
                      : [showEmptyValue(localRedsList, NOLOCALREDCARDS)]),
            ),
            //visitor red cards dropdown
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 5, 25),
              width: MediaQuery.of(context).size.width * (3.5 / 8),
              child: Column(
                  children: visitorRedCards > 0
                      ? getDropdown(visitorRedCards, visitorRedsList,
                          visitorPlayersList, VISITORREDTXT)
                      : [showEmptyValue(visitorRedCards, NOVISITORREDCARDS)]),
            ),
            //Text local players appearance
            Center(
              //width: MediaQuery.of(context).size.width /2,
              //padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child:Text(PARTICIPATEDPLAYERS)),
            //Local checkbox
            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              width: MediaQuery.of(context).size.width * (3.5 / 8),
              child: Column(children: [
                ...(localAppearance.keys).map((valkey) {
                    String tempName = valkey[0] + " " + valkey[1];
                    return CheckboxListTile(
                    title: Text(tempName),
                    value: localAppearance[valkey],
                    onChanged: (bool value) {
                      setState(() {
                        localAppearance[valkey] = value;
                        print(localAppearance);
                      });
                    },
                  );
                  }).toList(),
              ],)
            ),
            //Visitor checkbox
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              width: MediaQuery.of(context).size.width * (3.5 / 8),
              child: Column(children: [
                ...(visitorAppearance.keys).map((valkey) {
                    String tempName = valkey[0] + " " + valkey[1];
                    return CheckboxListTile(
                    title: Text(tempName),
                    value: visitorAppearance[valkey],
                    onChanged: (bool value) {
                      setState(() {
                        visitorAppearance[valkey] = value;
                        print(visitorAppearance);
                      });
                    },
                  );
                  }).toList(),
              ],),
            ),
            Center(
              child: RaisedButton(
                child: Text(SUBMIT),
                onPressed: 
                  () async {
                    var tempConnectDB = new ConnectDB();
                    var senfInfoResult = await tempConnectDB.sendMatch(localTeam,visitorTeam,date,venue,localScore,visitorScore,localYellowsList,visitorYellowsList,localRedCards,visitorRedsList,time,league,localAppearance,visitorAppearance);
                    //print(sendInfoResult);
                  }
                ),
            )
          ],
        )));
  }
}
