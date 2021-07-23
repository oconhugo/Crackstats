//show league announcements
import 'package:flutter/material.dart';
import '../ConnectDB.dart';
import '../Constants.dart';

class LeaguesAnnouncements extends StatefulWidget {
  @override
  _LeaguesAnnouncementsState createState() => _LeaguesAnnouncementsState();
}

class _LeaguesAnnouncementsState extends State<LeaguesAnnouncements> {
  List<dynamic> leagueNotifications = [];
  String leagueSelected;
  List leagues;

//get announcements from db
  getLeagueAnnouncement() async {
    var connector = new ConnectDB();
    List<dynamic> x = await connector.getLeagueNotifications(leagueSelected);
    setState(() {
      leagueNotifications = x;
    });
  }

//UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                  getLeagueAnnouncement();
                });
              },
              items: globalUserLeagueList.map((list) {
                return DropdownMenuItem<String>(
                  value: list,
                  child: Text(list),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...(leagueNotifications).map((valkey) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: PRIMARYCOLOR)),
                        child: Column(children: [
                        Text(valkey[2], style: TextStyle(fontSize: 24)),
                        Text(DATE + valkey[3], style: TextStyle(fontSize: 18))
                        ]
                        ),
                  );
                })
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
