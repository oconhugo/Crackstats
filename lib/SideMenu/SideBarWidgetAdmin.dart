import 'package:crackstats/Leagues/LeaguesUI.dart';
import 'package:crackstats/Profile/ProfileUI.dart';
import '../Teams/TeamsUI.dart';
import '../LogIn/LogInUI.dart';
import '../Constants.dart';
import 'package:flutter/material.dart';
import '../ConnectDB.dart';
import '../MyLeagues/MyLeaguesUI.dart';

class SideBarWidgetAdmin extends StatelessWidget {

  List userAdminLeagues;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
                height: 100,
                child: DrawerHeader(
                    child: Text(
                      MENUTITLE,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:WHITE),
                      textAlign: TextAlign.center,
                    ),
                    decoration: BoxDecoration(
                      color: PRIMARYCOLOR,
                    ))),
            ListTile(
              title: Text(
                PROFILETITLE,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.account_circle,
                size: 40,
              ),
              onTap: () async {
                var conn = new ConnectDB();
                var result =
                    await conn.logInDb(userEmailGlobal, userPasswordGlobal);
                if (result != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileUI(result)));
                }
              },
            ),
            ListTile(
              title: Text(
                LEAGUESTITLE,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.sports,
                size: 40,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LeaguesUI()));
              },
            ),
            ListTile(
              title: Text(
                TEAMSTITLE,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.people,
                size: 40,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TeamsUI()));
              },
            ),
            ListTile(
              title: Text(
                MYLEAGUES,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.sports_soccer,
                size: 40,
              ),
              onTap: () async {
                var callDB = new ConnectDB();
                userAdminLeagues = await callDB.getUserAdminLeaguesList(userEmailGlobal);
                print(userAdminLeagues);
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyLeaguesUI(userAdminLeagues)));
              },
            ),
            ListTile(
              title: Text(
                LOGOUTTITLE,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900]),
                textAlign: TextAlign.left,
              ),
              trailing: Icon(
                Icons.logout,
                size: 40,
              ),
              onTap: () {
                userEmailGlobal = '';
                userPasswordGlobal = '';
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ],
        ),
      );
  }
}