import 'package:crackstats/ForgotPassword/ForgotPasswordUI.dart';

import '../Constants.dart';
import 'package:flutter/material.dart';
import '../Register/RegisterUI.dart';

class LogInButtonsWidget extends StatelessWidget {
  final TextEditingController emlController;
  final TextEditingController pwdController;

  LogInButtonsWidget(this.emlController, this.pwdController);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text(FORGOTPASSWORD),
            textColor: BLUE,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordUI(),
                  ));
            },
          ),
          RaisedButton(
            color: PRIMARYCOLOR,
            textColor: WHITE,
            child: Text(SIGNIN),
            onPressed: () {
              if (emlController.text.isEmpty || pwdController.text.isEmpty) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(INCOMPLETEFIELDSMSG),
                ));
              } else {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => null));
              }
            },
          ),
          RaisedButton(
            color: PRIMARYCOLOR,
            textColor: WHITE,
            child: Text(REGISTER),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
