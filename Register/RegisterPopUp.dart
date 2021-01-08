import 'package:crackstats/Constants.dart';
import 'package:flutter/material.dart';
import '../LogIn/LogInUI.dart';

class RegisterPopUp {
  Future<void> showMyDialog(context, isSuccess) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: (isSuccess) ? Text(REGISTERED) : Text(NOTREGISTERED),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                (isSuccess) ? Text(REGISTEREDMSG) : Text(NOTREGISTEREDMSG),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(OK),
              onPressed: (isSuccess)
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
