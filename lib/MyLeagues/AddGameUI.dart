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
  List teamList;
  String playerSelected;
  List localPlayersList = [];
  List localScorersList =[];
  List visitorScorersList =[];
  List visitorPlayersList = [];
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  var localScore = 0;
  var visitorScore=0;

  _AddGameUIState(this.league, this.teamList);

  getLocalTeamPlayers(team) async {
    localPlayersList = await new ConnectDB().getTeamPlayers(team, league);
    setState(() {
      print(localPlayersList);
    });
  }

  getVisitorTeamPlayers(team) async {
    visitorPlayersList = await new ConnectDB().getTeamPlayers(team, league);
    setState(() {
      print(localPlayersList);
    });
  }

  Widget noLocalGoals(){
    localScorersList=[];
    return Text(NOLOCALGOALS);
  }

  Widget noVisitorGoals(){
    visitorScorersList=[];
    print(visitorScorersList);
    return Text(NOVISITORGOALS);
  }

  List<Widget> getLocalDropdownScorers(numberOfGoals){
    List<Widget> localScorers = List<Widget>();
    localScorersList.length=numberOfGoals;

    for(int i=0;i<numberOfGoals;i++)
    {
      localScorers.add(
        Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: MediaQuery.of(context).size.width / 1.5,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(LOCALTEAM + " " + SCORERTEXT),
                  value: localScorersList[i],
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
                      localScorersList[i] = newValue;
                    });
                  },
                  items: localPlayersList.map((list) {
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
    print(localScorersList);
    return localScorers;
  }

  List<Widget> getVisitorDropdownScorers(numberOfGoals){
    List<Widget> visitorScorers = List<Widget>();
    visitorScorersList.length=numberOfGoals;

    for(int i=0;i<numberOfGoals;i++)
    {
      visitorScorers.add(
        Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: MediaQuery.of(context).size.width / 1.5,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(LOCALTEAM + " " + SCORERTEXT),
                  value: visitorScorersList[i],
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
                      visitorScorersList[i] = newValue;
                    });
                  },
                  items: visitorPlayersList.map((list) {
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
    print(visitorScorersList);
    return visitorScorers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARYCOLOR,
          title: Text(ADDGAME),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          //childAspectRatio: (itemWidth / itemHeight),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            //Date
            Container(
              child: TextField(
                controller: dateController,
                decoration: InputDecoration(
                  hintText: DATEWITHFORMAT,
                ),
              ),
            ),
            //Time
            Container(
              child: TextField(
                controller: timeController,
                decoration: InputDecoration(
                  hintText: TIMEWITHFORMAT,
                ),
              ),
            ),
            //Local Team Dropdown
            Container(
              height: 40,
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: SCORETEXT,
                ),
                onChanged: (value) {
                  localScore=int.parse(value);
                },
              ),
            ),
            //Visitor Score
            Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: SCORETEXT,
                ),
                onChanged: (value) {
                  visitorScore=int.parse(value);
                },
              ),
            ),
            //Local scorer dropdown
            Column(children: 
              localScore>0?getLocalDropdownScorers(localScore):[noLocalGoals()]
            ),
            //Visitor scorer Dropdown
            Column(
              children: 
              visitorScore>0?getVisitorDropdownScorers(visitorScore):[noVisitorGoals()]
            ),
          ],
        ));
  }
}
