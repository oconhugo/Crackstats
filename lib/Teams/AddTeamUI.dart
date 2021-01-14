import 'package:crackstats/ConnectDB.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

class AddTeamUI extends StatefulWidget {
  @override
  _AddTeamUIState createState() => _AddTeamUIState();
}

class _AddTeamUIState extends State<AddTeamUI> {
  String leagueSelected;
  String teamName;
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TEAMSTITLE),
        backgroundColor: PRIMARYCOLOR,
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            child: Text(
              CREATETEAM,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              textAlign: TextAlign.center,
            ),
            width: MediaQuery.of(context).size.width / 1.5,
            padding: EdgeInsets.fromLTRB(0, 10, 7, 0),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: TextField(
              onChanged: (String value) {
                teamName = value;
              },
              decoration: InputDecoration(
                hintText: TEAMNAME,
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 5, 7, 0),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 7, 0),
            width: MediaQuery.of(context).size.width / 1.5,
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(LEAGUES),
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
                });
              },
              items: globalLeagueList.map((list) {
                return DropdownMenuItem<String>(
                  value: list,
                  child: Text(list),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 14, 0),
            width: MediaQuery.of(context).size.width / 1.5,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (String value) {
                message = value;
              },
              decoration: InputDecoration(
                hintText: MESSAGETOADMIN,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: RED, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: PRIMARYCOLOR, width: 1.0),
                ),
              ),
            ),
          ),
          //Insertar mensaje para el admin aqui
          RaisedButton(
            color: PRIMARYCOLOR,
            textColor: WHITE,
            child: Text(SENDREQUEST),
            onPressed: () async {
              var conn = ConnectDB();
              var response = await conn.sendAddTeamRequest(
                  teamName, leagueSelected, message);
              print(response);
            },
          ),
        ],
      )),
    );
  }
}
