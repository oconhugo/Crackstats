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
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController localScoreController = new TextEditingController();
  TextEditingController visitorScoreController = new TextEditingController();

  _AddGameUIState(this.league, this.teamList);

  getLocalTeamPlayers(value) async {
    localPlayersList = await new ConnectDB().getTeamPlayers(value, league);
    setState(() {
      print(localPlayersList);
    });
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
                controller: localScoreController,
                decoration: InputDecoration(
                  hintText: SCORETEXT,
                ),
              ),
            ),
            //Visitor Score
            Container(
              child: TextField(
                controller: visitorScoreController,
                decoration: InputDecoration(
                  hintText: SCORETEXT,
                ),
              ),
            ),
            //Local scorer dropdown
            Column(children: [
              //TODO
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: MediaQuery.of(context).size.width / 1.5,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(LOCALTEAM + " " + SCORERTEXT),
                  value: playerSelected,
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
                      playerSelected = newValue;
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
            ]),
            //Visitor Dropdown
            Column(),
          ],
        ));
  }
}
