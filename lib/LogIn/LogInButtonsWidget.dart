import 'package:crackstats/ForgotPassword/ForgotPasswordUI.dart';
import '../ConnectDB.dart';
import '../Constants.dart';
import 'package:flutter/material.dart';
import '../Register/RegisterUI.dart';
import '../Profile/ProfileUI.dart';

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
            onPressed: () async {
              if (emlController.text.isEmpty || pwdController.text.isEmpty) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(INCOMPLETEFIELDSMSG),
                ));
              } else {
                var conn = new ConnectDB();
                var result = await conn.logInDb(emlController, pwdController);
                // if (result == USEREXIST) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileUI()));
                //}
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
