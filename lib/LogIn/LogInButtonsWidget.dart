/// Log in into the app ///

import 'package:crackstats/ForgotPassword/ForgotPasswordUI.dart';
import '../ConnectDB.dart';
import '../Constants.dart';
import 'package:flutter/material.dart';
import '../Register/RegisterUI.dart';
import '../Profile/ProfileUI.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LogInButtonsWidget extends StatelessWidget {
  final TextEditingController emlController;
  final TextEditingController pwdController;

  LogInButtonsWidget(this.emlController, this.pwdController);

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  //Encrypt the password with the salt added
  String encryptPassword(pwdString) {
    String temp = pwdString.substring(0, 2) +
        SALT +
        pwdString.substring(3, pwdString.length);
    pwdString = generateMd5(temp);
    print(pwdString);
    return pwdString;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextButton(
            child: Text(FORGOTPASSWORD),
            style: TextButton.styleFrom(
              primary: BLUE,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordUI(),
                  ));
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return PRIMARYCOLOR; // Use the component's default.
                },
              ),
            ),
            child: Text(SIGNIN),
            onPressed: () async {
              if (emlController.text.isEmpty || pwdController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(INCOMPLETEFIELDSMSG),
                ));
              } else {
                var conn = new ConnectDB();
                var result = await conn.logInDb(
                    emlController.text, encryptPassword(pwdController.text));
                if (result == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text(USERDOESNTEXISTMESSAGE),
                  ));
                } else {
                  globalUserType = result['usertype'];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileUI(result)));
                }
              }
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return PRIMARYCOLOR; // Use the component's default.
                },
              ),
            ),
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
