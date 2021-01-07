import 'package:http/http.dart' as http;
import './Constants.dart';
import 'dart:convert';

class ConnectDB {
  //register a new user
  Future<String> sendData(registerFields, genderinput) async {
    //print(registerFields[DATEOFBIRTH]);
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
    return Future.delayed(Duration(milliseconds: 1), () => response.body);
  }

  //Verify if the user exist in the db
  Future<Map> logInDb(email, pswd) async {
    final response = await http.post(
      LOGINUSERCRED,
      body: {
        "email": email,
        "password": pswd,
      },
    );

    try {
      Map<String, dynamic> user = jsonDecode(response.body);
      userEmailGlobal = user['Email'];
      userPasswordGlobal = user['Password'];
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //Add temporal password to db
  Future<String> tempPswUpdate(email, pwd) async {
    final response = await http.post(
      TEMPORALPASSWORDUPDATEURL,
      body: {
        "email": email.text,
        "password": pwd,
      },
    );
    return Future.delayed(Duration(milliseconds: 1), () => response.body);
  }

  //Update the user credentials
  Future<Map> updateCred(newUserInfo) async {
    final response = await http.post(
      MODIFYCREDURL,
      body: {
        "name": newUserInfo[FIRSTNAME],
        "email": newUserInfo[EMAIL],
        "last_name": newUserInfo[LASTNAME],
        "dob": newUserInfo[DATEOFBIRTH],
        "password": newUserInfo[PASSWORD],
      },
    );

    try {
      Map<String, dynamic> user = jsonDecode(response.body);
      userPasswordGlobal = user['Password'];
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  Future retrieveLeagues() async {
    final response = await http.post(
      RETRIEVEUSERLEAGUES,
      body: {"email": userEmailGlobal},
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  Future retrieveUserStats(league) async {
    final response = await http.post(
      RETRIEVEUSERSTATS,
      body: {"email": userEmailGlobal, "league": league},
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  Future retrieveLeagueTeams(league) async {
    final response = await http.post(
      RETRIEVELEAGUETEAMS,
      body: {"league": league},
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

}
