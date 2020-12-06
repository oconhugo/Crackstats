import 'dart:convert';

import 'package:http/http.dart' as http;
import './Constants.dart';

class ConnectDB {
  Future<String> sendData(registerFields, genderinput) async {
    final response = await http.post(
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
    return Future.delayed(Duration(seconds: 2), () => response.body);
    //if (!isDuplicate(response.body)) return response;
  }
}
