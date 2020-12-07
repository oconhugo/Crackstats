import 'package:flutter/material.dart';
import '../Constants.dart';
import 'ProfileBodyWidget.dart';

class ProfileUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARYCOLOR,
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
            ProfileBodyWidget(),
          ]))),
    );
  }
}
