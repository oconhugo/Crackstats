//Leagues UI
import 'package:flutter/material.dart';
import '../SideMenu/SideBarMenu.dart';
import '../Constants.dart';
import 'LeaguesSchedule.dart';
import 'LeaguesStats.dart';
import 'LeaguesAnnouncements.dart';

class LeaguesUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: SideBarMenu(),
          appBar: AppBar(
            backgroundColor: PRIMARYCOLOR,
            title: Text(LEAGUESTITLE),
            bottom: TabBar(tabs: [
              Tab(text: SCHEDULE),
              Tab(text: STATS,),
              Tab(text: ANNOUNCEMENTS,),              
            ],
            indicatorColor: Colors.orange),),
            body:TabBarView(children: [
            LeaguesSchedule(),
            LeaguesStats(),
            LeaguesAnnouncements(),
          ],
          ),
      ),
    ));
  }
}
