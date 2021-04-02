import 'package:flutter/material.dart';
import '../ConnectDB.dart';
import '../LoadingSpinner.dart';

class LeagueSheduleWeeks extends StatefulWidget {
  String league;
  LeagueSheduleWeeks(temp) {
    this.league = temp;
    print(this.league);
  }

  @override
  _LeagueSheduleWeeksState createState() => _LeagueSheduleWeeksState(league);
}

class _LeagueSheduleWeeksState extends State<LeagueSheduleWeeks> {
  String league;
  _LeagueSheduleWeeksState(this.league);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        FutureBuilder(
            future: ConnectDB().getLeagueWeeks(league),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                return Text("snapshot.data[0]");
              } else {
                return LoadingSpinner();
              }
            })
      ],
    ));
  }
}
