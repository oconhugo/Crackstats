import 'package:crackstats/Register/RegisterPopUp.dart';

import '../Register/RegisterInTxtWidget.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';

class RegisterBodyWidget extends StatefulWidget {
  @override
  _RegisterBodyWidgetState createState() => _RegisterBodyWidgetState();
}

class _RegisterBodyWidgetState extends State<RegisterBodyWidget> {
  var registerFields = {
    FIRSTNAME: '',
    LASTNAME: '',
    EMAIL: '',
    DATEOFBIRTH: '',
    PASSWORD: '',
    REENTERPASSWORD: '',
  };

  String inputGender;

  final dropDownItems = [
    DropdownMenuItem(
      child: Text(MALE),
      value: MALE,
    ),
    DropdownMenuItem(
      child: Text(FEMALE),
      value: FEMALE,
    ),
  ];

  void regButton() async {
    var result;
    var regPop = RegisterPopUp();
    var insert = new ConnectDB();
    if (areFieldsCorrect()) {
      result = await insert.sendData(registerFields, inputGender);
    }
    if (!isDuplicate(result)) { //change is duplicate to check for query error and duplicate?
      regPop.showMyDialog(context, true);
    }
    else{
      regPop.showMyDialog(context, false);
    }
  }

  bool isDuplicate(response) {
    if (response == USERADDED) {
      return false;
    }
    return true;
  }

  bool areFieldsCorrect() {
    if (registerFields[PASSWORD] != registerFields[REENTERPASSWORD]) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(PASSWORDMATCHNOTICE),
      ));
      return false;
    } else if (registerFields[PASSWORD].length < 6) {
      Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(PASSWORDREQUIREMENTS),
      ));
      return false;
    } else if (registerFields[FIRSTNAME].isEmpty ||
        registerFields[LASTNAME].isEmpty ||
        registerFields[EMAIL].isEmpty ||
        registerFields[DATEOFBIRTH].isEmpty ||
        registerFields[PASSWORD].isEmpty ||
        registerFields[REENTERPASSWORD].isEmpty ||
        inputGender == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(INCOMPLETEFIELDSMSG),
      ));
      return false;
      //els if Show message if email already has account
      //else ifRegister user in database if not
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...(registerFields.keys).map((valkey) {
          return RegisterInTxtWidget(registerFields, valkey);
        }).toList(),
        Container(
            width: MediaQuery.of(context).size.width / 2,
            child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(GENDER),
                value: inputGender,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 24,
                style: TextStyle(color: PRIMARYCOLOR),
                underline: Container(
                  height: 2,
                  color: PRIMARYCOLOR,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    inputGender = newValue;
                  });
                },
                items: dropDownItems)),
        RaisedButton(
          color: PRIMARYCOLOR,
          textColor: WHITE,
          child: Text(REGISTER),
          onPressed: () {
            regButton();
            //Navigator.pop(context);
          },
        ),
      ],
    ));
  }
}
