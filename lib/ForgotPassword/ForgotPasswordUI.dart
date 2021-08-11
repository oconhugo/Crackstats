///Sends a code to your email to reset the password. Verify if the email exists in the db///

import 'package:flutter/material.dart';
import '../Constants.dart';
import 'SendEmail.dart';
import 'ForgotPasswordPopUp.dart';
import '../ConnectDB.dart';
import 'package:random_string/random_string.dart';

class ForgotPasswordUI extends StatefulWidget {
  @override
  _ForgotPasswordUIState createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  TextEditingController emailfgtController = new TextEditingController();
  String pswCode = randomAlphaNumeric(20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: PRIMARYCOLOR,
        ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            FORGOTPASSWORDMESSAGE,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: TextField(
                controller: emailfgtController,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                  hintText: EMAIL,
                ),
              )),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return PRIMARYCOLOR; // Use the component's default.
              },
            )),
            child: Text(SENDCODE),
            onPressed: () async {
              var mailInstance =
                  new SendEmail(emailfgtController.text, pswCode);
              var chngOnDB = new ConnectDB();
              var isPswdChanged =
                  await chngOnDB.tempPswUpdate(emailfgtController, pswCode);
              var isSend = await mailInstance.sendmail();
              if (isSend == 'true' && isPswdChanged == 'Password Changed') {
                var pswpop = new ForgotPasswordPopUp(EMAILSENTMSG);
                pswpop.showMyDialog(context, true);
              } else {
                var pswpop = new ForgotPasswordPopUp(EMAILNOTSENTMSG);
                pswpop.showMyDialog(context, false);
              }
            },
          )
        ],
      )),
    );
  }
}
