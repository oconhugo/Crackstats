import 'package:flutter/material.dart';
import '../Constants.dart';
import 'AddAnnouncementPopUp.dart';

class MyLeaguesAnnouncements extends StatefulWidget {
  final List tempList;

  MyLeaguesAnnouncements(this.tempList);

  @override
  _MyLeaguesAnnouncementsState createState() =>
      _MyLeaguesAnnouncementsState(tempList);
}

class _MyLeaguesAnnouncementsState extends State<MyLeaguesAnnouncements> {
  String leagueSelected;
  List userAdminLeagues;
  bool isEnable = false;

  _MyLeaguesAnnouncementsState(this.userAdminLeagues);

  getLeagueAnnouncements() {}

  showSnackLeague() {
    Scaffold.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(SELECTLEAGUE),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            width: MediaQuery.of(context).size.width / 1.5,
            child: DropdownButton<String>(
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
                  isEnable = true;
                  leagueSelected = newValue;
                  getLeagueAnnouncements();
                });
              },
              items: userAdminLeagues.map((list) {
                return DropdownMenuItem<String>(
                  value: list,
                  child: Text(list),
                );
              }).toList(),
            ),
          ),
        ),
        RaisedButton(
            child: Text(
              ADDANNOUNCEMENT,
            ),
            textColor: WHITE,
            color: PRIMARYCOLOR,
            disabledColor: Colors.grey,
            onPressed: () async {
              isEnable
                  ? new AddAnnouncementPopUp()
                      .newAnnouncement(context, leagueSelected)
                  : showSnackLeague();
            })
      ],
    );
  }
}
