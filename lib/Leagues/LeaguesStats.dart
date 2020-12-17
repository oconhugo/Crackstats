import 'package:flutter/material.dart';
import '../Constants.dart';
import 'LeagueStatsButtons.dart';

class LeaguesStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LeagueStatsButtons(),
    );
  }
}