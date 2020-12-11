import 'package:crackstats/Leagues/LeaguesUI.dart';
import 'package:crackstats/Profile/ProfileUI.dart';
import '../Teams/TeamsUI.dart';
import '../LogIn/LogInUI.dart';
import '../Constants.dart';
import 'package:flutter/material.dart';
import '../ConnectDB.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
            child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container( 
              height: 100,
              child:DrawerHeader(
              child: Text('Menu',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              decoration: BoxDecoration(
              color: PRIMARYCOLOR,
              ))),
              ListTile(
              title: Text('Profile',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              onTap: () async {
                var conn = new ConnectDB();
                var result = await conn.logInDb(userEmailGlobal, userPasswordGlobal);
                if (result != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileUI(result)));
                }
              },
              ),ListTile(
              title: Text('Leagues',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              onTap: () {
                Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LeaguesUI()));
              },
              ),ListTile(
              title: Text('Teams',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              onTap: () {
                Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TeamsUI()));
              },
              ),
              ListTile(
              title: Text('Log Out',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold, color: Colors.red[900]),textAlign: TextAlign.center,),
              onTap: () {
                userEmailGlobal = '';
                userPasswordGlobal = '';
                Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
              },
              ),
          ],
        ),
      );
  }
}
