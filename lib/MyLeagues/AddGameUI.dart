import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';

class AddGameUI extends StatefulWidget {

  String tempLeague;
  List tempTeamList;

  AddGameUI(this.tempLeague,this.tempTeamList);

  @override
  _AddGameUIState createState() => _AddGameUIState(tempLeague,tempTeamList);
}

class _AddGameUIState extends State<AddGameUI> {

  String league;
  String localTeam;
  List teamList;
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();

  _AddGameUIState(this.league,this.teamList);

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
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          //Date
          Container(
            child:  TextField(
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
          //Visitor Team
          Container(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(VISITORTEAM),
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
          ],
          )
        );
  }
}