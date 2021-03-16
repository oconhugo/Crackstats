import 'package:crackstats/ConnectDB.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

class AddPlayerUI extends StatefulWidget {
  final String tempLeague;
  final String tempTeam;

  AddPlayerUI(this.tempLeague, this.tempTeam);

  @override
  _AddTeamUIState createState() => _AddTeamUIState(tempLeague, tempTeam);
}

class _AddTeamUIState extends State<AddPlayerUI> {
  String teamSelected;
  String message;
  String addText;
  String league;
  String team;

  Future<void> requestSentDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(REQUESTSENT),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(CONFIRMPLAYERREQUESTMSG),
              ],
            ),
          ),
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
  }

  _AddTeamUIState(this.league, this.team);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ADDPLAYERTITLE),
        backgroundColor: PRIMARYCOLOR,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Text(
                ADDPLAYERTITLE,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            ),
            Container(
              child: Text(
                ADDPLAYERTEXT + team + ADDPLAYERTEXT2 + league,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
            RaisedButton(
              color: PRIMARYCOLOR,
              textColor: WHITE,
              child: Text(SENDREQUEST),
              onPressed: () async {
                var conn = ConnectDB();
                var response =
                    await conn.sendAddPlayerRequest(team, league, message);
                if (response != null || response.isEmpty()) {
                  requestSentDialog();
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
