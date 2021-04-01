import 'package:flutter/material.dart';
import '../Constants.dart';
import '../LoadingSpinner.dart';
import '../ConnectDB.dart';

class LeaguesSchedule extends StatefulWidget {
  @override
  _LeaguesScheduleState createState() => _LeaguesScheduleState();
}

class _LeaguesScheduleState extends State<LeaguesSchedule> {

  String leagueSelected;
  List allLeagues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
            future: ConnectDB().retrieveAllLeagues(),
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.done) {
                    allLeagues=snapshot.data;
                    print(allLeagues);
                  return DropdownButton<String>(
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
                          leagueSelected = newValue;
                        });
                      },
                      items: allLeagues.map((league) {
                          return DropdownMenuItem<String>(
                            value: league,
                            child: Text(league),
                              );
                            }).toList(),
                      );
              } else {
                return LoadingSpinner();
              }
            })
        
      ],),
    );
  }
}