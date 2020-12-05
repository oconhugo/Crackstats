import 'package:flutter/material.dart';
import 'LogInBodyWidget.dart';
import '../Constants.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(TITLE),
            backgroundColor: PRIMARYCOLOR,
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LogInBodyWidget(),
                Image.asset('assets/images/mainpagegraphic.png',
                height: 150,
                width: 150,
                ),
              ])),
    );
  }
}
