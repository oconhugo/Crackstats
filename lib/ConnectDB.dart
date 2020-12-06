import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './Constants.dart';

class ConnectDB {
  Future<List> sendData(registerFields, genderinput) async {
    await http.post(
      INSERTDATAURL,
      body: {
        "name": registerFields[FIRSTNAME],
        "email": registerFields[EMAIL],
        "last_name": registerFields[LASTNAME],
        "dob": registerFields[DATEOFBIRTH],
        "gender": genderinput,
        "password": registerFields[PASSWORD],
      },
    );
  }
}
