import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';
import '../LogIn/LogInUI.dart';

class ForgotPasswordPopUp {
  String message;

  ForgotPasswordPopUp(this.message);

  Future<void> showMyDialog(context, emailSuccess) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: (emailSuccess) ? Text(EMAILSENT) : Text(EMAILNOTSENT),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(OK),
              onPressed: (emailSuccess)
                  ? () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }
                  : () {
                      Navigator.of(context).pop();
                    },
            ),
          ],
        );
      },
    );
  }
}
