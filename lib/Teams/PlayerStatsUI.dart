import 'package:flutter/material.dart';

import '../Constants.dart';

class PlayerStatsUI extends StatelessWidget {
  final String name;

  PlayerStatsUI(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: PRIMARYCOLOR,
      ),
    );
  }
}
