import 'package:crackstats/Register/RegisterInTxtWidget.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

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

  void regButton(){
    if(registerFields[PASSWORD] != registerFields[REENTERPASSWORD]){
              Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(PASSWORDMATCHNOTICE),
              ));
            }
            else if(registerFields[PASSWORD].length < 6){
              Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text(PASSWORDREQUIREMENTS),
              ));
            }
            else if(registerFields[FIRSTNAME].isEmpty || registerFields[LASTNAME].isEmpty || registerFields[EMAIL].isEmpty 
            || registerFields[DATEOFBIRTH].isEmpty || registerFields[PASSWORD].isEmpty || registerFields[REENTERPASSWORD].isEmpty
            || inputGender==null){
              Scaffold.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text(INCOMPLETEFIELDSMSG),
              ));
            //els if Show message if email already has account
            //else ifRegister user in database if not
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
        child:DropdownButton<String>(
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
          items: dropDownItems
          )),
          RaisedButton(
          color: PRIMARYCOLOR,
          textColor: WHITE,
          child: Text(REGISTER),
          onPressed: regButton,
        ),
      ],
    ));
  }
}
