import 'package:http/http.dart' as http;
import './Constants.dart';

class ConnectDB {
  //register a new user
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
  }

  //Verify if the user exist in the db
  Future<String> logInDb(email, pswd) async {
    final response = await http.post(
      LOGINUSERCRED,
      body: {
        "email": email.text,
        "password": pswd.text,
      },
    );
    return Future.delayed(Duration(seconds: 2), () => response.body);
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
    return Future.delayed(Duration(seconds: 2), () => response.body);
  }
}
