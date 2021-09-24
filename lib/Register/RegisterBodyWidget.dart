import 'package:crackstats/Register/RegisterPopUp.dart';

import '../Register/RegisterInTxtWidget.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';
import '../ConnectDB.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

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

  //Encode the password
  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  //Encrypt the password with salt added
  encryptPassword(registerInfoMap) {
    String temp = registerInfoMap[PASSWORD].substring(0, 2) +
        SALT +
        registerInfoMap[PASSWORD]
            .substring(3, registerInfoMap[PASSWORD].length);
    registerInfoMap[PASSWORD] = generateMd5(temp);
  }

  //Verify user inputs
  void regButton() async {
    var result;
    var regPop = new RegisterPopUp();
    var insert = new ConnectDB();
    if (areFieldsCorrect()) {
      encryptPassword(registerFields);
      result = await insert.sendData(registerFields, inputGender);
      print("hola");
      print(result);
    }
    if (!isDuplicate(result)) {
      regPop.showMyDialog(context, true);
    } else {
      regPop.showMyDialog(context, false);
    }
  }

  //Check for duplicates
  bool isDuplicate(response) {
    if (response == USERADDED) return false;
    return true;
  }

  //Check fields standards
  bool areFieldsCorrect() {
    if (registerFields[PASSWORD] != registerFields[REENTERPASSWORD]) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(PASSWORDMATCHNOTICE),
      ));
      return false;
    } else if (registerFields[PASSWORD].length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(INCOMPLETEFIELDSMSG),
      ));
      return false;
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
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return PRIMARYCOLOR;
              },
            ),
          ),
          child: Text(REGISTER),
          onPressed: () {
            regButton();
          },
        ),
      ],
    ));
  }
}
