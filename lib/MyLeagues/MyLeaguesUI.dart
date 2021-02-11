import 'package:flutter/material.dart';
import '../SideMenu/SideBarMenu.dart';
import '../Constants.dart';
import 'MyLeaguesSchedule.dart';
import 'MyLeaguesAnnouncements.dart';

class MyLeaguesUI extends StatelessWidget {

  final List tempAdminLeagueList;

  MyLeaguesUI(this.tempAdminLeagueList);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: SideBarMenu(),
          appBar: AppBar(
            backgroundColor: PRIMARYCOLOR,
            title: Text(MYLEAGUESTITLE),
            bottom: TabBar(tabs: [
              Tab(text: SCHEDULE),
              Tab(text: ANNOUNCEMENTS,),              
            ],
            indicatorColor: Colors.orange),),
            body:TabBarView(children: [
            MyLeaguesSchedule(),
            MyLeaguesAnnouncements(tempAdminLeagueList),
          ],
          ),
      ),
    ));
  }
}
