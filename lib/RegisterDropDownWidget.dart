/*import 'package:flutter/material.dart';
import '../Constants.dart';

class RegisterDropDownWidget extends StatefulWidget {

  String inGen;

  RegisterDropDownWidget(this.inGen);

  @override
  _RegisterDropDownWidgetState createState() => _RegisterDropDownWidgetState(inGen);
}

class _RegisterDropDownWidgetState extends State<RegisterDropDownWidget> {

  String inputGenderArg;

  _RegisterDropDownWidgetState(this.inputGenderArg);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
          hint: Text(GENDER),
          value: inputGenderArg,
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
          inputGenderArg = newValue;
          print(inputGenderArg);
          });
          },
          items: [
                DropdownMenuItem(
                  child: Text(MALE),
                  value: MALE,
                ),
                DropdownMenuItem(
                  child: Text(FEMALE),
                  value: FEMALE,
                ),
              ],
          );
  }
}*/