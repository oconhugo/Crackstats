import 'package:flutter/material.dart';
import '../Constants.dart';
import '../LoadingSpinner.dart';
import '../ConnectDB.dart';
import 'dart:convert';

class LeaguesSchedule extends StatefulWidget {
  @override
  _LeaguesScheduleState createState() => _LeaguesScheduleState();
}

class _LeaguesScheduleState extends State<LeaguesSchedule> {
  String leagueSelected;
  List allLeagues;
  bool isLeagueSelected = false;
  Map weeksSelected;
  bool isButtonMapCreated = false;

  setWeeksSelectedVal(weeks) {
    weeksSelected =
        Map.fromIterable(weeks, key: (v) => v[0], value: (v) => false);
    print(weeksSelected);
  }

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
                      ? Container(
                          child: Column(
                            children: [
                              FutureBuilder(
                                  future: ConnectDB()
                                      .getLeagueWeeks(leagueSelected),
                                  builder: (context, snapshot) {
                                    List weeks = snapshot.data;
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if(!isButtonMapCreated){
                                        setWeeksSelectedVal(weeks);
                                        isButtonMapCreated=true;
                                        }
                                      return Column(
                                        children: [
                                          ...(weeks).map((value) {
                                            return Column(children: [
                                              RaisedButton(
                                                child:
                                                    Text(WEEK + " " + value[0]),
                                                onPressed: () {
                                                  setState(() {
                                                    weeksSelected[value[0]] = !weeksSelected[value[0]];
                                                  });
                                                }
                                                ),
                                                weeksSelected[value[0]]==true? 
                                                FutureBuilder(
                                                  future: ConnectDB().getWeekGames(value[0],leagueSelected),
                                                  builder: (context, snapshot){
                                                    List weekDataList = snapshot.data;
                                                    if (snapshot.connectionState == ConnectionState.done)
                                                    {
                                                    return Column(children: [
                                                      ...(weekDataList).map((value) {
                                                        String localTeam = value[1];
                                                        String visitorTeam = value[2];
                                                        print(json.decode(value[6]));
                                                        String localScore = json.decode(value[6]).length.toString();
                                                        String visitorScore = json.decode(value[7]).length.toString();
                                                        String date = value[4];
                                                        String time = value[12];
                                                        String venue = value[5];
                                                        return Card(child: ListTile(
                                                          title: Center(child: Text(localTeam + " " + localScore +  " " + VS + " " + visitorScore + " " + visitorTeam)),
                                                          subtitle: Center(child: Text(date + " " + time + " " + venue)),
                                                        ),);
                                                      })
                                                    ],);
                                                    }
                                                    else
                                                    {
                                                      return Text("");
                                                    }                                                  
                                                  })
                                                : Text(""),
                                            ],);
                                          }),                                          
                                        ],
                                      );
                                    } else {
                                      return LoadingSpinner();
                                    }
                                  })
                            ],
                          ),
                        )
                      : Text(""),
                ])))));
  }
}
