import 'package:flutter/material.dart';
import './RegisterBodyWidget.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
          body: Center(child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RegisterBodyWidget(),
              ])))),
    );
  }
}
