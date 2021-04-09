import 'package:flutter/material.dart';
import 'LeagueStatsButtons.dart';
import '../ConnectDB.dart';
import '../Constants.dart';

class LeaguesStats extends StatefulWidget {
  @override
  _LeaguesStatsState createState() => _LeaguesStatsState();
}

class _LeaguesStatsState extends State<LeaguesStats> {

  List allLeagues;
  String leagueSelected;
  bool isLeagueSelected=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(child: Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(children: [
                  FutureBuilder(
                      future: ConnectDB().retrieveAllLeagues(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          allLeagues = snapshot.data;
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
                                isLeagueSelected = true;
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
                          return Text("");
                        }
                      }),
                  isLeagueSelected
                      ? Center(child: Column(children: 
                        [
                          RaisedButton(
                              color: PRIMARYCOLOR,
                              textColor: WHITE,
                              child: Text(STANDING),
                              onPressed: () {
                                FutureBuilder(
                                  future: ConnectDB().retrieveAllLeagueGames(leagueSelected),
                                  builder: (context,snapshot){
                                    print("1");
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      List allgamesInfo = snapshot.data;
                                      print(allgamesInfo);
                                      return Text("");
                                    }
                                    else
                                    {
                                      return Text("");
                                    }
                                  });
                              },
                          ),
                          RaisedButton(
                              color: PRIMARYCOLOR,
                              textColor: WHITE,
                              child: Text(GOALSCORERS),
                              onPressed: () {
                                 FutureBuilder(
                                  future: null,
                                  builder: (context,snapshot){
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return Text("");
                                    }
                                    else
                                    {
                                      return Text("");
                                    }
                                  });
                              },),
                              RaisedButton(
                              color: PRIMARYCOLOR,
                              textColor: WHITE,
                              child: Text(DISCIPLINE),
                              onPressed: () {
                                 FutureBuilder(
                                  future: null,
                                  builder: (context,snapshot){
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return Text("");
                                    }
                                    else
                                    {
                                      return Text("");
                                    }
                                  });
                              },),
                        ]
                      ,),)
                      : Text(""),
                ])))));
  }
}
